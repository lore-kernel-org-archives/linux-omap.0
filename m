From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] rtc: omap: Support ext_wakeup configuration
Date: Fri, 15 Apr 2016 11:52:42 -0500
Message-ID: <57111C5A.7070606@ti.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com> <57078A89.3080809@ti.com>
 <20160408151408.GS16484@atomide.com> <5707E764.7050204@ti.com>
 <570D2F79.9040202@grinn-global.com> <57111AF4.6070505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57111AF4.6070505-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/15/2016 11:46 AM, Grygorii Strashko wrote:
[...]
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 13ac882..9580c82 100644
> --- a/arch/arm/boot/dts/dra7.dtsi

I see this is an example of what could be done on am335x - but lets
not do this on dra7/am57xx please?


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
