From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] ARM: dts: Correct offset in OMAP4_WKUP_IOPAD macro
Date: Sat, 19 Apr 2014 18:25:11 +0200
Message-ID: <CAGhQ9VwU_BjrD+c9uJn9FBwo6v_BOMUCKwiOW-7eqOu056a79A@mail.gmail.com>
References: <1397924056-6462-1-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:53438 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbaDSQZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Apr 2014 12:25:12 -0400
Received: by mail-lb0-f175.google.com with SMTP id w7so2149960lbi.34
        for <linux-omap@vger.kernel.org>; Sat, 19 Apr 2014 09:25:11 -0700 (PDT)
In-Reply-To: <1397924056-6462-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

On 19 April 2014 18:14, Joachim Eastwood <manabian@gmail.com> wrote:
> This was introduced in 43a348ea53eb5fd79 but hasn't caused
> any harm since it don't have any users yet.

Or maybe I am confused about this macro.

Tony which offset from the OMAP4 TRM should be used?

Under section 18.6.8 there are is a column with address offset. Is
this the number you want in the macro?

regards
Joachim Eastwood

> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> Hello,
>
> This one had me puzzled for a while. Wondering why USB
> suddenly disappeared and suspecting by convert script.
>
>  -JE
>
>  include/dt-bindings/pinctrl/omap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
> index b04528cd033c..251d1bd17e35 100644
> --- a/include/dt-bindings/pinctrl/omap.h
> +++ b/include/dt-bindings/pinctrl/omap.h
> @@ -63,7 +63,7 @@
>  #define OMAP3_WKUP_IOPAD(pa, val)      OMAP_IOPAD_OFFSET((pa), 0x2a00) (val)
>  #define AM33XX_IOPAD(pa, val)          OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
>  #define OMAP4_CORE_IOPAD(pa, val)      OMAP_IOPAD_OFFSET((pa), 0x0040) (val)
> -#define OMAP4_WKUP_IOPAD(pa, val)      OMAP_IOPAD_OFFSET((pa), 0xe040) (val)
> +#define OMAP4_WKUP_IOPAD(pa, val)      OMAP_IOPAD_OFFSET((pa), 0x0040) (val)
>  #define AM4372_IOPAD(pa, val)          OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
>  #define OMAP5_CORE_IOPAD(pa, val)      OMAP_IOPAD_OFFSET((pa), 0x2840) (val)
>  #define OMAP5_WKUP_IOPAD(pa, val)      OMAP_IOPAD_OFFSET((pa), 0xc840) (val)
> --
> 1.8.0
>
