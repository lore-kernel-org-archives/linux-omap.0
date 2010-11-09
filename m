From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Mon, 8 Nov 2010 16:57:54 -0800
Message-ID: <20101109005754.GX9264@atomide.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
 <AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Felipe Contreras <felipe.contreras@gmail.com> [101108 14:51]:
> On Sun, Nov 7, 2010 at 11:36 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > The situation of tidspbridge driver on staging has been pretty sad,
> > basically, it has never worked. This is a step backwards from the
> > previous situation where it was clear which branch to use to get it
> > working. Unfortunately, the ARM and OMAP trees haven't made it easy,
> > as changes in those trees have broken it even further.

Hmm to me it looks like these reverts you are suggesting are
for drivers/staging/tidspbridge, not for arch/arm/* :)
 
> Here's another try, this one has only one patch that needs omap
> maintainers to ack.

Acked that memblock patch it in this thread.

Tony
