From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: tsc2005 - convert to gpiod
Date: Wed, 15 Jul 2015 17:25:32 -0700
Message-ID: <20150716002532.GF24393@dtor-ws>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
 <1436962408-5206-5-git-send-email-sre@kernel.org>
 <20150715213404.GC24393@dtor-ws>
 <20150715220940.GD2591@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150715220940.GD2591@earth>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-input@vger.kernel.org, Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 16, 2015 at 12:09:41AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jul 15, 2015 at 02:34:04PM -0700, Dmitry Torokhov wrote:
> > [...]
> > >  	if (np) {
> > > -		ts->reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
> > > -		if (ts->reset_gpio == -EPROBE_DEFER)
> > > -			return ts->reset_gpio;
> > > -		if (ts->reset_gpio < 0) {
> > > +		ts->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
> > > +						GPIOD_OUT_HIGH);
> > 
> > I think we should treat the gpio as optional and try to get the
> > descriptor event on non-OF boards.
> 
> As I wrote in the cover letter, I suggest to change this once the
> Nokia N900 board code has been removed. At that point changing the
> board code API is much easier, since it won't affect multiple trees.

I do not see why it has be wait for Nokia board code. Just make it
devm_gpiod_get_optional() and call it unconditionally and fall back onto
custom reset function (if one is supplied).

Thanks.

-- 
Dmitry
