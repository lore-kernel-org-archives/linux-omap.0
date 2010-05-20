From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3 v2] musb: AM35x: Workaround for fifo read issue
Date: Thu, 20 May 2010 13:06:30 +0300
Message-ID: <20100520100630.GF9992@nokia.com>
References: <1274184586-28843-1-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E7394044E535C95@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322EAE899@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322EAE899-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "andrea.marson-0U1K5dsi4As@public.gmane.org" <andrea.marson-0U1K5dsi4As@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 20, 2010 at 11:41:14AM +0200, ext Gadiyar, Anand wrote:
>It would not scale very well - we already have multi-omap builds
>that select support for multiple boards. If the AM35x boards are
>part of such builds, then mutually exclusive config options won't
>work - already n8x0 MUSB is exclusive with 243x/omap3.
>
>If it is possible to detect the AM35x at runtime, then we could
>handle this well. Also, a similar set of changes will be needed for
>the DMA code as well (right now we can pick only one of the DMA
>engines at a time).

it's time to split out platform code from musb core. I was thinking of 
having omap2430.c blackfin.c tusb6010.c davinci.c be a platform_device 
that instantiates musb_hdrc platform_device. It would also ioremap() the 
area and pass the gotten/enabled clock to musb. Then we can have all of 
the platforms enabled since the board files would pass down the 
platform_device for the platform code. Something like:

arch/arm/mach-omap2/usb-musb.c:

static struct platform_device omap_musb = {
	.dev	= {
		.name	= "omap-hsusbotg",	/* using the IP block name */
	},
	[..]
};

[..]

	platform_device_register(&omap_musb);

drivers/usb/musb/omap2430.c:

static struct musb_platform_data omap_musb_data;

static int __init omap_musb_probe(struct platform_device *pdev)
{
	clk = clk_get(&pdev->dev, "ick");
	base = ioremap(res->start, resource_size(res));

	omap_musb_data.clk = clk;
	omap_musb_data.base = base;

	[... all other necessary fields, like mode, etc]

	musb_pdev = platform_device_alloc("musb_hdrc", -1);
	musb_pdev->dev.parent = &pdev->dev;
	platform_device_add_data(musb_pdev, &omap_musb_data);
	platform_device_add(musb_pdev);

	return 0;
}

static int __exit omap_musb_remove(struct platform_device *pdev)
{
	clk_put(clk);
	iounmap(base);

	platform_device_del(musb_pdev);

	return 0;
}

[...]

io functions could also be passed through this platform_device so that 
we remove the insane amounts of ifdefs. Also context save/restore could 
be done a per-platform basis. Since the platform-code would be a parent 
to musb_hdrc, platform-code's suspend would be called before musb_hdrc 
suspend, then we would save context at that point already.

Any other ifdefferry on anything would be easier to remove with this 
approach and it also means we can have one musb_hdrc.ko for all (well 
arm-based only) boards and be sure it would work. We would just need to 
put something similar down for dma engines.

-- 
balbi

DefectiveByDesign.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
