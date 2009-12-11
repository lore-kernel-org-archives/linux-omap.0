From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v7 5/5] OMAP: McBSP: Split and move read/write functions
 to mach-omap1/2
Date: Fri, 11 Dec 2009 15:21:16 +0200
Message-ID: <20091211152116.4c471dca.jhnikula@gmail.com>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl>
	<200912092134.32015.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:48282 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbZLKNT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 08:19:56 -0500
Received: by ewy1 with SMTP id 1so1003318ewy.28
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 05:20:02 -0800 (PST)
In-Reply-To: <200912092134.32015.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

On Wed, 9 Dec 2009 21:34:30 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> > > > Almost ready with it, one more question: what do you think about
> > > > splitting and moving omap_mcbsp_read()/_write() there as well? If you
> > > > agree, should I submit 2 patches, one with this cleanup, the other one
> > > > actually introducing cache support, or is one combined OK?
> > >
> > > Sounds good to me!
> >
...
> diff -upr git.orig/arch/arm/mach-omap1/mcbsp.c git/arch/arm/mach-omap1/mcbsp.c
> --- git.orig/arch/arm/mach-omap1/mcbsp.c	2009-12-09 15:49:52.000000000 +0100
> +++ git/arch/arm/mach-omap1/mcbsp.c	2009-12-09 16:20:43.000000000 +0100
>  
> +void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
...
> diff -upr git.orig/arch/arm/mach-omap2/mcbsp.c git/arch/arm/mach-omap2/mcbsp.c
> --- git.orig/arch/arm/mach-omap2/mcbsp.c	2009-12-09 15:49:52.000000000 +0100
> +++ git/arch/arm/mach-omap2/mcbsp.c	2009-12-09 16:20:43.000000000 +0100
>  
> +void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)

These functions must be unique, otherwise multi-build is not possible
(no idea can we do it for OMAP1?).

IMO, the _write and _read functions in ./plat-omap/mcbsp.c are clean
after the patch 3/5 anyway so probably we don't need this splitting?

-- 
Jarkko
