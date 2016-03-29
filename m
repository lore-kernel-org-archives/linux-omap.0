From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 02/15] ARM: OMAP: Correct interrupt type for ARM TWD
Date: Tue, 29 Mar 2016 15:02:18 +0100
Message-ID: <56FA8AEA.3000208@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-3-git-send-email-jonathanh@nvidia.com>
 <56EC2191.2060800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56EC2191.2060800-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 18/03/16 15:41, Grygorii Strashko wrote:
> On 03/17/2016 04:19 PM, Jon Hunter wrote:
>> The ARM TWD interrupt is a private peripheral interrupt (PPI) and per
>> the ARM GIC documentation, whether the type for PPIs can be set is
>> IMPLEMENTATION DEFINED. For OMAP4 devices the PPI type cannot be set and
>> so when we attempt to set the type for the ARM TWD interrupt it fails.
>> This has done unnoticed because it fails silently and because we cannot
>> re-configure the type it has had no impact. Nevertheless fix the type
>> for the TWD interrupt so that it matches the hardware configuration.
>>
>> Reported-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> ---
>>
>> Tony, Grygorii,
>> Please note that I have not tested this. Can you test this series and
>> see if you see any warnings on OMAP4? I am guessing that the configuration
>> should be LEVEL and not EDGE. This was reported here:
> 
> Tested-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> 
> Tested on PandaBoard. Without this patch I can see below warning:

I think that you can pick up this fix independently of this series as it
is something that has been broken for sometime and should be fixed. I
included it here for completeness to highlight the issue but if you want
to take it now, please go ahead.

Cheers
Jon
