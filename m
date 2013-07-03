From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/4] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Wed, 3 Jul 2013 15:27:16 +0200
Message-ID: <201307031527.17219.arnd@arndb.de>
References: <1372764757-29511-1-git-send-email-pekon@ti.com> <20980858CB6D3A4BAE95CA194937D5E73E9E46CA@DBDE04.ent.ti.com> <1372857987.9767.162.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49438 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab3GCN1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jul 2013 09:27:40 -0400
In-Reply-To: <1372857987.9767.162.camel@sauron.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: artem.bityutskiy@linux.intel.com
Cc: "Gupta, Pekon" <pekon@ti.com>, "tony@atomide.com" <tony@atomide.com>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "olof@lixom.net" <olof@lixom.net>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>

On Wednesday 03 July 2013, Artem Bityutskiy wrote:
> On Wed, 2013-07-03 at 13:16 +0000, Gupta, Pekon wrote:
> > [Pekon]: Yes, I'm not seeing these build issues, as I'm cleanly
> > returning from probe with pr_err(), if the required libraries (/lib/bch.c) 
> > are not build-in the system.
> > -------------------
> > [Patch v4 1/4]: mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC..
> > @@static int omap_nand_probe(struct platform_device *pdev)
> > +	default:
> > +		pr_err("selected ECC scheme not supported or not enabled\n");
> > +		err = -EINVAL;
> > +		goto out_release_mem_region;
> > +	}
> > -------------------
> > However, if you are still seeing this, could you please send me your config?
> 
> I compile tested your patches too, and did not see any issues with my
> omap2_defconfig.


To clarify: I'm getting this error with randconfig on today's linux-next.
I think it only happens with MTD_NAND_ECC_BCH enabled, which is not
the default in omap2_defconfig.

	Arnd
