From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v8 2/7] omap3: pm: Correct the warning print during script loading
Date: Tue, 8 Mar 2011 18:48:16 +0530
Message-ID: <AANLkTinkqrmspcY04LTwZS2g6Fy+6gEK5fJFVK1pMe1k@mail.gmail.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com> <1299072653-13414-3-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:52329 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754211Ab1CHNSj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 08:18:39 -0500
Received: by mail-ew0-f44.google.com with SMTP id 9so2629567ewy.17
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 05:18:36 -0800 (PST)
In-Reply-To: <1299072653-13414-3-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Mar 2, 2011 at 19:00, Lesly A M <leslyam@ti.com> wrote:
> Correcting the if condition check for printing the warning,
> if wakeup script is not updated before updating the sleep script.
>
> Since the flag 'order' is set to '1' while updating the wakeup script=
 for P1P2,
> the condition checking for printing the warning should be if(!order)
> (ie: print the warning if wakeup script is not updated before updatin=
g the sleep script)
>
> Signed-off-by: Lesly A M <leslyam@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
> =A0drivers/mfd/twl4030-power.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index 2c0d4d1..8373d79 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -448,7 +448,7 @@ static int __init load_twl4030_script(struct twl4=
030_script *tscript,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (order)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!order)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("TWL4030: B=
ad order of scripts (sleep "\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"script before wakeup) Leads to boot"\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"failure on some boards\n");
> --
> 1.7.1
>
>
Acked-by: Nishanth Menon <nm@ti.com>

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
