From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 0/7] mfd: Drop IRQF_EARLY_RESUME flag
Date: Mon, 29 Feb 2016 00:45:17 +0100
Message-ID: <20160228234517.GB3190@piout.net>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456501377-16871-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 26/02/2016 at 17:42:50 +0200, Grygorii Strashko wrote :
> The IRQF_EARLY_RESUME flag is not required for nested irqs anymore,
> since commit 3c646f2c6aa9 ("genirq: Don't suspend nested_thread irqs
> over system suspend") was merged.
> Hence, this flag can be dropped for MFD cell's devices where MFD interrupt
> controller defines nested IRQs as nested threaded IRQs.
> 
> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
> Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
> Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> Cc: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Grygorii Strashko (7):
>   extcon: palmas: Drop IRQF_EARLY_RESUME flag
>   rtc: palmas: Drop IRQF_EARLY_RESUME flag
>   rtc: tps6586x: Drop IRQF_EARLY_RESUME flag
>   rtc: tps65910: Drop IRQF_EARLY_RESUME flag
>   rtc: tps80031: Drop IRQF_EARLY_RESUME flag
>   rtc: as3722: Drop IRQF_EARLY_RESUME flag
>   iio: adc: palmas: Drop IRQF_EARLY_RESUME flag
> 
>  drivers/extcon/extcon-palmas.c | 4 ++--
>  drivers/iio/adc/palmas_gpadc.c | 6 +++---
>  drivers/rtc/rtc-as3722.c       | 2 +-
>  drivers/rtc/rtc-palmas.c       | 3 +--
>  drivers/rtc/rtc-tps6586x.c     | 2 +-
>  drivers/rtc/rtc-tps65910.c     | 2 +-
>  drivers/rtc/rtc-tps80031.c     | 2 +-
>  7 files changed, 10 insertions(+), 11 deletions(-)
> 

I applied all the rtc related patches, thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
