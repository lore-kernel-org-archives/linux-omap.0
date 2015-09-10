From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/13] twl4030_charger: correctly handle -EPROBE_DEFER
 from devm_usb_get_phy_by_node
Date: Thu, 10 Sep 2015 13:43:42 -0700
Message-ID: <20150910204342.GI4215@atomide.com>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.31980.stgit@noble>
 <CAMAWPa__hFOuz24YBcFiR+m5mOUArSuNpuqh3Ju1H+yj6qadfA@mail.gmail.com>
 <CAMAWPa_s2ELgRBRtWzFucmREMuLXS_V5Akmad5yFU13-GrzBDA@mail.gmail.com>
 <87si6x4a2f.fsf@notabene.neil.brown.name>
 <20150902130724.GQ4215@atomide.com>
 <CAMAWPa8q1BOMvvKqqU88vYq4-_QhuxefVqkM6=4BP4-FGZxRPw@mail.gmail.com>
 <20150908201417.GG4215@atomide.com>
 <20150910080849.GA6164@earth>
 <20150910202759.GA4844@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150910202759.GA4844@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, Neil Brown <neil@brown.name>, Samuel Ortiz <sameo@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, lkml <linux-kernel@vger.kernel.org>, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Tyler Baker <tyler.baker@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [150910 13:31]:
> Hi,
> 
> On Thu, Sep 10, 2015 at 10:08:50AM +0200, Sebastian Reichel wrote:
> > > Probably best that Sebastian does it as there's another fix needed
> > > too. It seems the following are needed:
> > > 
> > > - Revert $subject patch 3fc3895e4fe1 ("twl4030_charger: correctly
> > >   handle -EPROBE_DEFER from devm_usb_get_phy_by_node")
> > > 
> > > - Apply compile fix "[PATCH] twl4030_charger: fix another compile
> > >   error"
> 
> I just added these to my next branch:
> 
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/commit/?h=next&id=aefc574bbbbe74bb891ba392d98f2d59a417c774
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/commit/?h=next&id=e11fc21e756e662e465cac3da6547d438d0b1446

Thanks!

Tony
