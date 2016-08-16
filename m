From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 4/7] Bluetooth: hci_uart: Add support for word alignment
Date: Tue, 16 Aug 2016 09:05:19 +0200
Message-ID: <F96C9280-2B85-42A0-A1DB-2C0C231F5C1D@holtmann.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org> <1471058078-5579-5-git-send-email-sre@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471058078-5579-5-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>, =?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sebatian,

> This will be used by Nokia's H4+ protocol, which
> adds padding to packets to reach word alignment.
> ---
> drivers/bluetooth/hci_h4.c   | 10 ++++++++++
> drivers/bluetooth/hci_uart.h |  1 +
> 2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
> index 635597b6e168..a934e4eb692b 100644
> --- a/drivers/bluetooth/hci_h4.c
> +++ b/drivers/bluetooth/hci_h4.c
> @@ -253,11 +253,21 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
> 			}
> 
> 			if (!dlen) {
> +				if ((&pkts[i])->wordaligned && !(skb->len % 2)) {
> +					buffer++;
> +					count--;
> +				}
> +
> 				/* No more data, complete frame */
> 				(&pkts[i])->recv(hdev, skb);
> 				skb = NULL;
> 			}
> 		} else {
> +			if ((&pkts[i])->wordaligned && !(skb->len % 2)) {
> +				buffer++;
> +				count--;
> +			}
> +
> 			/* Complete frame */
> 			(&pkts[i])->recv(hdev, skb);
> 			skb = NULL;
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 839bad1d8152..a7d67aec3632 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -121,6 +121,7 @@ struct h4_recv_pkt {
> 	u8  loff;	/* Data length offset in header */
> 	u8  lsize;	/* Data length field size */
> 	u16 maxlen;	/* Max overall packet length */
> +	bool wordaligned;	/* packets are word aligned */

I wonder if not a u8 align would be a way better choice here. We set it to 1 for all existing packet types. And the Nokia driver can use 2 here.

> 	int (*recv)(struct hci_dev *hdev, struct sk_buff *skb);

Regards

Marcel
