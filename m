From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Compilation: omap-for-linus omap2plus error
Date: Thu, 30 Sep 2010 22:10:18 +0800
Message-ID: <AANLkTi=+rJzW_GJxj7HsOomcWc3erwHSCN5vGYSr7Za2@mail.gmail.com>
References: <4CA409E3.8000800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50742 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab0I3OKV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 10:10:21 -0400
Received: by wyb28 with SMTP id 28so1887634wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 07:10:19 -0700 (PDT)
In-Reply-To: <4CA409E3.8000800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abraham Arce <x0066660@ti.com>
Cc: linux-omap@vger.kernel.org

2010/9/30 Abraham Arce <x0066660@ti.com>:
> Hi,
>
> Is there any patch missing in omap-for-linus branch?
>
> =A0CC =A0 =A0 =A0arch/arm/mach-omap2/pm_bus.o
> arch/arm/mach-omap2/pm_bus.c: In function 'omap_pm_runtime_init':
> arch/arm/mach-omap2/pm_bus.c:64: error: implicit declaration of funct=
ion
> 'platform_bus_get_pm_ops'
> arch/arm/mach-omap2/pm_bus.c:64: warning: assignment makes pointer fr=
om
> integer without a cast
> arch/arm/mach-omap2/pm_bus.c:81: error: implicit declaration of funct=
ion
> 'platform_bus_set_pm_ops'
> make[1]: *** [arch/arm/mach-omap2/pm_bus.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

This issue also exists in pm-hwmods branch.


--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
