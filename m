From: Abraham Arce <abraham.arce.moreno@gmail.com>
Subject: Re: Compilation: omap-for-linus omap2plus error
Date: Wed, 29 Sep 2010 23:16:45 -0500
Message-ID: <AANLkTinONbTyE4CKDnGfXrco-qy0=u_MpzimpCSnDZr7@mail.gmail.com>
References: <4CA409E3.8000800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48847 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab0I3EQq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 00:16:46 -0400
Received: by fxm4 with SMTP id 4so470068fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 21:16:45 -0700 (PDT)
In-Reply-To: <4CA409E3.8000800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abraham Arce <x0066660@ti.com>
Cc: linux-omap@vger.kernel.org

Adding more info to previous email, email account changed

On Wed, Sep 29, 2010 at 10:54 PM, Abraham Arce <x0066660@ti.com> wrote:
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
>

I am trying using following commit as latest

Kevin Hilman
7ad0e386d46e9edff64705ab25337ad9130baf63
OMAP2+: defconfig: disable CPUfreq

Best Regards
Abraham
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
