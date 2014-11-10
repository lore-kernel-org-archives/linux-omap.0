From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: dra7-evm: Keep all VDD rails always-on
Date: Mon, 10 Nov 2014 12:39:23 -0800
Message-ID: <20141110203922.GX31454@atomide.com>
References: <1413902290-304-1-git-send-email-nm@ti.com>
 <54579476.10702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54579476.10702-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [141103 06:44]:
> Hi Nishant,
> 
> On 10/21/2014 05:38 PM, Nishanth Menon wrote:
> > DRA7 Data Manual (SPRS857L - August 2014) section 4.1.1 states: "All
> > unused power supply balls must be supplied with the voltages specified
> > in the Section 5.2, Recommended Operating Conditions".
> > 
> > This implies that all unused voltage rails for Vayu can never be
> > switched off even if the hardware blocks inside that voltage domain is
> > unused. Switching off these unused rails may result in stability issues
> > on other domains and increased leakage and power-on-hour impacts.
> > 
> > J6eco-evm dts file already considers this, however j6evm-dts file needs
> > to be fixed to consider this constraint of the SoC.
> > 
> > Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> 
> Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> 
> I'm assuming that vddshv8 (MMC1 power group) can be switched off.

Applying into omap-for-v3.19/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
