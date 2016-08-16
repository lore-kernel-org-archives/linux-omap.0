From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
Date: Tue, 16 Aug 2016 12:23:43 +0200
Message-ID: <2B099E26-62C8-4778-B701-F727BB3FC110@holtmann.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org> <1471058078-5579-6-git-send-email-sre@kernel.org> <0528B894-39CB-4D18-971E-3209EEEA2583@holtmann.org> <20160816090952.ur35t5bbcr7hsxvj@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160816090952.ur35t5bbcr7hsxvj@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, =?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

>>> +	if (err < 0) {
>>> +		BT_ERR("%s: Failed to load Nokia firmware file (%d)",
>>> +		       hu->hdev->name, err);
>>> +		return err;
>>> +	}
>>> +
>>> +	fw_ptr = fw->data;
>>> +	fw_size = fw->size;
>>> +
>>> +	while (fw_size >= 4) {
>>> +		u16 pkt_size = get_unaligned_le16(fw_ptr);
>>> +		u8 pkt_type = fw_ptr[2];
>>> +		const struct hci_command_hdr *cmd;
>>> +		u16 opcode;
>>> +		struct sk_buff *skb;
>>> +
>>> +		switch (pkt_type) {
>>> +		case HCI_COMMAND_PKT:
>>> +			cmd = (struct hci_command_hdr *)(fw_ptr + 3);
>>> +			opcode = le16_to_cpu(cmd->opcode);
>>> +
>>> +			skb = __hci_cmd_sync(hu->hdev, opcode, cmd->plen,
>>> +					     fw_ptr + 3 + HCI_COMMAND_HDR_SIZE,
>>> +					     HCI_INIT_TIMEOUT);
>>> +			if (IS_ERR(skb)) {
>>> +				err = PTR_ERR(skb);
>>> +				BT_ERR("%s: Firmware command %04x failed (%d)",
>>> +				       hu->hdev->name, opcode, err);
>>> +				goto done;
>>> +			}
>>> +			kfree_skb(skb);
>>> +			break;
>>> +		case HCI_NOKIA_RADIO_PKT:
>> 
>> Are you sure you can ignore the RADIO_PKT commands. They are used
>> to set up the FM radio parts of the chip. They are standard HCI
>> commands (in the case of Broadcom at least). At minimum it should
>> be added a comment here that you are ignoring them on purpose.
> 
> I got the driver working on N950. I think it does not make use of
> the radio packets at all. On N900 they may be needed, though. I do
> not reach far enough in the firmware loading process to know for
> sure.
> 
> If I remember correctly your template driver does bundle it together
> with HCI_COMMAND_PKT, but that does not work, since HCI_NOKIA_RADIO_PKT
> opcode size is u8 instead of u16. I ignored it for now, since I
> could not properly test it.

that sounds heavily like a bug somehow. I remember having decoded the Broadcom firmware and there it really has to go via standard HCI command. And that is the default Broadcom FM radio command.

My assumption was that it was an initial misunderstanding by the driver itself. Can someone send me all the Nokia firmware files and I have a look at them.

> 
>>> +		case HCI_NOKIA_NEG_PKT:
>>> +		case HCI_NOKIA_ALIVE_PKT:
>> 
>> And here I would also a comment on why are we ignore these
>> commands and driving this all by ourselves.
> 
> I think we could use the packets from the firmware instead
> of doing it manually (On N900 they are bit identical to the
> manually generated one - On N950 I have not yet checked), but
> until N900 works having it coded explicitly helps debugging.

We can also always manually encode the firmware to do it correctly. At the end of the day, the firmware should go into linux-firmware tree anyway.

>>> +
>>> +#define NOKIA_ID_CSR		0x02
>>> +#define NOKIA_ID_BCM2048	0x04
>>> +#define NOKIA_ID_TI1271		0x31
>>> +
>>> +#define FIRMWARE_CSR		"nokia/bc4fw.bin"
>> 
>> If the CSR ones are not yet supported, then leave them out for
>> now. We can add this later.
>> 
>>> +#define FIRMWARE_BCM2048	"nokia/bcmfw.bin"
>>> +#define FIRMWARE_TI1271		"nokia/ti1273.bin"
>>> +
>>> +#define NOKIA_BCM_BDADDR	0xfc01
>> 
>> We have btbcm.[ch] for this.
> 
> ah this is a leftover. Currently the driver does not set
> set_bdaddr() callback, since it differs between ti and bcm backend.
> It looks like btbcm_set_bdaddr() can be used for the broadcom based
> chips, though.

Yes. For the Broadcom chip, just select the btbcm_set_bdaddr and set the module dependency correctly. We already do that for hci_bcm.c anyway. For the TI one, extra the opcode for from the original driver and just add a TI function inside the driver. I think adding a btti.c module is overkill at the moment. We can extract that later. Even btusb.c carries some set_bdaddr function in the main driver where splitting them out made no sense at the moment.

> 
>>> +#define HCI_NOKIA_NEG_PKT	0x06
>>> +#define HCI_NOKIA_ALIVE_PKT	0x07
>>> +#define HCI_NOKIA_RADIO_PKT	0x08
>>> +
>>> +#define HCI_NOKIA_NEG_HDR_SIZE		1
>>> +#define HCI_NOKIA_MAX_NEG_SIZE		255
>>> +#define HCI_NOKIA_ALIVE_HDR_SIZE	1
>>> +#define HCI_NOKIA_MAX_ALIVE_SIZE	255
>>> +#define HCI_NOKIA_RADIO_HDR_SIZE	2
>>> +#define HCI_NOKIA_MAX_RADIO_SIZE	255
>>> +
>>> +#define NOKIA_PROTO_PKT		0x44
>>> +#define NOKIA_PROTO_BYTE	0x4c
>>> +
>>> +#define NOKIA_NEG_REQ		0x00
>>> +#define NOKIA_NEG_ACK		0x20
>>> +#define NOKIA_NEG_NAK		0x40
>>> +
>>> +#define H4_TYPE_SIZE		1
>> 
>> I am not sure this define adds any overall value to the code.
>> 
>>> +
>>> +#define NOKIA_RECV_ACL \
>>> +	H4_RECV_ACL, \
>>> +	.wordaligned = true
>>> +
>>> +#define NOKIA_RECV_SCO \
>>> +	H4_RECV_SCO, \
>>> +	.wordaligned = true
>>> +
>>> +#define NOKIA_RECV_EVENT \
>>> +	H4_RECV_EVENT, \
>>> +	.wordaligned = true
>>> +
>>> +#define NOKIA_RECV_ALIVE \
>>> +	.type = HCI_NOKIA_ALIVE_PKT, \
>>> +	.hlen = HCI_NOKIA_ALIVE_HDR_SIZE, \
>>> +	.loff = 0, \
>>> +	.lsize = 1, \
>>> +	.maxlen = HCI_NOKIA_MAX_ALIVE_SIZE, \
>>> +	.wordaligned = true
>>> +
>>> +#define NOKIA_RECV_NEG \
>>> +	.type = HCI_NOKIA_NEG_PKT, \
>>> +	.hlen = HCI_NOKIA_NEG_HDR_SIZE, \
>>> +	.loff = 0, \
>>> +	.lsize = 1, \
>>> +	.maxlen = HCI_NOKIA_MAX_NEG_SIZE, \
>>> +	.wordaligned = true
>>> +
>>> +#define NOKIA_RECV_RADIO \
>>> +	.type = HCI_NOKIA_RADIO_PKT, \
>>> +	.hlen = HCI_NOKIA_RADIO_HDR_SIZE, \
>>> +	.loff = 1, \
>>> +	.lsize = 1, \
>>> +	.maxlen = HCI_NOKIA_MAX_RADIO_SIZE, \
>>> +	.wordaligned = true
>> 
>> For this ones I would have use the HCI event ones.
>> My original patch had this:
>> 
>> +#define NOK_RECV_NEG \
>> +	.type = NOK_NEG_PKT, \
>> +	.hlen = NOK_NEG_HDR_SIZE, \
>> +	.loff = 0, \
>> +	.lsize = 1, \
>> +	.maxlen = HCI_MAX_EVENT_SIZE
>> +
>> +#define NOK_RECV_ALIVE \
>> +	.type = NOK_ALIVE_PKT, \
>> +	.hlen = NOK_ALIVE_HDR_SIZE, \
>> +	.loff = 0, \
>> +	.lsize = 1, \
>> +	.maxlen = HCI_MAX_EVENT_SIZE
>> +
>> +#define NOK_RECV_RADIO \
>> +	.type = NOK_RADIO_PKT, \
>> +	.hlen = HCI_EVENT_HDR_SIZE, \
>> +	.loff = 1, \
>> +	.lsize = 1, \
>> +	.maxlen = HCI_MAX_EVENT_SIZE
>> +
>> +static const struct h4_recv_pkt nok_recv_pkts[] = {
>> +	{ H4_RECV_ACL,    .recv = hci_recv_frame },
>> +	{ H4_RECV_SCO,    .recv = hci_recv_frame },
>> +	{ H4_RECV_EVENT,  .recv = hci_recv_frame },
>> +	{ NOK_RECV_NEG,   .recv = nok_recv_neg   },
>> +	{ NOK_RECV_ALIVE, .recv = nok_recv_alive },
>> +	{ NOK_RECV_RADIO, .recv = nok_recv_radio },
>> 
>> With just these simple defines at the top:
>> 
>> +#define NOK_NEG_PKT	0x06
>> +#define NOK_ALIVE_PKT	0x07
>> +#define NOK_RADIO_PKT	0x08
>> +
>> +#define NOK_NEG_HDR_SIZE	1
>> +#define NOK_ALIVE_HDR_SIZE	1
>> 
>> And I would prefer if we keep it like that.
> 
> ok. I used explicit defines, since it looks like
> a copy/paste error otherwise.

With the .align setting you also need to introduce NOK_RECV_ACL etc. with complete definition anyway. Just make sure to use the HCI_* defines where possible.

An alternative is to add the align parameter to h4_recv_buf. Which might be the better idea anyway since I doubt the alignment only applies to a single packet type. It should apply to all of them since otherwise it makes no sense.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
