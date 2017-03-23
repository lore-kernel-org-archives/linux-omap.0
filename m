From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am335x-baltos: disable EEE for Atheros 8035 PHY
Date: Thu, 23 Mar 2017 11:43:12 -0700
Message-ID: <20170323184311.GN10760@atomide.com>
References: <1489395794-6243-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489395794-6243-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> [170313 02:05]:
> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> Though cpsw doesn't support EEE feature, Atheros 8035 provides
> automatic EEE support that is enabled by default. This causes
> occasional link drops when link partner also announces EEE support.
> These link drops occur on both 100Mbit/s and 1000Mbit/s speeds.
> So disable EEE advertising completely.

Applying into omap-for-v4.11/fixes thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
