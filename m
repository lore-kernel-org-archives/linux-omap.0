From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it
 breaks touchscreen on n900.
Date: Mon, 1 Jun 2015 17:21:11 +0200
Message-ID: <20150601152111.GA14015@amd>
References: <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd>
 <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost>
 <20150529203456.GC22083@amd>
 <20150601095556.GH17267@lukather>
 <20150601140605.GA26908@amd>
 <20150601145825.GA20557@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33797 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbbFAPVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 11:21:13 -0400
Content-Disposition: inline
In-Reply-To: <20150601145825.GA20557@lukather>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com



> > > > The 3eea8b5d68c801fec788b411582b803463834752 is just bad.
> > > 
> > > You were very welcome to review this patch at the time and/or suggest
> > > a fix that pleases everyone.
> > 
> > You should be the one that should suggest fixes, as you broke it in
> > the first place. But clearly you don't understand that.
> 
> You actually never asked for a fix, and went head first calling this
> patch "bad" and asking for nothing but reverting it.

Date: Fri, 29 May 2015 21:08:16 +0200
Subject: 4.1 touchscreen regression on n900 -- pinpointed [was Re:
linux-n900
...
Maxime, can you suggest a fix?
...


> diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
> index b82b5207c78b..7e98c2e443ab 100644
> --- a/drivers/input/touchscreen/of_touchscreen.c
> +++ b/drivers/input/touchscreen/of_touchscreen.c
> @@ -14,10 +14,10 @@
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
>  
> -static u32 of_get_optional_u32(struct device_node *np,
> +static int of_get_optional_u32(struct device_node *np,
>  			       const char *property)
>  {
> -	u32 val = 0;
> +	int val = -1;
>  
>  	of_property_read_u32(np, property, &val);
>  
> @@ -42,8 +42,12 @@ static void touchscreen_set_params(struct input_dev *dev,
>  	}
>  
>  	absinfo = &dev->absinfo[axis];
> -	absinfo->maximum = max;
> -	absinfo->fuzz = fuzz;
> +
> +	if (max >= 0)
> +		absinfo->maximum = max;
> +
> +	if (fuzz >= 0)
> +		absinfo->fuzz = fuzz;
>  }
>  
>  /**
> @@ -57,7 +61,7 @@ static void touchscreen_set_params(struct input_dev *dev,
>  void touchscreen_parse_of_params(struct input_dev *dev)
>  {
>  	struct device_node *np = dev->dev.parent->of_node;
> -	u32 maximum, fuzz;
> +	int maximum, fuzz;
>  
>  	input_alloc_absinfo(dev);
>  	if (!dev->absinfo)
> -- >8 --
> 
> That reduces the max size of the screens, but I don't really expect the screen
> size to reach that order of magnitude before a few years...

Umm. Won't you have to update

-     if (maximum || fuzz)
+     if (maximum >= 0 || fuzz >= 0)

? Thanks,

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
