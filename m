From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 06/15] twl4030_charger: split uA calculation into a
 function.
Date: Mon, 2 Mar 2015 22:05:18 +0100
Message-ID: <20150302210518.GM13270@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043351.4243.86053.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043351.4243.86053.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2015-02-24 15:33:51, NeilBrown wrote:
> We will need this calculation in other places, so
> create functions to map between register value and uA value.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +static int regval2ua(int regval, bool cgain)
> +{
> +	if (cgain)
> +		return (regval * 16618 - 8500 * 1000) / 5;
> +	else
> +		return (regval * 16618 - 8500 * 1000) / 10;
> +}

   int res = (regval * 16618 - 8500 * 1000);
   if (cgain)
      return res / 5;
   return res / 10;

?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
