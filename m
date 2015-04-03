From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3] media: i2c/adp1653: devicetree support for adp1653
Date: Fri, 3 Apr 2015 10:23:44 +0200
Message-ID: <20150403082344.GA14721@amd>
References: <20150402143846.GA11687@amd>
 <20150402161453.GH20756@valkosipuli.retiisi.org.uk>
 <20150402203043.GB29963@amd>
 <20150402234823.GI20756@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150402234823.GI20756@valkosipuli.retiisi.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Andrew Morton <akpm@osdl.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, galak@codeaurora.org, bcousson@baylibre.com, m.chehab@samsung.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> Hi Pawel,

I'm still Pavel. v, not w.

> > > Hi Pawel,

> > > A corresponding change to the N900 dts would be very nice.
> > 
> > Corresponding change to the dts will come in separate patch. Or do you
> > have n900 for testing?
> 
> Yes, it should be a separate patch, I agree.
> 
> I do have one but I can't say when I'd have time to test it. I'm fine with
> you having tested it though.
> 
> > > I think you're missing change to adp1653_i2c_driver.driver.of_match_table.
> > 
> > It actually worked for me, which means device tree somehow does it
> > magic.
> 
> By magic? :-) It probably just ends up comparing the device and the driver
> names. How about adding the of_match_table?

I guess it uses adp1653_id_table. I'd hade to add redundand
information, because if it would just mask the errors if the code
changed...

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
