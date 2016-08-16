From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
Date: Tue, 16 Aug 2016 09:52:17 +0200
Message-ID: <20160816075217.GK30047@pali>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-6-git-send-email-sre@kernel.org>
 <0528B894-39CB-4D18-971E-3209EEEA2583@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0528B894-39CB-4D18-971E-3209EEEA2583@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 16 August 2016 09:02:14 Marcel Holtmann wrote:
> > +static int nokia_setup_fw(struct hci_uart *hu)
> > +{
> > +	struct nokia_bt_dev *btdev = hu->priv;
> > +	const struct firmware *fw;
> > +	const u8 *fw_ptr;
> > +	size_t fw_size;
> > +	int err;
> > +
> > +	BT_DBG("hu %p", hu);
> > +
> > +	err = request_firmware(&fw, nokia_get_fw_name(btdev), hu->tty->dev);
> 
> So does this nokia_get_fw_name really needs to be a separate function? Or can this just be done right here in this function? I prefer it to be done where it is actually used. Unless you use that name in many places.
> 
> > +	if (err < 0) {
> > +		BT_ERR("%s: Failed to load Nokia firmware file (%d)",
> > +		       hu->hdev->name, err);
> > +		return err;
> > +	}
> > +
> > +	fw_ptr = fw->data;
> > +	fw_size = fw->size;
> > +
> > +	while (fw_size >= 4) {
> > +		u16 pkt_size = get_unaligned_le16(fw_ptr);
> > +		u8 pkt_type = fw_ptr[2];
> > +		const struct hci_command_hdr *cmd;
> > +		u16 opcode;
> > +		struct sk_buff *skb;
> > +
> > +		switch (pkt_type) {
> > +		case HCI_COMMAND_PKT:
> > +			cmd = (struct hci_command_hdr *)(fw_ptr + 3);
> > +			opcode = le16_to_cpu(cmd->opcode);
> > +
> > +			skb = __hci_cmd_sync(hu->hdev, opcode, cmd->plen,
> > +					     fw_ptr + 3 + HCI_COMMAND_HDR_SIZE,
> > +					     HCI_INIT_TIMEOUT);
> > +			if (IS_ERR(skb)) {
> > +				err = PTR_ERR(skb);
> > +				BT_ERR("%s: Firmware command %04x failed (%d)",
> > +				       hu->hdev->name, opcode, err);
> > +				goto done;
> > +			}
> > +			kfree_skb(skb);
> > +			break;
> > +		case HCI_NOKIA_RADIO_PKT:
> 
> Are you sure you can ignore the RADIO_PKT commands. They are used to set up the FM radio parts of the chip. They are standard HCI commands (in the case of Broadcom at least). At minimum it should be added a comment here that you are ignoring them on purpose.
> 
> > +		case HCI_NOKIA_NEG_PKT:
> > +		case HCI_NOKIA_ALIVE_PKT:
> 
> And here I would also a comment on why are we ignore these commands and driving this all by ourselves.
> 

Good question... In Pavel's version of bluetooth driver, which is
working on Nokia N900, is sent whole firmware at one __hci_cmd_sync
step. It does not skip any packets, plus he added this comment:

/* Note that this is timing-critical. If sending packets takes
 * too long, initialization will fail.
 */

So really, can we skip those packets? And is not this reason why
this bluetooth driver does not work on Nokia N900?

-- 
Pali Rohár
pali.rohar@gmail.com
