From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/15] twl4030_charger: only draw USB current as
 negotiated with host.
Date: Mon, 2 Mar 2015 22:05:33 +0100
Message-ID: <20150302210532.GO13270@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043352.4243.84042.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043352.4243.84042.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2015-02-24 15:33:52, NeilBrown wrote:
> If the phy has been told what current it can draw, it tells us
> and now we use that number.
> 
> Note that 'vbus_draw' is in mA, while usb_cur is in uA.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -609,6 +610,7 @@ static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
>  			       void *priv)
>  {
>  	struct twl4030_bci *bci = container_of(nb, struct twl4030_bci, usb_nb);
> +	unsigned *vbus_draw = priv;

unsigned int? [Or better mA_t *? :-)]

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
