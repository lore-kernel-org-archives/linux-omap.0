From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] pinctrl: Add support for additional dynamic states
Date: Thu, 18 Jul 2013 03:53:46 -0700
Message-ID: <20130718105345.GV7656@atomide.com>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090536.5541.36289.stgit@localhost>
 <51E70953.1000601@wwwdotorg.org>
 <20130718072034.GO7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130718072034.GO7656@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130718 00:31]:
> * Stephen Warren <swarren@wwwdotorg.org> [130717 14:21]:
> > On 07/16/2013 03:05 AM, Tony Lindgren wrote:
> > > +int pinctrl_check_dynamic(struct device *dev, struct pinctrl_state *st1,
> > > +			  struct pinctrl_state *st2)
> > > +{
> > > +	struct pinctrl_setting *s1, *s2;
> > > +
> > > +	list_for_each_entry(s1, &st1->settings, node) {
> > ...
> > > +		list_for_each_entry(s2, &st2->settings, node) {
> > ...
> > > +			if (pctldev1 != pctldev2) {
> > > +				dev_dbg(dev, "pctldev must be the same for states\n");
> > > +				return -EINVAL;
> > > +			}
> > 
> > I don't think we should require that; it's perfectly legal at the moment
> > for some device's pinctrl configuration to include settings from
> > multiple different pin controllers.
> 
> Yes that's fine for pinctrl_select(), but let's not do that for
> runtime muxing.

Hmm reading this again, you're right, there should not be anything
preventing mixing multiple controllers as long as the states match.
 
> > > +			for (i = 0; i < num_pins1; i++) {
> > > +				int pin1 = pins1[i];
> > > +
> > > +				for (j = 0; j < num_pins2; j++) {
> > > +					int pin2 = pins2[j];
> > > +
> > > +					if (pin1 == pin2) {
> > > +						found++;
> > > +						break;
> > > +					}
> > > +				}
> > > +			}
> > > +
> > > +			if (found != num_pins1) {
> > 
> > I guess this make sure that every entry in the dynamic state is in the
> > state state, but not vice-versa; the static state can affect more stuff
> > than the dynamic state?
> > 
> > If so, shouldn't that check be if (found != num_pins2)?
> 
> The check is that idle_state and sleep_state pins must match the
> active_state pins. This is intentionally different from the current
> pinctrl_select() logic.

And here things will get messed up if the order of settings is diffrent..
So yes, pinctrl_check_dynamic() needs more work.

Regards,

Tony
