From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: dtc warnings
Date: Fri, 1 Apr 2016 08:42:37 -0700
Message-ID: <20160401154237.GK9329@atomide.com>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: arm-platform-maintainers-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160331 18:42]:
> You may have noticed that linux-next had gotten noisy with dtc
> warnings lately. I dropped the change for a bit, but added it back
> today except now it is disabled unless building with "W=1".
> 
> There's ~25K (2500 unique) warnings generated from the ARM dts files.
> Here's the ranking of warnings by dtb. OMAP is the clear winner (based
> on the similar counts, probably lots of duplicates). Please help
> remind contributors to test with W=1 and start to fix these.

I think Tero already has been looking at fixing the omap clock
related warnings that seem to produce most of these, so adding
him to Cc.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
