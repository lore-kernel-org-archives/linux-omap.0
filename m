From: "Kim, Milo" <milo.kim-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/6] ARM: dts: omap4-droid4: Add LCD backlight
Date: Mon, 20 Mar 2017 11:30:11 +0900
Message-ID: <4a8ac532-89a9-30e7-4087-00d840d6b53b@ti.com>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-3-tony@atomide.com>
 <20170319011830.4fapdy2jvlfvpljr@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170319011830.4fapdy2jvlfvpljr@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On 3/19/2017 10:18 AM, Sebastian Reichel wrote:
> I had to add https://patchwork.kernel.org/patch/7704601/ in addition
> to the patches recently queued into MFD. It would be nice to get that
> into 4.12 - @Milo Kim: What's your plan on that patch?

Thanks for checking this.

I just sent the patch to backlight subsystem maintainers. Nothing new 
except adding a pwm helper, pwm_apply_args().

Best regards,
Milo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
