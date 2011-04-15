From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Fri, 15 Apr 2011 16:41:25 +0300
Message-ID: <20110415164125.35f26fd0.jhnikula@gmail.com>
References: <20110314192538.GH7258@atomide.com>
	<alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com>
	<4D7FC70D.7050508@ti.com>
	<alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com>
	<4D80CA2F.8060300@ti.com>
	<alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com>
	<20110329233243.GR4016@atomide.com>
	<87lizwskcc.fsf@ti.com>
	<alpine.DEB.1.10.1103311722520.2634@esdhcp041196.research.nokia.com>
	<alpine.LFD.2.00.1104012241230.28032@xanadu.home>
	<20110413140429.GF12665@atomide.com>
	<alpine.DEB.1.10.1104131730371.2634@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53597 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab1DONjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 09:39:41 -0400
Received: by ewy4 with SMTP id 4so756692ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Apr 2011 06:39:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.1104131730371.2634@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 13 Apr 2011 17:34:24 +0300 (EEST)
Aaro Koskinen <aaro.koskinen@nokia.com> wrote:

> > Aaro, you mentioned to me that reverting commit
> > 6d7d0ae51574943bf571d269da3243257a2d15db helps too?
> >
> > With the device tree append patch reverting commit
> > d239b1dc093d551046a909920b5310c1d1e308c1 does not help, and reverting
> > 6d7d0ae51574943bf571d269da3243257a2d15db requires some manual merging..
> 
> Yes, with -rc1, reverting also 6d7d0ae51574943bf571d269da3243257a2d15db
> (ARM: 6750/1: improvements to compressed/head.S) helps. I haven't tried
> with newer kernels.
> 
Same note here from -rc3. For me it was enough to revert
6d7d0ae51574943bf571d269da3243257a2d15db.

I was struggling with some of my own configs that didn't boot on Nokia
N900 and config differences between working one and not working looked
like a random.

E.g. if one config had CONFIG_KALLSYMS_ALL=y, it didn't boot but booted
if CONFIG_DEBUG_SPINLOCK=y was also enabled and so forth.
CONFIG_KERNEL_LZMA=y either didn't make it booting. But revert made
those unworking configs booting.

-- 
Jarkko
