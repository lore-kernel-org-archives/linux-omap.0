From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] omapfb: Use devm_kcalloc() in vrfb_probe()
Date: Thu, 11 May 2017 17:22:54 +0200
Message-ID: <2438676.F6TUoaB08n@amdc3058>
References: <CGME20170426092018epcas4p343e69e32255faa796e7c55c3e89e40f2@epcas4p3.samsung.com>
        <4a7b1751-4319-4bde-cf26-2de2a4096c68@users.sourceforge.net>
        <1672837.1nPA5UjCzD@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1672837.1nPA5UjCzD@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday, May 11, 2017 04:27:19 PM Bartlomiej Zolnierkiewicz wrote:

> > @@ -358,11 +358,7 @@ static int __init vrfb_probe(struct platform_device *pdev)
> >  		return PTR_ERR(vrfb_base);
> >  
> >  	num_ctxs = pdev->num_resources - 1;
> > -
> > -	ctxs = devm_kzalloc(&pdev->dev,
> > -			sizeof(struct vrfb_ctx) * num_ctxs,
> > -			GFP_KERNEL);
> > -
> > +	ctxs = devm_kcalloc(&pdev->dev, num_ctxs, sizeof(*ctxs), GFP_KERNEL);
> 
> This change makes the resulting binary larger by 24 bytes (probably
> because of the need to have an additional function argument) and

24 bytes seemed too much for just an additional function argument
so I've checked the source:

static inline void *devm_kzalloc(struct device *dev, size_t size, gfp_t gfp)
{
	return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
}
static inline void *devm_kmalloc_array(struct device *dev,
				       size_t n, size_t size, gfp_t flags)
{
	if (size != 0 && n > SIZE_MAX / size)
		return NULL;
	return devm_kmalloc(dev, n * size, flags);
}
static inline void *devm_kcalloc(struct device *dev,
				 size_t n, size_t size, gfp_t flags)
{
	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
}

The extra kcalloc() checks are inlined currently into each instance.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
