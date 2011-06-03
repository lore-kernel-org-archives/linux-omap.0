From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 15/15] OMAP: GPIO: clean omap_gpio_mod_init function
Date: Fri, 03 Jun 2011 07:31:45 -0700
Message-ID: <87d3ivkmum.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-16-git-send-email-tarun.kanti@ti.com>
	<87r57mjq9d.fsf@ti.com>
	<BANLkTi=e1PowoD7er46g1q+8EOqLfJNGTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46301 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752345Ab1FCObv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Jun 2011 10:31:51 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so1001902pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 07:31:48 -0700 (PDT)
In-Reply-To: <BANLkTi=e1PowoD7er46g1q+8EOqLfJNGTQ@mail.gmail.com> (Charulatha
	Varadarajan's message of "Fri, 3 Jun 2011 16:50:02 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Kevin,
>
> On Thu, May 26, 2011 at 05:18, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> From: Charulatha V <charu@ti.com>
>>>
>>> With register offsets now defined for respective OMAP versions
>>> we can get rid of cpu_class_* checks. In addition, organized
>>> common initialization for the different OMAP silicon versions.
>>>
>>> Signed-off-by: Charulatha V <charu@ti.com>
>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>
>> The sysconfig stuff in this patch should be removed. =C2=A0In fact, =
now that
>> hwmod is used to manage all the GPIO IP blocks, the driver should no=
t be
>> touching sysconfig at all.
>
> The sysconfig stuff in this patch is for OMAP16XX.
>

Ah, OK.  Sorry I missed that.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
