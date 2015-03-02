From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 15/15] twl4030_charger: assume a 'charger' can supply
 maximum current.
Date: Mon, 2 Mar 2015 22:29:39 +0100
Message-ID: <20150302212939.GS13270@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043353.4243.7374.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043353.4243.7374.stgit@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2015-02-24 15:33:53, NeilBrown wrote:
> If it cannot, we will stop pulling more current when voltage drops.

Can you justify it a bit more?

I mean... maybe there's a fuse in the charger? Or maybe it will supply
the current but overheat in the process? (USB_MAX_CURRENT is 500mA or
1.7A?)

Thanks,
									Pavel	

> Signed-off-by: NeilBrown <neilb@suse.de>

> @@ -691,8 +691,10 @@ static void twl4030_bci_usb_work(struct work_struct *data)
>  	struct twl4030_bci *bci = container_of(data, struct twl4030_bci, work);
>  
>  	switch (bci->event) {
> -	case USB_EVENT_VBUS:
>  	case USB_EVENT_CHARGER:
> +		bci->usb_cur = USB_MAX_CURRENT;
> +		/* FALL THROUGH */
> +	case USB_EVENT_VBUS:
>  	case USB_EVENT_ENUMERATED:
>  		twl4030_charger_enable_usb(bci, true);
>  		break;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
