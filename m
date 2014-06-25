From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/6] mailbox/omap: add a custom of_xlate function
Date: Wed, 25 Jun 2014 10:39:32 +0200
Message-ID: <5721425.bMLltMQDlc@wuerfel>
References: <1403660878-56350-1-git-send-email-s-anna@ti.com> <1403660878-56350-7-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403660878-56350-7-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jassi Brar <jaswinder.singh@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jassi Brar <jassisinghbrar@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 24 June 2014 20:47:58 Suman Anna wrote:
> +static struct mbox_chan *omap_mbox_of_xlate(struct mbox_controller *controller,
> +                                           const struct of_phandle_args *sp)
> +{
> +       phandle phandle = sp->args[0];
> +       struct device_node *node;
> +       struct omap_mbox_device *mdev;
> +       struct omap_mbox *mbox;
> +
> +       node = of_find_node_by_phandle(phandle);
> +       if (!node) {
> +               pr_err("could not find node phandle 0x%x\n", phandle);
> +               return NULL;
> +       }
> +
> +       mdev = container_of(controller, struct omap_mbox_device, controller);
> +       if (WARN_ON(!mdev))
> +               return NULL;
> +
> +       mbox = omap_mbox_device_find(mdev, node->name);
> +       return mbox ? mbox->chan : NULL;
> 

Wouldn't it be easier to change the omap_mbox_device_find() function to
take a phandle argument directly? You shouldn't have to walk all
nodes in the system, or match it by name if you already have the 
device node.

Also, the xlate function is normally the place where you read out
the other arguments and set them as members in your omap_mbox
structure.

	Arnd
