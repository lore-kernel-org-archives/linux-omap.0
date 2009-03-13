From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] Add new C state
Date: Fri, 13 Mar 2009 13:39:42 +0200
Message-ID: <6ed0b2680903130439g2c9570cfm410f5b3ad04f1948@mail.gmail.com>
References: <1236700866-30760-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:50198 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbZCMLqR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 07:46:17 -0400
Received: by fxm24 with SMTP id 24so2610510fxm.37
        for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2009 04:46:14 -0700 (PDT)
In-Reply-To: <1236700866-30760-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Tue, Mar 10, 2009 at 6:01 PM, Peter 'p2' De Schrijver
<peter.de-schrijver@nokia.com> wrote:
> This patch introduces a new C state which allows MPU to go to WFI but=
 keeps
> the core domain active. This offers a much better wakeup latency (3us=
 vs
> 10s of us for the current C1) at the cost of a higher power consumpti=
on.
>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0119 +++++++++++++++++++++++=
-------------
> =A01 files changed, 76 insertions(+), 43 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 62fbb2e..5565aa7 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -26,6 +26,7 @@
> =A0#include <mach/pm.h>
> =A0#include <mach/prcm.h>
> =A0#include <mach/powerdomain.h>
> +#include <mach/clockdomain.h>
> =A0#include <mach/control.h>
> =A0#include <mach/serial.h>
>
> @@ -33,13 +34,14 @@
>
> =A0#ifdef CONFIG_CPU_IDLE
>
> -#define OMAP3_MAX_STATES 7
> +#define OMAP3_MAX_STATES 8
> =A0#define OMAP3_STATE_C1 1 /* C1 - MPU WFI + Core active */
> -#define OMAP3_STATE_C2 2 /* C2 - MPU CSWR + Core active */
> -#define OMAP3_STATE_C3 3 /* C3 - MPU OFF + Core active */
> -#define OMAP3_STATE_C4 4 /* C4 - MPU RET + Core RET */
> -#define OMAP3_STATE_C5 5 /* C5 - MPU OFF + Core RET */
> -#define OMAP3_STATE_C6 6 /* C6 - MPU OFF + Core OFF */
> +#define OMAP3_STATE_C2 2 /* C2 - MPU WFI + Core inactive */
> +#define OMAP3_STATE_C3 3 /* C2 - MPU CSWR + Core inactive */
> +#define OMAP3_STATE_C4 4 /* C3 - MPU OFF + Core iactive */
> +#define OMAP3_STATE_C5 5 /* C4 - MPU RET + Core RET */
> +#define OMAP3_STATE_C6 6 /* C5 - MPU OFF + Core RET */
> +#define OMAP3_STATE_C7 7 /* C6 - MPU OFF + Core OFF */

Comments don't match the defines here.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
