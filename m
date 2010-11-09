From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Tue, 9 Nov 2010 10:32:09 -0800
Message-ID: <20101109183208.GG9264@atomide.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
 <AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
 <201011091729.17679.arnd@arndb.de>
 <AANLkTikMjAh+LAFaWELyiJc+ou+N8v_7xhrwHRbBZZQF@mail.gmail.com>
 <20101109173536.GE9264@atomide.com>
 <AANLkTinLORQ7Hyn7nqkNZhRbP8iTGRfAXibgY2VeZTPq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinLORQ7Hyn7nqkNZhRbP8iTGRfAXibgY2VeZTPq@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Felipe Contreras <felipe.contreras@gmail.com>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>
List-Id: linux-omap@vger.kernel.org

* Guzman Lugo, Fernando <fernando.lugo@ti.com> [101109 09:43]:
> On Tue, Nov 9, 2010 at 11:35 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Guzman Lugo, Fernando <fernando.lugo@ti.com> [101109 08:36]:
> >>
> >> tidspbridge iommu change are working fine all the patches and few fixes after
> >> that are alredy sent. what breaks tidspbridge, is the unmerged
> >> dependencies in linux omap tree, specifically the iommu module patches
> >> and the SG patch.
> >
> > Care to post a series of the missing patches listed above?
> 
> Here are the missing patches:
> 
> Fernando Guzman Lugo (4):
>   iovmm: no gap checking for fixed address
>   iovmm: add superpages support to fixed da address
>   iovmm: replace __iounmap with omap_iounmap
>   iommu: create new api to set valid da range

Yeah this is stuff for Hiroshi to look at and queue for
2.6.28. No way we can merge these now.
 
> and
>   scatterlist: define SG chain for arm architecture

And this we need to test carefully it's not something we
can just merge.

Has this been tested to work with omap MMC drivers?

I'm not at all convinced the drivers can deal with
chained SG lists.. This may not show up with light
testing, the SG lists can be very small in most cases.

So this would have to be tested to make sure the
the chained SG list handled properly. The same goes
for other omap drivers that may be using SG.

Regards,

Tony
