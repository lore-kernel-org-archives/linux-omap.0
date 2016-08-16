From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
Date: Tue, 16 Aug 2016 11:09:52 +0200
Message-ID: <20160816090952.ur35t5bbcr7hsxvj@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-6-git-send-email-sre@kernel.org>
 <0528B894-39CB-4D18-971E-3209EEEA2583@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ih4qhin7qfdlbn7f"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0528B894-39CB-4D18-971E-3209EEEA2583-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--ih4qhin7qfdlbn7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, Aug 16, 2016 at 09:02:14AM +0200, Marcel Holtmann wrote:
> [...]
> > +#include <linux/module.h>
> > +
> > +#include <linux/clk.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/types.h>
> > +#include <linux/fcntl.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/ptrace.h>
> > +#include <linux/poll.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/firmware.h>
> > +#include <linux/slab.h>
> > +#include <linux/tty.h>
> > +#include <linux/errno.h>
> > +#include <linux/string.h>
> > +#include <linux/signal.h>
> > +#include <linux/ioctl.h>
> > +#include <linux/skbuff.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <linux/gpio/consumer.h>
> > +
> > +#include <linux/unaligned/le_struct.h>
>=20
> are you sure all these includes are needed?

No. A few of them are from previous version of
the driver. I will clean this up in the next
version.

> [...]
> > +static int hci_uart_wait_for_cts(struct hci_uart *hu, bool state,
> > +				 int timeout_ms)
> > +{
> > +	unsigned long timeout;
> > +	int signal;
> > +
> > +	timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
> > +	for (;;) {
> > +		signal =3D hu->tty->ops->tiocmget(hu->tty) & TIOCM_CTS;
> > +		if (!!signal =3D=3D !!state) {
> > +			dev_dbg(hu->tty->dev, "wait for cts... received!\n");
> > +			return 0;
> > +		}
> > +		if (time_after(jiffies, timeout)) {
> > +			dev_dbg(hu->tty->dev, "wait for cts... timeout!\n");
> > +			return -ETIMEDOUT;
> > +		}
> > +		usleep_range(1000, 2000);
> > +	}
> > +}
>=20
> This is a super odd function. No return value since we essentially
> have an endless loop.

I will rewrite it, so that the loop condition checks for timeout.

> > +
> > +static int btdev_match(struct device *child, void *data)
> > +{
> > +	if (!strcmp(child->driver->name, "nokia-bluetooth"))
> > +		return 1;
> > +	else
> > +		return 0;
> > +}
>=20
> Anything wrong with just return !strcmp?

No. I had initially debug prints in the cases.

