From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/3] Input: twl4030-keypad - add device tree support
Date: Sun, 27 Oct 2013 05:23:48 -0700
Message-ID: <20131027122347.GE15154@atomide.com>
References: <1382446042-27099-1-git-send-email-sre@debian.org>
 <1382446042-27099-2-git-send-email-sre@debian.org>
 <20131027111715.GA2437@xo-6d-61-c0.localdomain>
 <20131027114026.GB14091@earth.universe>
 <20131027114753.GB14901@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131027114753.GB14901@amd.pavel.ucw.cz>
Sender: linux-doc-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-input@vger.kernel.org, 'Beno?t Cousson' <bcousson@baylibre.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [131027 04:48]:
> 
> > > > +#if IS_ENABLED(CONFIG_OF)
> > > I'm probably missing something here, but why not #ifdef CONFIG_OF?
> > 
> > I have been told for other drivers, that IS_ENABLED() is
> > the prefered way to check for configuration these days.
> 
> CONFIG_OF can not be module, using IS_ENABLED() on it is just wrong.

Good point. Looks like there's IS_BUILTIN that's for boolean options.

Regards,

Tony
