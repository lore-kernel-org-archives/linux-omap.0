From: Silesh C V <silesh@ti.com>
Subject: Re: [PATCH] OMAP: PM: CPUFREQ: Fix conditional compilation
Date: Mon, 27 Sep 2010 11:49:46 +0530
Message-ID: <AANLkTikWWyfgUOYyXud0D0vpMwAn2xxUKM=dNPoYsCK0@mail.gmail.com>
References: <1285318494-22092-1-git-send-email-silesh@ti.com>
	<87pqw3ji5i.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37165 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab0I0GTr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 02:19:47 -0400
Received: by iwn5 with SMTP id 5so4508118iwn.19
        for <linux-omap@vger.kernel.org>; Sun, 26 Sep 2010 23:19:47 -0700 (PDT)
In-Reply-To: <87pqw3ji5i.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Fri, Sep 24, 2010 at 8:36 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Silesh C V <silesh@ti.com> writes:
>
>> Fix conditional compilation.
>
> What excatly was the compile error? =A0and with which compiler?

There is no compiler error.But what we need after an #elif is a
conditional expression.
The correct usage is #elif defined(CONFIG_XXX) rather than #elif CONFIG=
_XXX.

=46urther, if the kernel is configured for a non-omap3 arch (eg.OMAP4),
you get a compiler warning:
arch/arm/plat-omap/cpu-omap.c:47:7: warning: "CONFIG_ARCH_OMAP3" is not=
 defined
which goes away with this patch.

>
> The current pm branch =A0seems to compile fine for me.
>
> Kevin
>

Thanks,
Silesh.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
