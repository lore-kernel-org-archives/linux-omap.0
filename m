From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH-V4 0/3] ARM: OMAP: Make OMAP clocksource source selection runtime
Date: Tue, 24 Apr 2012 15:36:43 +0530
Message-ID: <CAMQu2gzHQ-ku3akGWqUGN+EC3Jo7LtXbohqfVT=fG4Y0VFttng@mail.gmail.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:51212 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756633Ab2DXKHG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 06:07:06 -0400
Received: by qafi29 with SMTP id i29so2049493qaf.15
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 03:07:03 -0700 (PDT)
In-Reply-To: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, Apr 24, 2012 at 3:15 PM, Vaibhav Hiremath <hvaibhav@ti.com> wro=
te:
> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)
>
> This patch series cleans up the existing 32k-sync timer implementatio=
n
> without any major code changes, uses kernel parameter to override
> the default clocksource of "counter_32k", also in order to support
> some OMAP based derivative SoCs like AM33XX which doesn't have
> 32K sync-timer hardware IP, adds hwmod lookup for omap2+
> devices, and if lookup fails then fall back to gp-timer.
>
> if(use_gptimer_clksrc =3D=3D true)
> =A0 =A0 =A0 =A0gptimer clocksource init;
> else if (counter_32 init =3D=3D false)
> =A0 =A0 =A0 =A0/* Fallback to gptimer */
> =A0 =A0 =A0 =A0gptimer clocksource init(;
>
> With this, we should be able to support multi-omap boot
> including devices with/without 32k-sync timer.
>
> This patch-series has been boot tested on AM37xEVM platform, it
> would be helpful if somebody help me to validate it on OMAP1/2
> platforms.
>
> The patches are also available at -
> https://github.com/hvaibhav/am335x-linux =A0 32ksync-timer-cleanup
>
> History:
> =3D=3D=3D=3D=3D=3D=3D=3D
> Changes from V3:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg66462.html
> =A0 =A0 =A0 =A0- Fixed all review comments from Kevin H
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Moved counter_32k CR register offset=
 handling to
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0counter_32k.c file, so now, callin=
g funtion don't have
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0to maintain or add offset to base =
addr.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Added comment for funtion omap_init_=
clocksource_32k()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Used resource_size() for calculate s=
ize
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Convert WARN_ON to pr_warn
>
Have given my reviewed-by on v2. Just quickly scanned the series
based on above minor updates.
=46eel free to add,
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
