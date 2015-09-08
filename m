From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/13] twl4030_charger: correctly handle -EPROBE_DEFER
 from devm_usb_get_phy_by_node
Date: Tue, 8 Sep 2015 13:14:17 -0700
Message-ID: <20150908201417.GG4215@atomide.com>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.31980.stgit@noble>
 <CAMAWPa__hFOuz24YBcFiR+m5mOUArSuNpuqh3Ju1H+yj6qadfA@mail.gmail.com>
 <CAMAWPa_s2ELgRBRtWzFucmREMuLXS_V5Akmad5yFU13-GrzBDA@mail.gmail.com>
 <87si6x4a2f.fsf@notabene.neil.brown.name>
 <20150902130724.GQ4215@atomide.com>
 <CAMAWPa8q1BOMvvKqqU88vYq4-_QhuxefVqkM6=4BP4-FGZxRPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMAWPa8q1BOMvvKqqU88vYq4-_QhuxefVqkM6=4BP4-FGZxRPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Neil Brown <neil@brown.name>, Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, lkml <linux-kernel@vger.kernel.org>, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Tyler Baker <tyler.baker@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@kernel.org> [150908 11:36]:
> On Wed, Sep 2, 2015 at 6:07 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Neil Brown <neil@brown.name> [150901 23:23]:
> >> Kevin Hilman <khilman@kernel.org> writes:
> >>
> >> > ping... this boot failure has now landed in mainline
> >>
> >> sorry, I'm on leave at the moment and travelling so I'm unlikely to be
> >> able to look at this properly.  I should be able to examine this issue
> >> before the end of the month but cannot promise sooner than that (though
> >> it is not impossible).
> >>
> >> Maybe it would be best to just revert it until a proper analysis can be
> >> done.
> >
> > OK yeah let's revert this one for now until we know what goes wrong.
> 
> Looks like this is still in mainline.
> 
> Tony, can you revert?

Probably best that Sebastian does it as there's another fix needed
too. It seems the following are needed:

- Revert $subject patch 3fc3895e4fe1 ("twl4030_charger: correctly
  handle -EPROBE_DEFER from devm_usb_get_phy_by_node")

- Apply compile fix "[PATCH] twl4030_charger: fix another compile
  error"

Just in case Sebastian is travelling or something.. Sebastian,
can you please confirm?

Regards,

Tony
