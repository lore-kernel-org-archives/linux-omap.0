From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [alsa-devel] [PATCH v2 1/7][RESEND] ARM: OMAP1: ams-delta: register latch	dependent devices later
Date: Tue, 20 Dec 2011 21:51:33 +0100
Message-ID: <201112202151.34062.jkrzyszt@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl> <201112200028.32947.jkrzyszt@tis.icnet.pl> <20111220204046.GA3354@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20111220204046.GA3354@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 of December 2011 at 21:40:46, Russell King - ARM Linux wrote:
> On Tue, Dec 20, 2011 at 12:28:32AM +0100, Janusz Krzysztofik wrote:
> > diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> > index d4d08bd..56ffd7c 100644
> > --- a/drivers/input/serio/ams_delta_serio.c
> > +++ b/drivers/input/serio/ams_delta_serio.c
> > @@ -165,6 +165,9 @@ serio:
> >  	kfree(ams_delta_serio);
> >  	return err;
> >  }
> > +#ifndef MODULE
> > +late_initcall(ams_delta_serio_init);
> > +#else
> >  module_init(ams_delta_serio_init);
> >  
> >  static void __exit ams_delta_serio_exit(void)
> > @@ -175,3 +178,4 @@ static void __exit ams_delta_serio_exit(void)
> >  	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
> >  }
> >  module_exit(ams_delta_serio_exit);
> > +#endif
> 
> It's worth noting:
> 
> #ifndef MODULE
> #define late_initcall(fn)               __define_initcall("7",fn,7)
> #else /* MODULE */
> #define late_initcall(fn)               module_init(fn)
> 
> So really, all these ifndefs aren't required.  Just change the module_init()
> to late_initcall().

Thanks, I'll follow your pattern. My reason for using those ifdefery was 
a comment still found in include/linux/init.h:

#else /* MODULE */

/* Don't use these in modules, but some people do... */
#define early_initcall(fn)              module_init(fn)
#define core_initcall(fn)               module_init(fn)
...
#define late_initcall(fn)               module_init(fn)

Thanks,
Janusz
