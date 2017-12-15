From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am43xx: Fix inverted DS0_PULL_UP_DOWN_EN macro
Date: Fri, 15 Dec 2017 08:44:08 -0800
Message-ID: <20171215164408.GG3875@atomide.com>
References: <20171213212443.22632-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171213212443.22632-1-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [171213 13:27]:
> Due to a mistake in documentation the DS0_PULL_UP_DOWN_EN macro was
> mistakenly defined as an active high bit, however setting the bit
> actually disables the internal pull resistor on the pin, so correct this
> macro and introduce a new DS0_PULL_UP_DOWN_DIS macro with the proper bit
> value set now that the documentation has been updated.
> 
> Change based on AM437x Techninal Reference Manual SPRUHL7G Revised June
> 2017 Section 7.2.1.

Applying into omap-for-v4.16/dt thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
