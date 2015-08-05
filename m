From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] mailbox/omap: Add ti,mbox-send-noirq quirk to fix
 AM33xx CPU Idle
Date: Wed, 5 Aug 2015 03:28:40 -0700
Message-ID: <20150805102840.GA16878@atomide.com>
References: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
 <1437166592-25378-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437166592-25378-2-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Suman Anna <s-anna@ti.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [150717 13:59]:
> --- a/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> +++ b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> @@ -75,6 +75,14 @@ data that represent the following:
>      Cell #3 (usr_id)  - mailbox user id for identifying the interrupt line
>                          associated with generating a tx/rx fifo interrupt.
>  
> +Optional Properties:
> +--------------------
> +- ti,mbox-send-noirq:   Quirk flag to allow the client user of this sub-mailbox
> +                        to send messages without triggering a Tx ready interrupt,
> +                        and to control the Tx ticker. Should be used only on
> +                        sub-mailboxes used to communicate with WkupM3 remote
> +                        processor on AM33xx/AM43xx SoCs.
> +

Hmm can't you do this just by setting a flag in the device driver
based on the compatible string?

Regards,

Tony
