From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: add dev_dbg() message for
 effective period and duty cycle
Date: Mon, 1 Feb 2016 10:59:52 -0800
Message-ID: <20160201185952.GN19432@atomide.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
 <CAA3gFWvSsctXtds6_SEtYY1yUdWJDR1XjznGS6qjdrGW5Dbw=A@mail.gmail.com>
 <20160201132228.2634b72e.drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160201132228.2634b72e.drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* David Rivshin (Allworx) <drivshin.allworx@gmail.com> [160201 10:23]:
> On Sat, 30 Jan 2016 15:51:06 +0100
> Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
> > 2016-01-30 5:26 GMT+01:00 David Rivshin (Allworx)
> > <drivshin.allworx@gmail.com>:
> > > From: David Rivshin <drivshin@allworx.com>
> > >
> > > After going through the math and constraints checking to compute
> > > load and match values, it is helpful to know what the resultant
> > > period and duty cycle are.
> > >
> > > Signed-off-by: David Rivshin <drivshin@allworx.com>
> > > ---
> > >
> > > I found this helpful while testing the other changes, so I included
> > > it in case it may be of use to someone in the future. I would have
> > > no issues with dropping this if it's not considered worthwhile.  
> > 
> > It's useful, but converting it as a sysfs attribute would be great !
> 
> Hrm, yes that is an interesting thought. I imagine that many PWM 
> devices have similar constraints, so perhaps that would be best 
> handled generically in the pwm core? Maybe as new optional get_*() 
> ops, a modification to the config() op to add output params, or just 
> updating new fields in the struct pwm directly?

Yeah for /sys entry it should be Linux generic. The other option
is to use debugfs for driver specific things.

Regards,

Tony
