From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: twl-common: Fix musb-hdrc device name.
Date: Mon, 9 Dec 2013 09:50:06 -0800
Message-ID: <20131209175006.GD12527@atomide.com>
References: <1386059589-4030-1-git-send-email-marek.belisko@open-nandra.com>
 <529D9D43.6040101@ti.com>
 <CAAfyv37Vie1vZK2XQ1cfVq6eVnSuaBLfykk6pU8fwEyqvPF4BA@mail.gmail.com>
 <CAAfyv35gVVNydrk8vifSyidpFjEXjGiT4-i2dgN5Un2=FuHaqQ@mail.gmail.com>
 <20131205184323.GF26766@atomide.com>
 <CAAfyv37e9+OLH-KegPCEhc0sbBS7UVnaSGU0mBw2AxAN9D7Akw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAfyv37e9+OLH-KegPCEhc0sbBS7UVnaSGU0mBw2AxAN9D7Akw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

* Belisko Marek <marek.belisko@gmail.com> [131208 23:36]:
> Hi Tony,
> 
> On Thu, Dec 5, 2013 at 7:43 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Belisko Marek <marek.belisko@gmail.com> [131203 01:21]:
> >> On Tue, Dec 3, 2013 at 10:08 AM, Belisko Marek <marek.belisko@gmail.com> wrote:
> >> > Hi,
> >> >
> >> > On Tue, Dec 3, 2013 at 9:58 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >> >> Hi,
> >> >>
> >> >> On Tuesday 03 December 2013 02:03 PM, Marek Belisko wrote:
> >> >>> Without this change when booting omap3 device (gta04) with board file
> >> >>> leads to follwing errors:
> >> >>>
> >> >>> [    1.203308] musb-hdrc musb-hdrc.0.auto: unable to find phy
> >> >>> [    1.209075] HS USB OTG: no transceiver configured
> >> >>> [    1.214019] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
> >> >>>
> >> >>> and usb isn't working.
> >> >>>
> >> >>> This is probably regression caused by commit: 6c27f939
> >> >>
> >> >> I think a better fix would be to have this merged..
> >> >> https://lkml.org/lkml/2013/7/26/91
> >> > Yes I see but how this could help with current situation? Ho you then
> >> > specify device number?
> >> I was too fast with reply sorry. I can see whole series and it is of
> >> course correct solution. But as I said
> >> can we except to be merged to 3.13. If not Tony can you pick my patch.
> >
> > If it's a regression, then let's get it merged for the -rc cycle.
> Yes it is regression and without that usb on most omap3 based boards
> without DT will not work.
> >
> > So please try to follow up on getting the proper fix merged, meanwhile
> > I'll mark this thread as read. If you need this one merged for some
> > reason, then please report to get it back to my radar.

I'm still clueless which USB regression fix to apply for the -rc cycle
though.. Hoping to see a single patch which clearly states the issue
and has acks.

Regards,

Tony
