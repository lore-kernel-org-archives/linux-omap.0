From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] pinctrl: dra: dt-bindings: Fix output pull up/down
Date: Mon, 3 Nov 2014 08:30:23 -0600
Message-ID: <20141103143023.GA8260@kahuna>
References: <1414752745-13696-1-git-send-email-rogerq@ti.com>
 <1415009392-6627-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52278 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbaKCOa0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Nov 2014 09:30:26 -0500
Content-Disposition: inline
In-Reply-To: <1415009392-6627-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On 12:09-20141103, Roger Quadros wrote:
> For PIN_OUTPUT_PULLUP and PIN_OUTPUT_PULLDOWN we must not set the
> PULL_DIS bit which disables the PULLs.
> 
> PULL_ENA is a 0 and using it in an OR operation is a NOP, so don't
> use it in the PIN_OUTPUT_PULLUP/DOWN macros.
> 
> Fixes: 23d9cec07c58 ("pinctrl: dra: dt-bindings: Fix pull enable/disable")
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  include/dt-bindings/pinctrl/dra.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
> index 3d33794..7448edf 100644
> --- a/include/dt-bindings/pinctrl/dra.h
> +++ b/include/dt-bindings/pinctrl/dra.h
> @@ -40,8 +40,8 @@
>  
>  /* Active pin states */
>  #define PIN_OUTPUT		(0 | PULL_DIS)
> -#define PIN_OUTPUT_PULLUP	(PIN_OUTPUT | PULL_ENA | PULL_UP)
> -#define PIN_OUTPUT_PULLDOWN	(PIN_OUTPUT | PULL_ENA)
> +#define PIN_OUTPUT_PULLUP	(PULL_UP)
> +#define PIN_OUTPUT_PULLDOWN	(0)
>  #define PIN_INPUT		(INPUT_EN | PULL_DIS)
>  #define PIN_INPUT_SLEW		(INPUT_EN | SLEWCONTROL)
>  #define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)

You are right, we do have an issue with using PIN_OUTPUT along with
remaining setting.

For a moment, I wondered why input was not impacted - then I realized
that INPUT_EN was being used instead of PIN_INPUT - following that
convention. With the intent being explicitly using macros that
clearly indicate what each setting combination is is, how about the
following?


diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
index 3d33794..d4037e7 100644
--- a/include/dt-bindings/pinctrl/dra.h
+++ b/include/dt-bindings/pinctrl/dra.h
@@ -34,14 +34,15 @@
 #define PULL_DIS		(1 << 16)
 #define PULL_UP			(1 << 17)
 #define INPUT_EN		(1 << 18)
+#define OUTPUT_EN		(0 << 18)
 #define SLEWCONTROL		(1 << 19)
 #define WAKEUP_EN		(1 << 24)
 #define WAKEUP_EVENT		(1 << 25)
 
 /* Active pin states */
-#define PIN_OUTPUT		(0 | PULL_DIS)
-#define PIN_OUTPUT_PULLUP	(PIN_OUTPUT | PULL_ENA | PULL_UP)
-#define PIN_OUTPUT_PULLDOWN	(PIN_OUTPUT | PULL_ENA)
+#define PIN_OUTPUT		(OUTPUT_EN | PULL_DIS)
+#define PIN_OUTPUT_PULLUP	(OUTPUT_EN | PULL_ENA | PULL_UP)
+#define PIN_OUTPUT_PULLDOWN	(OUTPUT_EN | PULL_ENA)
 #define PIN_INPUT		(INPUT_EN | PULL_DIS)
 #define PIN_INPUT_SLEW		(INPUT_EN | SLEWCONTROL)
 #define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)

-- 
Regards,
Nishanth Menon
