From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC PATCH 02/10] ZOOM: QUART: Request reset GPIO
Date: Fri, 20 May 2011 13:53:26 +0530
Message-ID: <BANLkTinTd-pztR0X=Tdy04fCVUT7eqC9Pg@mail.gmail.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
 <1305546104-1511-3-git-send-email-tarun.kanti@ti.com> <87ipt67jr6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:40776 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934559Ab1ETIYI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 04:24:08 -0400
Received: by iwl42 with SMTP id 42so3624613iwl.32
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 01:24:06 -0700 (PDT)
In-Reply-To: <87ipt67jr6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

On Thu, May 19, 2011 at 21:41, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> Reset GPIO (OMAP_GPIO_152) for QUART in zoom2/zoom3 debug-board is
>> not requested at all. This would lead to problems if this GPIO is
>> wrongly requested. Hence request OMAP GPIO 152 for QUART RESET but
>> do not apply a reset pulse as it would reset QUART and
>> disturb the QUART settings.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>
> This is a bug fix that should be separated from this series, and sent=
 to
> l-o as a fix. =A0Also, please Cc linux-arm-kernel.

ok.

>
> Feel free to add
>
> Acked-by: Kevin Hilman <khilman@ti.com>

Thanks

-V Charulatha

>
> Thanks,
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
