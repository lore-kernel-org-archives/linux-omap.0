From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: omap clocksource timer selection: dmtimer OR 32K-Sync timer
Date: Fri, 13 Jan 2012 13:49:24 +0100
Message-ID: <CAMQu2gxYQOHX8n2RLfkLBw5hQMdvH389DfrguLtzpLcpmqBQMA@mail.gmail.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41496 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752910Ab2AMMtq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 07:49:46 -0500
Received: by mail-qw0-f46.google.com with SMTP id c26so601225qad.12
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 04:49:45 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King <rmk@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 13, 2012 at 1:21 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
> Hi,
>
> In case of AM33xx family of devices, we do not have 32K Sync timer
> (32K Counter) available; and the current implementation is based on
> compile-time option, where clock-source is chosen by something like,
>
> File - arch/arm/mach-omap2/timer.c
>
> #ifdef CONFIG_OMAP_32K_TIMER
> static void __init omap2_gp_clocksource_init(int unused, const char *=
dummy)
> {
> ...
> }
> #else
> static void __init omap2_gp_clocksource_init(int unused, const char *=
dummy)
> {
> ...
> }
> #endif
>
>
> But in order to support multi-omap build, we must
> make run-time decision to use the timer for kernel clock-source, eith=
er of -
>
> =A0- DMTIMER
> =A0- 32K Sync Timer
>
> The DMTIMER is already migrated to the HWMOD framework, but 32K Timer=
 code
> has not yet migrated to it. So the question here is,
>
> 1) Does it make sense to migrate counter_32k.c to search entry in hwm=
od
> =A0 table and if 32k_sync timer is available in hwmod table then use =
32K
> =A0 timer for Kernel clock-source
> =A0 OR
> =A0 Fall back to DMTIMER.
>
> =A0 OMAP4 hwmod table already has entry,
>
> =A0 static struct omap_hwmod omap44xx_counter_32k_hwmod =3D {
> =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "counter_32k",
> =A0 ...
> =A0 };
>
> =A0 We need to have similar entries in all devices where 32K timer is=
 present.
>
> 2) OR simply add another cpu_is_am33xx() and then fall back to dmtime=
r?
> =A0 Just to prove this, everything works here, I modified the code fo=
r this
> =A0 and tested it on both AM335x EVM and AM37xEVM and it works fine f=
or me.
>
>
> Any comments?? OR Better approach? OR anything which I am missing her=
e?
>
You can register both the clock sources together with different
rating. Based on rating
timer code will automatically pick the better clock-source of two.
Ratings is based on the resolution of the timer.

That should remove the CONFIG option depedency.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
