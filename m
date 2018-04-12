From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Bug]: mtd: onenand: omap2plus: kernel panic with OneNAND on
 OMAP3 (DM3730) device GTA04A5
Date: Thu, 12 Apr 2018 08:03:06 -0700
Message-ID: <20180412150306.GB5700@atomide.com>
References: <5D496D5C-4E3E-47B4-9981-E8F4C348DE00@goldelico.com>
 <20180410205643.GA2228@lenoch>
 <AF1CE94F-FE95-49B1-99FF-AEC0C3EFFCA1@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AF1CE94F-FE95-49B1-99FF-AEC0C3EFFCA1@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [180411 07:05]:
> > Am 10.04.2018 um 22:56 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > Well, that's a shame... However, this code is in production for several
> > months now,
> 
> Well, we could have tested earlier release-candidates...

I've found it's way easier to test Linux next on regular basis
and report the regressions compared to chasing regressions after
the merge window or tagged kernels. By that time you may have
already multiple regressions to deal with which is always fun.

If you have products running with mainline kernel, maybe set up
automated boot testing for core devices to catch regressions
early?

Regards,

Tony
