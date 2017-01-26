From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Thu, 26 Jan 2017 08:20:13 -0800
Message-ID: <20170126162013.GS7403@atomide.com>
References: <20170120220440.1971-1-tony@atomide.com>
 <20170120220440.1971-3-tony@atomide.com>
 <CAKvHMgQKPZcdBPMUH-3_e-M4sHPijEH59019bygmi+o2y4B+Rw@mail.gmail.com>
 <20170124012702.GA7403@atomide.com>
 <CAKvHMgTvdEz=YRxB-sd-FHws+DH9DJTnVst3Tc=9HoaKMq--Ow@mail.gmail.com>
 <20170124182925.GF7403@atomide.com>
 <20170124230520.GA1204@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124230520.GA1204@animalcreek.com>
Sender: linux-pm-owner@vger.kernel.org
To: Mark Greer <mgreer@animalcreek.com>
Cc: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Greer <mgreer@animalcreek.com> [170124 15:06]:
> On Tue, Jan 24, 2017 at 10:29:26AM -0800, Tony Lindgren wrote:
> 
> > 8< -----------------------------------------
> > >From tony Mon Sep 17 00:00:00 2001
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Fri, 20 Jan 2017 09:58:51 -0800
> > Subject: [PATCH] power: bq24190_charger: Use PM runtime autosuspend
> > 
> > We can get quite a few interrupts when the battery is trickle charging.
> > Let's enable PM runtime autosuspend to avoid constantly toggling device
> > driver PM runtime state.
> > 
> > Let's use a 600 ms timeout as that's how long the USB chager detection
> > might take.
> > 
> > Cc: Liam Breck <kernel@networkimprov.net>
> > Cc: Mark Greer <mgreer@animalcreek.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> 
> Acked-by: Mark Greer <mgreer@animalcreek.com>

OK thanks will repost the two patches. Liam, got any more comments
or care to ack?

Regards,

Tony
