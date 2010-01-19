From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [RFC] [PATCH] watchdog_info separation and constify
Date: Tue, 19 Jan 2010 23:00:14 +0100
Message-ID: <20100119220014.GG3804@infomag.iguana.be>
References: <20100119211759.GE3804@infomag.iguana.be> <20100119212755.72e81d24@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754481Ab0ASWAT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100119212755.72e81d24@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Florian Fainelli <florian@openwrt.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org, uclinux-dist-devel@blackfin.uclinux.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Alan,

> > please comment on following patch.
> 
> Why move them out - why not just make them const ?

There's 2 options:
1) we only make them const now. And we move them out later when we do the conversion to the generic watchdog api (which means that we will rip out the code for the open, release, write and ioctl handling of /dev/watchdog) or
2) we make them const and move them out of ioctl and then the ripping out of the code is much easier.

I opted for the second option.

Kind regards,
Wim.
