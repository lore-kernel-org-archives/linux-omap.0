From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Beagleboard rev C memory timings & suspend/resume
Date: Mon, 11 May 2009 14:27:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905111416350.17514@utopia.booyaka.com>
References: <200904291553.49378.jpihet@mvista.com> <200905080905.39102.jpihet@mvista.com> <alpine.DEB.2.00.0905081527330.17514@utopia.booyaka.com> <200905112110.34589.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40230 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050AbZEKU1u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 16:27:50 -0400
In-Reply-To: <200905112110.34589.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "Kridner, Jason" <jdk@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Jean,

On Mon, 11 May 2009, Jean Pihet wrote:

> On Saturday 09 May 2009 00:43:43 Paul Walmsley wrote:
> > One possibility: perhaps the problem is with Beagle's pin mux settings.
> > You might want to boot with mem=128M and make sure
> > CONTROL_PADCONF_SAD2D_SBUSFLAG and CONTROL_PADCONF_SDRC_CKE1 are in mode 0
> > before suspend and after resume.
> Yes that definitely is the root cause. I should have checked this first ;-(
> The U-Boot change is committed, cf. 
> http://gitorious.org/u-boot-omap3/mainline/commit/c6f01ad390308800693c62dbdb096ab59e03630b
> and
> http://gitorious.org/u-boot-omap3/mainline/commit/4025cfbde3611b14c0d4831a5524e5e061128e30

Nice work!

Sounds like we should also patch mach-omap2/sdrc.c:omap2_sdrc_init() to 
warn if the sdrc_cke1 pin mux is wrong if a second struct omap_sdrc_params 
* is passed.  Probably board-omap3beagle.c should also remux the pad if 
it's wrong.  Otherwise there will be a lot of unhappy Rev C BeagleBoard 
users.

> I am looking at a fix for the SDRC setup with 2 CSes. I will propose the 
> changes asap.

Excellent, thanks Jean.


- Paul
