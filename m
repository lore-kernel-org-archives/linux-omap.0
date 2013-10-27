From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCHv2 1/3] Input: twl4030-keypad - add device tree support
Date: Sun, 27 Oct 2013 12:47:53 +0100
Message-ID: <20131027114753.GB14901@amd.pavel.ucw.cz>
References: <1382446042-27099-1-git-send-email-sre@debian.org>
 <1382446042-27099-2-git-send-email-sre@debian.org>
 <20131027111715.GA2437@xo-6d-61-c0.localdomain>
 <20131027114026.GB14091@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131027114026.GB14091-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Beno?t Cousson' <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi!

> > > + * keypad,num-rows and keypad,num-columns are required.
> > Is "keypad," prefix neccessary here?
> 
> See Documentation/devicetree/bindings/input/matrix-keymap.txt
> 
> > > +Optional Properties specific to linux:
> > > +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
> > 
> > "do not autorepeat". Plus I do not see what is Linux specifc about not
> > autorepeating... Other systems will likely know about autorepeat, too.
> 
> This property has already been used like this for
> samsung-keypad, stmpe-keypad, omap-keypad and
> gpio-matrix-keypad.

Ok. But you still have a typo. "do no enable" => "do not enable".

> > > +#if IS_ENABLED(CONFIG_OF)
> > I'm probably missing something here, but why not #ifdef CONFIG_OF?
> 
> I have been told for other drivers, that IS_ENABLED() is
> the prefered way to check for configuration these days.

CONFIG_OF can not be module, using IS_ENABLED() on it is just wrong.

> > > @@ -381,7 +426,7 @@ static int twl4030_kp_probe(struct platform_device *pdev)
> > >  
> > >  	input_set_capability(input, EV_MSC, MSC_SCAN);
> > >  	/* Enable auto repeat feature of Linux input subsystem */
> > > -	if (pdata->rep)
> > > +	if (!kp->no_autorepeat)
> > >  		__set_bit(EV_REP, input->evbit);
> > >
> > 
> > Double negation is nasty to read. I believe code would be more
> > readable if you switched logic to kp->autorepeat.
> 
> I was thinking about the same when writing it, but decided
> against it, since it will just move the double negation to
> the variable initialization.

Well, the property should be linux,keypad-autorepeat in the first
place, but it is too late to change that.

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