> > +static int nokia_send_alive_packet(struct hci_uart *hu)
> > +{
> > +	struct nokia_bt_dev *btdev =3D hu->priv;
> > +	struct hci_nokia_alive_hdr *hdr;
> > +	struct hci_nokia_alive_pkt *pkt;
> > +	struct sk_buff *skb;
> > +	int len;
> > +
> > +	dev_dbg(hu->tty->dev, "Sending alive packet...\n");
> > +
> > +	init_completion(&btdev->init_completion);
> > +
> > +	len =3D H4_TYPE_SIZE + sizeof(*hdr) + sizeof(*pkt);
> > +	skb =3D bt_skb_alloc(len, GFP_KERNEL);
> > +	if (!skb)
> > +		return -ENOMEM;
> > +
> > +	hci_skb_pkt_type(skb) =3D HCI_NOKIA_ALIVE_PKT;
> > +	memset(skb->data, 0x00, len);
> > +
> > +	hdr =3D (struct hci_nokia_alive_hdr *)skb_put(skb, sizeof(*hdr));
> > +	hdr->dlen =3D sizeof(*pkt);
> > +	pkt =3D (struct hci_nokia_alive_pkt *)skb_put(skb, sizeof(*pkt));
> > +	pkt->mid =3D NOKIA_ALIVE_REQ;
> > +
> > +	hu->hdev->send(hu->hdev, skb);
>=20
> I am not sure we want these to go through the Bluetooth core
> packet sending. They are not standard HCI packet and should stay
> within the driver. If you send them through the core they will
> cause problems with the monitor interface.

ok. I will directly call nokia_enqueue().

> > +
> > +	if (!wait_for_completion_interruptible_timeout(&btdev->init_completio=
n,
> > +		msecs_to_jiffies(1000))) {
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	if (btdev->init_error < 0)
> > +		return btdev->init_error;
> > +
> > +	return 0;
> > +}
> > +
> > +static int nokia_send_negotiation(struct hci_uart *hu)
> > +{
> > +	struct nokia_bt_dev *btdev =3D hu->priv;
> > +	struct hci_nokia_neg_cmd *neg_cmd;
> > +	struct hci_nokia_neg_hdr *neg_hdr;
> > +	struct sk_buff *skb;
> > +	int len, err;
> > +	u16 baud =3D DIV_ROUND_CLOSEST(BT_BAUDRATE_DIVIDER, MAX_BAUD_RATE);
> > +	int sysclk =3D btdev->btdata->sysclk_speed / 1000;
> > +
> > +	dev_dbg(hu->tty->dev, "Sending negotiation...\n");
> > +
> > +	len =3D H4_TYPE_SIZE + sizeof(*neg_hdr) + sizeof(*neg_cmd);
> > +	skb =3D bt_skb_alloc(len, GFP_KERNEL);
> > +	if (!skb)
> > +		return -ENOMEM;
> > +
> > +	hci_skb_pkt_type(skb) =3D HCI_NOKIA_NEG_PKT;
> > +
> > +	neg_hdr =3D (struct hci_nokia_neg_hdr *)skb_put(skb, sizeof(*neg_hdr)=
);
> > +	neg_hdr->dlen =3D sizeof(*neg_cmd);
> > +
> > +	neg_cmd =3D (struct hci_nokia_neg_cmd *)skb_put(skb, sizeof(*neg_cmd)=
);
> > +	neg_cmd->ack =3D NOKIA_NEG_REQ;
> > +	neg_cmd->baud =3D cpu_to_le16(baud);
> > +	neg_cmd->unused1 =3D 0x0000;
> > +	neg_cmd->proto =3D NOKIA_PROTO_BYTE;
> > +	neg_cmd->sys_clk =3D cpu_to_le16(sysclk);
> > +	neg_cmd->unused2 =3D 0x0000;
> > +
> > +	btdev->init_error =3D 0;
> > +	init_completion(&btdev->init_completion);
> > +
> > +	hu->hdev->send(hu->hdev, skb);
> > +
> > +	if (!wait_for_completion_interruptible_timeout(&btdev->init_completio=
n,
> > +		msecs_to_jiffies(10000))) {
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	if (btdev->init_error < 0)
> > +		return btdev->init_error;
> > +
> > +	/* Change to operational settings */
> > +	hci_uart_set_flow_control(hu, true); // disable flow control
>=20
> Please use a proper comment that explains also
> disabling flow control.

ok.

> > +
> > +	/* setup negotiated max. baudrate */
> > +	hci_uart_set_baudrate(hu, MAX_BAUD_RATE);
> > +
> > +	err =3D hci_uart_wait_for_cts(hu, true, 100);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	hci_uart_set_flow_control(hu, false); // re-enable flow control
> > +
> > +	dev_dbg(hu->tty->dev, "Negotiation successful...\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int nokia_setup_fw(struct hci_uart *hu)
> > +{
> > +	struct nokia_bt_dev *btdev =3D hu->priv;
> > +	const struct firmware *fw;
> > +	const u8 *fw_ptr;
> > +	size_t fw_size;
> > +	int err;
> > +
> > +	BT_DBG("hu %p", hu);
> > +
> > +	err =3D request_firmware(&fw, nokia_get_fw_name(btdev), hu->tty->dev);
>=20
> So does this nokia_get_fw_name really needs to be a separate
> function? Or can this just be done right here in this function? I
> prefer it to be done where it is actually used. Unless you use
> that name in many places.

I inlined it and dropped CSR support.

> > +	if (err < 0) {
> > +		BT_ERR("%s: Failed to load Nokia firmware file (%d)",
> > +		       hu->hdev->name, err);
> > +		return err;
> > +	}
> > +
> > +	fw_ptr =3D fw->data;
> > +	fw_size =3D fw->size;
> > +
> > +	while (fw_size >=3D 4) {
> > +		u16 pkt_size =3D get_unaligned_le16(fw_ptr);
> > +		u8 pkt_type =3D fw_ptr[2];
> > +		const struct hci_command_hdr *cmd;
> > +		u16 opcode;
> > +		struct sk_buff *skb;
> > +
> > +		switch (pkt_type) {
> > +		case HCI_COMMAND_PKT:
> > +			cmd =3D (struct hci_command_hdr *)(fw_ptr + 3);
> > +			opcode =3D le16_to_cpu(cmd->opcode);
> > +
> > +			skb =3D __hci_cmd_sync(hu->hdev, opcode, cmd->plen,
> > +					     fw_ptr + 3 + HCI_COMMAND_HDR_SIZE,
> > +					     HCI_INIT_TIMEOUT);
> > +			if (IS_ERR(skb)) {
> > +				err =3D PTR_ERR(skb);
> > +				BT_ERR("%s: Firmware command %04x failed (%d)",
> > +				       hu->hdev->name, opcode, err);
> > +				goto done;
> > +			}
> > +			kfree_skb(skb);
> > +			break;
> > +		case HCI_NOKIA_RADIO_PKT:
>=20
> Are you sure you can ignore the RADIO_PKT commands. They are used
> to set up the FM radio parts of the chip. They are standard HCI
> commands (in the case of Broadcom at least). At minimum it should
> be added a comment here that you are ignoring them on purpose.

I got the driver working on N950. I think it does not make use of
the radio packets at all. On N900 they may be needed, though. I do
not reach far enough in the firmware loading process to know for
sure.

If I remember correctly your template driver does bundle it together
with HCI_COMMAND_PKT, but that does not work, since HCI_NOKIA_RADIO_PKT
opcode size is u8 instead of u16. I ignored it for now, since I
could not properly test it.

> > +		case HCI_NOKIA_NEG_PKT:
> > +		case HCI_NOKIA_ALIVE_PKT:
>=20
> And here I would also a comment on why are we ignore these
> commands and driving this all by ourselves.

I think we could use the packets from the firmware instead
of doing it manually (On N900 they are bit identical to the
manually generated one - On N950 I have not yet checked), but
until N900 works having it coded explicitly helps debugging.

> > +			break;
> > +		}
> > +
> > +		fw_ptr +=3D pkt_size + 2;
> > +		fw_size -=3D pkt_size + 2;
> > +	}
> > +
> > +done:
> > +	release_firmware(fw);
> > +	return err;
> > +}
> > +
> > +static int nokia_setup(struct hci_uart *hu)
> > +{
> > +	int err;
> > +
> > +	pm_runtime_get_sync(hu->tty->dev);
> > +
> > +	dev_dbg(hu->tty->dev, "Nokia H4+ protocol setup...\n");
> > +
> > +	/* 0. reset connection */
> > +	err =3D nokia_reset(hu);
> > +	if (err < 0) {
> > +		dev_err(hu->tty->dev, "Reset failed: %d\n", err);
> > +		goto out;
> > +	}
> > +
> > +	/* 1. negotiate speed etc */
> > +	err =3D nokia_send_negotiation(hu);
> > +	if (err < 0) {
> > +		dev_err(hu->tty->dev, "Negotiation failed: %d\n", err);
> > +		goto out;
> > +	}
> > +
> > +	/* 2. verify correct setup using alive packet */
> > +	err =3D nokia_send_alive_packet(hu);
> > +	if (err < 0) {
> > +		dev_err(hu->tty->dev, "Alive check failed: %d\n", err);
> > +		goto out;
> > +	}
> > +
> > +	/* 3. send firmware */
> > +	err =3D nokia_setup_fw(hu);
> > +	if (err < 0) {
> > +		dev_err(hu->tty->dev, "Could not setup FW: %d\n", err);
> > +		goto out;
> > +	}
> > +
> > +	hci_uart_set_flow_control(hu, true);
> > +	hci_uart_set_baudrate(hu, BC4_MAX_BAUD_RATE);
>=20
> I think this variable needs a better name if
> it is common for all vendors.

It is common. I will rename it to MAX_BAUD_RATE and
old MAX_BAUD_RATE to SETUP_BAUD_RATE.

> > +	hci_uart_set_flow_control(hu, false);
> > +
> > +	dev_dbg(hu->tty->dev, "Nokia H4+ protocol setup done!\n");
> > +
> > +	/*
> > +	 * TODO:
> > +	 * disable wakeup_bt at this point and automatically enable it when
> > +	 * data is about to be written until all data has been written (+ some
> > +	 * delay).
> > +	 *
> > +	 * Since this is not yet support by the uart/tty kernel framework we
> > +	 * will always keep enabled the wakeup_bt gpio for now, so that the
> > +	 * bluetooth chip will never transit into idle modes.
> > +	 */
> > +
> > +out:
> > +	pm_runtime_put(hu->tty->dev);
> > +
> > +	return err;
> > +}
> > +
> > +static int nokia_open(struct hci_uart *hu)
> > +{
> > +	struct device *serialdev =3D hu->tty->dev;
> > +	struct nokia_bt_dev *btdev;
> > +	struct device *uartbtdev;
> > +	int err;
> > +
> > +	btdev =3D kzalloc(sizeof(*btdev), GFP_KERNEL);
> > +	if (!btdev)
> > +		return -ENOMEM;
> > +
> > +	btdev->hu =3D hu;
> > +
> > +	skb_queue_head_init(&btdev->txq);
> > +
> > +	uartbtdev =3D device_find_child(serialdev, NULL, btdev_match);
> > +	if (!uartbtdev) {
> > +		dev_err(serialdev, "bluetooth device node not found!\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	btdev->btdata =3D dev_get_drvdata(uartbtdev);
> > +	if (!btdev->btdata)
> > +		return -EINVAL;
> > +
> > +	hu->priv =3D btdev;
> > +
> > +	/* register handler for host wakeup gpio */
> > +	btdev->wake_irq =3D gpiod_to_irq(btdev->btdata->wakeup_host);
> > +	err =3D request_threaded_irq(btdev->wake_irq, NULL, wakeup_handler,
> > +		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +		"wakeup", btdev);
> > +	if (err) {
> > +		gpiod_set_value(btdev->btdata->reset, 0);
> > +		gpiod_set_value(btdev->btdata->wakeup_bt, 0);
> > +		return err;
> > +	}
> > +
> > +	dev_dbg(serialdev, "Nokia H4+ protocol initialized with %s!\n",
> > +		dev_name(uartbtdev));
> > +
> > +	pm_runtime_enable(hu->tty->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int nokia_flush(struct hci_uart *hu)
> > +{
> > +	struct nokia_bt_dev *btdev =3D hu->priv;
> > +
> > +	BT_DBG("hu %p", hu);
> > +
> > +	skb_queue_purge(&btdev->txq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int nokia_close(struct hci_uart *hu)
> > +{
> > +	struct nokia_bt_dev *btdev =3D hu->priv;
> > +
> > +	hu->priv =3D NULL;
> > +
> > +	BT_DBG("hu %p", hu);
> > +
> > +	skb_queue_purge(&btdev->txq);
> > +
> > +	kfree_skb(btdev->rx_skb);
> > +
> > +	free_irq(btdev->wake_irq, btdev);
> > +
> > +	/* disable module */
> > +	gpiod_set_value(btdev->btdata->reset, 0);
> > +	gpiod_set_value(btdev->btdata->wakeup_bt, 0);
> > +
> > +	hu->priv =3D NULL;
> > +	kfree(btdev);
> > +
> > +	pm_runtime_disable(hu->tty->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Enqueue frame for transmittion (padding, crc, etc) */
> > +static int nokia_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> > +{
> > +	struct nokia_bt_dev *btdev =3D hu->priv;
> > +	int err;
> > +
> > +	BT_DBG("hu %p skb %p", hu, skb);
> > +
> > +	/* Prepend skb with frame type */
> > +	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
> > +
> > +	/* Packets must be word aligned */
> > +	if (skb->len % 2) {
> > +		err =3D skb_pad(skb, 1);
> > +		if (err)
> > +			return err;
> > +		*skb_put(skb, 1) =3D 0x00;
> > +	}
> > +
> > +	skb_queue_tail(&btdev->txq, skb);
> > +
> > +	return 0;
> > +}
> > +
> > +static int nokia_recv_negotiation_packet(struct hci_dev *hdev,
> > +					 struct sk_buff *skb)
> > +{
> > +	struct hci_uart *hu =3D hci_get_drvdata(hdev);
> > +	struct nokia_bt_dev *btdev =3D hu->priv;
> > +	struct hci_nokia_neg_hdr *hdr;
> > +	struct hci_nokia_neg_evt *evt;
> > +	int ret =3D 0;
> > +
> > +	hdr =3D (struct hci_nokia_neg_hdr *)skb->data;
> > +	if (hdr->dlen !=3D sizeof(*evt)) {
> > +		btdev->init_error =3D -EIO;
> > +		ret =3D -EIO;
> > +		goto finish_neg;
> > +	}
> > +
> > +	evt =3D (struct hci_nokia_neg_evt *)skb_pull(skb, sizeof(*hdr));
> > +
> > +	if (evt->ack !=3D NOKIA_NEG_ACK) {
> > +		dev_err(hu->tty->dev, "Could not negotiate hci_nokia settings\n");
> > +		btdev->init_error =3D -EINVAL;
> > +	}
> > +
> > +	btdev->man_id =3D evt->man_id;
> > +	btdev->ver_id =3D evt->ver_id;
> > +
> > +	dev_dbg(hu->tty->dev, "NOKIA negotiation:\n");
> > +	dev_dbg(hu->tty->dev, "\tbaudrate =3D %u\n", evt->baud);
> > +	dev_dbg(hu->tty->dev, "\tsystem clock =3D %u\n", evt->sys_clk);
> > +	dev_dbg(hu->tty->dev, "\tmanufacturer id =3D %u\n", evt->man_id);
> > +	dev_dbg(hu->tty->dev, "\tversion id =3D %u\n", evt->ver_id);
> > +
> > +finish_neg:
> > +	complete(&btdev->init_completion);
> > +	kfree_skb(skb);
> > +	return ret;
> > +}
> > +
> > +static int nokia_recv_alive_packet(struct hci_dev *hdev, struct sk_buf=
f *skb)
> > +{
> > +	struct hci_uart *hu =3D hci_get_drvdata(hdev);
> > +	struct nokia_bt_dev *btdev =3D hu->priv;
> > +	struct hci_nokia_alive_hdr *hdr;
> > +	struct hci_nokia_alive_pkt *pkt;
> > +	int ret =3D 0;
> > +
> > +	hdr =3D (struct hci_nokia_alive_hdr *)skb->data;
> > +	if (hdr->dlen !=3D sizeof(*pkt)) {
> > +		dev_err(hu->tty->dev, "Corrupted alive message\n");
> > +		btdev->init_error =3D -EIO;
> > +		ret =3D -EIO;
> > +		goto finish_alive;
> > +	}
> > +
> > +	pkt =3D (struct hci_nokia_alive_pkt *)skb_pull(skb, sizeof(*hdr));
> > +
> > +	if (pkt->mid !=3D NOKIA_ALIVE_RESP) {
> > +		dev_err(hu->tty->dev, "Invalid alive response: 0x%02x!\n",
> > +			pkt->mid);
> > +		btdev->init_error =3D -EINVAL;
> > +		goto finish_alive;
> > +	}
> > +
> > +	dev_dbg(hu->tty->dev, "Received alive packet!\n");
> > +
> > +finish_alive:
> > +	complete(&btdev->init_completion);
> > +	kfree_skb(skb);
> > +	return ret;
> > +}
> > +
> > +static int nokia_recv_radio(struct hci_dev *hdev, struct sk_buff *skb)
> > +{
> > +	/* Packets received on the dedicated radio channel are
> > +	 * HCI events and so feed them back into the core.
> > +	 */
> > +	bt_cb(skb)->pkt_type =3D HCI_EVENT_PKT;
>=20
> I think using hci_skb_pkt_type(skb) is correct here as well.

ok.

> > +	return hci_recv_frame(hdev, skb);
> > +}
> > +
> > +/* Recv data */
> > +static const struct h4_recv_pkt nokia_recv_pkts[] =3D {
> > +	{ NOKIA_RECV_ACL,	.recv =3D hci_recv_frame },
> > +	{ NOKIA_RECV_SCO,	.recv =3D hci_recv_frame },
> > +	{ NOKIA_RECV_EVENT,	.recv =3D hci_recv_frame },
> > +	{ NOKIA_RECV_ALIVE,	.recv =3D nokia_recv_alive_packet },
> > +	{ NOKIA_RECV_NEG,	.recv =3D nokia_recv_negotiation_packet },
> > +	{ NOKIA_RECV_RADIO,	.recv =3D nokia_recv_radio },
> > +};
> > +
> > +static int nokia_recv(struct hci_uart *hu, const void *data, int count)
> > +{
> > +	struct nokia_bt_dev *btdev =3D hu->priv;
> > +	int err;
> > +
> > +	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> > +		return -EUNATCH;
> > +
> > +	btdev->rx_skb =3D h4_recv_buf(hu->hdev, btdev->rx_skb, data, count,
> > +				  nokia_recv_pkts, ARRAY_SIZE(nokia_recv_pkts));
> > +	if (IS_ERR(btdev->rx_skb)) {
> > +		err =3D PTR_ERR(btdev->rx_skb);
> > +		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
> > +		btdev->rx_skb =3D NULL;
> > +		return err;
> > +	}
> > +
> > +	return count;
> > +}
> > +
> > +static struct sk_buff *nokia_dequeue(struct hci_uart *hu)
> > +{
> > +	struct nokia_bt_dev *btdev =3D hu->priv;
> > +
> > +	return skb_dequeue(&btdev->txq);
> > +}
> > +
> > +static const struct hci_uart_proto nokia_proto =3D {
> > +	.id		=3D HCI_UART_NOKIA,
> > +	.name		=3D "Nokia",
> > +	.open		=3D nokia_open,
> > +	.close		=3D nokia_close,
> > +	.recv		=3D nokia_recv,
> > +	.enqueue	=3D nokia_enqueue,
> > +	.dequeue	=3D nokia_dequeue,
> > +	.flush		=3D nokia_flush,
> > +	.setup		=3D nokia_setup,
> > +};
> > +
> > +static int nokia_bluetooth_probe(struct platform_device *pdev)
> > +{
> > +	struct nokia_uart_dev *btdata;
> > +	struct device *bcmdev =3D &pdev->dev;
> > +	struct clk *sysclk;
> > +	int err =3D 0;
> > +
> > +	if(!bcmdev->parent) {
> > +		dev_err(bcmdev, "parent device missing!\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	btdata =3D devm_kmalloc(bcmdev, sizeof(*btdata), GFP_KERNEL);
> > +	if(!btdata)
> > +		return -ENOMEM;
> > +
> > +	btdata->dev =3D bcmdev;
> > +	dev_set_drvdata(bcmdev, btdata);
> > +
> > +	btdata->port =3D dev_get_drvdata(bcmdev->parent);
> > +	if(!btdata->port) {
> > +		dev_err(bcmdev, "port data missing in parent device!\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	btdata->reset =3D devm_gpiod_get(bcmdev, "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(btdata->reset)) {
> > +		err =3D PTR_ERR(btdata->reset);
> > +		dev_err(bcmdev, "could not get reset gpio: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	btdata->wakeup_host =3D devm_gpiod_get(bcmdev, "host-wakeup", GPIOD_I=
N);
> > +	if (IS_ERR(btdata->wakeup_host)) {
> > +		err =3D PTR_ERR(btdata->wakeup_host);
> > +		dev_err(bcmdev, "could not get host wakeup gpio: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +
> > +	btdata->wakeup_bt =3D devm_gpiod_get(bcmdev, "bluetooth-wakeup",
> > +					    GPIOD_OUT_LOW);
> > +	if (IS_ERR(btdata->wakeup_bt)) {
> > +		err =3D PTR_ERR(btdata->wakeup_bt);
> > +		dev_err(bcmdev, "could not get BT wakeup gpio: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	sysclk =3D devm_clk_get(bcmdev, "sysclk");
> > +	if (IS_ERR(sysclk)) {
> > +		err =3D PTR_ERR(sysclk);
> > +		dev_err(bcmdev, "could not get sysclk: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	clk_prepare_enable(sysclk);
> > +	btdata->sysclk_speed =3D clk_get_rate(sysclk);
> > +	clk_disable_unprepare(sysclk);
> > +
> > +	dev_dbg(bcmdev, "parent uart: %s\n", dev_name(bcmdev->parent));
> > +	dev_dbg(bcmdev, "sysclk speed: %ld kHz\n", btdata->sysclk_speed / 100=
0);
> > +
> > +	/* TODO: open tty and setup line disector from kernel-side */
> > +
> > +	return err;
> > +}
> > +
> > +static const struct of_device_id nokia_bluetooth_of_match[] =3D {
> > +	{ .compatible =3D "nokia,brcm,bcm2048", },
> > +	{ .compatible =3D "nokia,ti,wl1271-bluetooth", },
>=20
> Where is the CSR BC4 one here? I prefer if we only have support
> for the ones that are actually supported and detected. We can
> easily extend things later.

I will drop CSR stuff. I don't have a device to test it.

> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
> > +
> > +static struct platform_driver platform_nokia_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "nokia-bluetooth",
> > +		.of_match_table =3D nokia_bluetooth_of_match,
> > +	},
> > +	.probe =3D nokia_bluetooth_probe,
> > +};
> > +
> > +int __init nokia_init(void)
> > +{
> > +	platform_driver_register(&platform_nokia_driver);
> > +	return hci_uart_register_proto(&nokia_proto);
> > +}
> > +
> > +int __exit nokia_deinit(void)
> > +{
> > +	platform_driver_unregister(&platform_nokia_driver);
> > +	return hci_uart_unregister_proto(&nokia_proto);
> > +}
> > diff --git a/drivers/bluetooth/hci_nokia.h b/drivers/bluetooth/hci_noki=
a.h
> > new file mode 100644
> > index 000000000000..8c4d307840e5
> > --- /dev/null
> > +++ b/drivers/bluetooth/hci_nokia.h
> > @@ -0,0 +1,140 @@
> > +/*
> > + *  Copyright (C) 2016 Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > + *
> > + *  This program is free software; you can redistribute it and/or modi=
fy
> > + *  it under the terms of the GNU General Public License as published =
by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + */
> > +
> > +#ifndef __HCI_NOKIA_H
> > +#define __HCI_NOKIA_H
>=20
> Lets not do a separate header here. Just move this all into
> hci_nokia.c. There is really zero benefit in the header.

ok.

> > +
> > +#define NOKIA_ID_CSR		0x02
> > +#define NOKIA_ID_BCM2048	0x04
> > +#define NOKIA_ID_TI1271		0x31
> > +
> > +#define FIRMWARE_CSR		"nokia/bc4fw.bin"
>=20
> If the CSR ones are not yet supported, then leave them out for
> now. We can add this later.
>=20
> > +#define FIRMWARE_BCM2048	"nokia/bcmfw.bin"
> > +#define FIRMWARE_TI1271		"nokia/ti1273.bin"
> > +
> > +#define NOKIA_BCM_BDADDR	0xfc01
>=20
> We have btbcm.[ch] for this.

ah this is a leftover. Currently the driver does not set
set_bdaddr() callback, since it differs between ti and bcm backend.
It looks like btbcm_set_bdaddr() can be used for the broadcom based
chips, though.

> > +#define HCI_NOKIA_NEG_PKT	0x06
> > +#define HCI_NOKIA_ALIVE_PKT	0x07
> > +#define HCI_NOKIA_RADIO_PKT	0x08
> > +
> > +#define HCI_NOKIA_NEG_HDR_SIZE		1
> > +#define HCI_NOKIA_MAX_NEG_SIZE		255
> > +#define HCI_NOKIA_ALIVE_HDR_SIZE	1
> > +#define HCI_NOKIA_MAX_ALIVE_SIZE	255
> > +#define HCI_NOKIA_RADIO_HDR_SIZE	2
> > +#define HCI_NOKIA_MAX_RADIO_SIZE	255
> > +
> > +#define NOKIA_PROTO_PKT		0x44
> > +#define NOKIA_PROTO_BYTE	0x4c
> > +
> > +#define NOKIA_NEG_REQ		0x00
> > +#define NOKIA_NEG_ACK		0x20
> > +#define NOKIA_NEG_NAK		0x40
> > +
> > +#define H4_TYPE_SIZE		1
>=20
> I am not sure this define adds any overall value to the code.
>=20
> > +
> > +#define NOKIA_RECV_ACL \
> > +	H4_RECV_ACL, \
> > +	.wordaligned =3D true
> > +
> > +#define NOKIA_RECV_SCO \
> > +	H4_RECV_SCO, \
> > +	.wordaligned =3D true
> > +
> > +#define NOKIA_RECV_EVENT \
> > +	H4_RECV_EVENT, \
> > +	.wordaligned =3D true
> > +
> > +#define NOKIA_RECV_ALIVE \
> > +	.type =3D HCI_NOKIA_ALIVE_PKT, \
> > +	.hlen =3D HCI_NOKIA_ALIVE_HDR_SIZE, \
> > +	.loff =3D 0, \
> > +	.lsize =3D 1, \
> > +	.maxlen =3D HCI_NOKIA_MAX_ALIVE_SIZE, \
> > +	.wordaligned =3D true
> > +
> > +#define NOKIA_RECV_NEG \
> > +	.type =3D HCI_NOKIA_NEG_PKT, \
> > +	.hlen =3D HCI_NOKIA_NEG_HDR_SIZE, \
> > +	.loff =3D 0, \
> > +	.lsize =3D 1, \
> > +	.maxlen =3D HCI_NOKIA_MAX_NEG_SIZE, \
> > +	.wordaligned =3D true
> > +
> > +#define NOKIA_RECV_RADIO \
> > +	.type =3D HCI_NOKIA_RADIO_PKT, \
> > +	.hlen =3D HCI_NOKIA_RADIO_HDR_SIZE, \
> > +	.loff =3D 1, \
> > +	.lsize =3D 1, \
> > +	.maxlen =3D HCI_NOKIA_MAX_RADIO_SIZE, \
> > +	.wordaligned =3D true
>=20
> For this ones I would have use the HCI event ones.
> My original patch had this:
>=20
> +#define NOK_RECV_NEG \
> +	.type =3D NOK_NEG_PKT, \
> +	.hlen =3D NOK_NEG_HDR_SIZE, \
> +	.loff =3D 0, \
> +	.lsize =3D 1, \
> +	.maxlen =3D HCI_MAX_EVENT_SIZE
> +
> +#define NOK_RECV_ALIVE \
> +	.type =3D NOK_ALIVE_PKT, \
> +	.hlen =3D NOK_ALIVE_HDR_SIZE, \
> +	.loff =3D 0, \
> +	.lsize =3D 1, \
> +	.maxlen =3D HCI_MAX_EVENT_SIZE
> +
> +#define NOK_RECV_RADIO \
> +	.type =3D NOK_RADIO_PKT, \
> +	.hlen =3D HCI_EVENT_HDR_SIZE, \
> +	.loff =3D 1, \
> +	.lsize =3D 1, \
> +	.maxlen =3D HCI_MAX_EVENT_SIZE
> +
> +static const struct h4_recv_pkt nok_recv_pkts[] =3D {
> +	{ H4_RECV_ACL,    .recv =3D hci_recv_frame },
> +	{ H4_RECV_SCO,    .recv =3D hci_recv_frame },
> +	{ H4_RECV_EVENT,  .recv =3D hci_recv_frame },
> +	{ NOK_RECV_NEG,   .recv =3D nok_recv_neg   },
> +	{ NOK_RECV_ALIVE, .recv =3D nok_recv_alive },
> +	{ NOK_RECV_RADIO, .recv =3D nok_recv_radio },
>=20
> With just these simple defines at the top:
>=20
> +#define NOK_NEG_PKT	0x06
> +#define NOK_ALIVE_PKT	0x07
> +#define NOK_RADIO_PKT	0x08
> +
> +#define NOK_NEG_HDR_SIZE	1
> +#define NOK_ALIVE_HDR_SIZE	1
>=20
> And I would prefer if we keep it like that.

ok. I used explicit defines, since it looks like
a copy/paste error otherwise.

> > +
> > +struct hci_nokia_neg_hdr {
> > +	__u8	dlen;
> > +} __packed;
> > +
> > +struct hci_nokia_neg_cmd {
> > +	__u8	ack;
> > +	__u16	baud;
> > +	__u16	unused1;
> > +	__u8	proto;
> > +	__u16	sys_clk;
> > +	__u16	unused2;
> > +} __packed;
> > +
> > +static inline struct hci_nokia_neg_hdr *hci_nokia_neg_hdr(const struct=
 sk_buff *skb)
> > +{
> > +	return (struct hci_nokia_neg_hdr *) skb->data;
> > +}
>=20
> What good is this inline? A define would be way better, if really
> needed.

I will drop hci_nokia_neg_hdr() and hci_nokia_alive_hdr() inlines

> [...]

-- Sebastian

--ih4qhin7qfdlbn7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXstheAAoJENju1/PIO/qavL4P/2mXeF6HkHrp4sTBSlgcir6d
lZixXfxdPHPxQl5eBYXQGwxsBijPsMn/9iK6UHUoFTCsrsrUn+TwQUago6YC379E
054UvFUWSWB1Gx/IrD9BBinZsmpQQzhhLFtNlvl6b4QUvivVXtXiNbFQjjvOBvRG
ZcHLmV61wsjlfcXt6urhlbTgMxr2I0NvuEL1ujvF7nfJ+mMTmTMwfi66FDERNnuA
4/41iQFrmIhXI7yimWYAVX1yWBC8l+QfHX6X9Cz5DWIkqMHzoUZVwQ/3oBHvrlU7
oEIoGfqoPcUpBYOwVqmFjAHuCo4FpizejTrOdYFbIDVFAhVR2cfHV8RXd+RNaIrj
BO6x4NTPeVY7IMxE/qBfSZqK99+37OUwdVc0lYoLrJ3C7yIb2wZM2AJ74rJqTUzF
jXJnE8vVaVCfuYdu8TFx4xFBafpyfEj7rG9WLllMKRvIePfRgHiqq8MP5BjL+MTX
Sf04FX4P12o9mnCPqKP8BDX8kmbt062OiHpxE2zDiWrEq0AMSUnaOiSJ967b4FuA
loi9RuyOev+CSPQy4Wi+jQRmpj2u/l+9OEnCIUOQCJ9MKUm4upbV9H4EMA2U/goC
ipdcjf3YaqdFS0FFHx/sHY7ctzI5ykmcoN0vRdjTWBWU1QHk4C35+lMB8buaAVFL
1Z9Eo/peKJyIE+7fUia4
=HRQ0
-----END PGP SIGNATURE-----

--ih4qhin7qfdlbn7f--
