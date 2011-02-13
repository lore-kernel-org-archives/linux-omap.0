From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH 6/6] ARM: pm: allow generic sleep code to be used with SMP
 CPU idle
Date: Sun, 13 Feb 2011 13:59:54 -0800
Message-ID: <AANLkTimmSbs7Q_068ERWeKUFV_1Fyxvj37e3r21LZYCL@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1PnviF-0002yt-EC@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:52932 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1BMV77 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Feb 2011 16:59:59 -0500
Received: from kpbe15.cbf.corp.google.com (kpbe15.cbf.corp.google.com [172.25.105.79])
	by smtp-out.google.com with ESMTP id p1DLxuTe004775
	for <linux-omap@vger.kernel.org>; Sun, 13 Feb 2011 13:59:57 -0800
Received: from vws11 (vws11.prod.google.com [10.241.21.139])
	by kpbe15.cbf.corp.google.com with ESMTP id p1DLxtj6028882
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Sun, 13 Feb 2011 13:59:55 -0800
Received: by vws11 with SMTP id 11so3232854vws.15
        for <linux-omap@vger.kernel.org>; Sun, 13 Feb 2011 13:59:55 -0800 (PST)
In-Reply-To: <E1PnviF-0002yt-EC@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 8:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Allow the generic sleep code to be used with SMP CPU idle by storing
> N CPU stack pointers rather than just one.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =A0arch/arm/kernel/sleep.S | =A0 26 +++++++++++++++++++++++++-
> =A01 files changed, 25 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index 9f106fa..e10618f 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S

<snip>

> @@ -107,4 +129,6 @@ ENTRY(cpu_resume)
> =A0ENDPROC(cpu_resume)
>
> =A0sleep_save_sp:
> - =A0 =A0 =A0 .word =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 @ preserve stack phys ptr here
> + =A0 =A0 =A0 .rept =A0 CONFIG_NR_CPUS
> + =A0 =A0 =A0 .long =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 @ preserve stack phys ptr here
> + =A0 =A0 =A0 .endr

This doesn't compile on CONFIG_SMP=3Dn, CONFIG_NR_CPUS is undefined.
Including linux/threads.h will provide a default definition.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
