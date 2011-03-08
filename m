From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v8 1/7] omap3: pm: Fix for the TRITON sleep/wakeup sequence
Date: Tue, 8 Mar 2011 18:44:28 +0530
Message-ID: <AANLkTi=6TQX7JNRR9QB1iKxWha8feMnREe5miW2K7KcC@mail.gmail.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com> <1299072653-13414-2-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58374 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753589Ab1CHNOy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 08:14:54 -0500
Received: by mail-ey0-f169.google.com with SMTP id 6so2114609eyh.28
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 05:14:48 -0800 (PST)
In-Reply-To: <1299072653-13414-2-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

minor comment - here and elsewhere - "OMAP", PM is a good idea to be
caps even in $subject.

On Wed, Mar 2, 2011 at 19:00, Lesly A M <leslyam@ti.com> wrote:
>
> Only configure sleep script when the flag is TWL4030_SLEEP_SCRIPT.
>
> Adding the missing brackets for fixing the issue.
>
> Signed-off-by: Lesly A M <leslyam@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
> =A0drivers/mfd/twl4030-power.c | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index 16422de..2c0d4d1 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -447,12 +447,13 @@ static int __init load_twl4030_script(struct tw=
l4030_script *tscript,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 if (tscript->flags & TWL4030_SLEEP_SCRIPT)
> + =A0 =A0 =A0 if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (order)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("TWL4030: B=
ad order of scripts (sleep "\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"script before wakeup) Leads to boot"\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"failure on some boards\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D twl4030_config_sleep_sequence(=
address);
> + =A0 =A0 =A0 }
> =A0out:
> =A0 =A0 =A0 =A0return err;
> =A0}
> --
> 1.7.1
>
Otherwise, looks fine to me.
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
