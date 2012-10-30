From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Tue, 30 Oct 2012 23:57:41 +0100
Message-ID: <2288906.HJczx1g3gj@vostro.rjw.lan>
References: <20121025205901.GA3827@sirena.org.uk> <20121030183704.GX4511@opensource.wolfsonmicro.com> <CACRpkdac=ztY0vXQ8Mu6H8fiAO4aFSSF-A6O1Q==zKOKEsJegw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <CACRpkdac=ztY0vXQ8Mu6H8fiAO4aFSSF-A6O1Q==zKOKEsJegw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benoit Cousson <b-cousson@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

On Tuesday, October 30, 2012 10:51:11 PM Linus Walleij wrote:
> On Tue, Oct 30, 2012 at 7:37 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > More seriously the amount of time we seem to have been spending recently
> > on changes which end up requiring us to go through essentially every
> > driver and add code to them (often several times) doesn't seem like
> > we're doing a good job here.
> 
> If this is your main concern you should be made aware that there
> are people out there planning to supplant the existing DT probe paths
> that are now being added to each and every ARM-related driver
> with an ACPI probe path as ARM servers come into the picture.

That's correct.

> > pinctrl is really noticable because it's
> > new but it's not the only thing.  As a subsystem maintainer this code
> > just makes me want to add new subsystem features to pull the code out of
> > drivers but obviously that's not something that should be being done at
> > the subsystem level.
> 
> We did manage to drag the power/voltage domain per se out
> of the AMBA bus, and recommend that people (like us) do that
> business using the power domains.
> 
> I think most people (including OMAP) have bought
> into the concept of using the runtime PM framework and power
> domains to control the power domain switches.
> 
> It's this wider concept of using the loose concept "PM resource
> domains" to control also clocks and pins that is at stake, and so
> far the runtime PM core people (Rafael and Magnus) has not said
> much so I think we need some kind of indication from them as to
> what is to happen, long-term, with drivers handling their own clocks
> and pins. Should it be centralized or not? If it's to be centralized it
> needs to become a large piece of infrastructure refactoring and
> needs the attention of Linaro and the like to happen.

Well, I personally think it should be centralized somehow.  I'm not quite
sure how to achieve that, though.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
