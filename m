From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: Status of led-backlight driver
Date: Mon, 9 Sep 2019 14:04:00 +0100
Message-ID: <20190909130400.erccomveu2ongeks@holly.lan>
References: <20190907100726.GA12763@amd>
 <20190909111410.dwqvg6b4lgxymn2o@holly.lan>
 <e40fcd10-85ef-9e04-0960-210736075f1f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e40fcd10-85ef-9e04-0960-210736075f1f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, tomi.valkeinen@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 09, 2019 at 01:46:39PM +0200, Jean-Jacques Hiblot wrote:
> Hi Daniel,
> 
> On 09/09/2019 13:14, Daniel Thompson wrote:
> > On Sat, Sep 07, 2019 at 12:07:27PM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > I don't see the LED-backlight driver in -next. Could it be pushed? It
> > > is one of last pieces to get working backlight on Motorola Droid 4...
> > Sorry, I dropped the ball on this and was therefore rather late
> > reviewing this patchset.
> > 
> > Assuming I have read the code correctly I think there are some
> > problems with the max_brightness handling in the backlight code.
> 
> Can you comment this? I'll be happy to fix the problem.

I did that before replying to the nudges. See:
https://lore.kernel.org/linux-leds/20190909095304.67ehnpg6gckwpno4@holly.lan/


> Reading the v4 again, I noticed that that I still had not removed the
> brightness scaling. Is that the problem ?

Yes (plus a couple of nits).


Daniel.
