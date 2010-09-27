From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH] OMAP: PM: CPUFREQ: Fix conditional compilation
Date: Mon, 27 Sep 2010 13:00:59 +0530
Message-ID: <AANLkTimT0bfNjBThHj8bPAZ+ybfV=PFJkj09AUL0M20g@mail.gmail.com>
References: <1285318494-22092-1-git-send-email-silesh@ti.com>
	<87pqw3ji5i.fsf@deeprootsystems.com>
	<AANLkTikWWyfgUOYyXud0D0vpMwAn2xxUKM=dNPoYsCK0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64191 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0I0HbD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 03:31:03 -0400
Received: by wyb28 with SMTP id 28so3577039wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Sep 2010 00:31:02 -0700 (PDT)
In-Reply-To: <AANLkTikWWyfgUOYyXud0D0vpMwAn2xxUKM=dNPoYsCK0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Silesh C V <silesh@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Mon, Sep 27, 2010 at 11:49 AM, Silesh C V <silesh@ti.com> wrote:
> On Fri, Sep 24, 2010 at 8:36 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Silesh C V <silesh@ti.com> writes:
>>
>>> Fix conditional compilation.
>>
>> What excatly was the compile error? =A0and with which compiler?
>
> There is no compiler error.But what we need after an #elif is a
> conditional expression.
> The correct usage is #elif defined(CONFIG_XXX) rather than #elif CONF=
IG_XXX.
>
> Further, if the kernel is configured for a non-omap3 arch (eg.OMAP4),
> you get a compiler warning:
> arch/arm/plat-omap/cpu-omap.c:47:7: warning: "CONFIG_ARCH_OMAP3" is n=
ot defined
> which goes away with this patch.
>

Silesh,

which defconfig are you using with multi omap-build defconfig(omap3_def=
config)

CONFIG_ARCH_OMAP3 will be enabled. So this compilation error will not o=
ccur.

---
Regards,
Govindraj.R


>>
>> The current pm branch =A0seems to compile fine for me.
>>
>> Kevin
>>
>
> Thanks,
> Silesh.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
