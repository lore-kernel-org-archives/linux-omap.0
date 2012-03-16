From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 0/2] omap: board file changes to support dynamic irq alloc
Date: Fri, 16 Mar 2012 19:22:08 +0530
Message-ID: <CAC83Zv+zEn-VejJ1TVkFqDC4NaLybi2Ur7SmyC55YMMVWZ7T4Q@mail.gmail.com>
References: <1331900647-3508-1-git-send-email-tarun.kanti@ti.com>
	<4F634434.3080707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:43544 "HELO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161168Ab2CPNwJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 09:52:09 -0400
Received: by mail-yx0-f169.google.com with SMTP id m8so5310263yen.14
        for <linux-omap@vger.kernel.org>; Fri, 16 Mar 2012 06:52:08 -0700 (PDT)
In-Reply-To: <4F634434.3080707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org

On Fri, Mar 16, 2012 at 7:16 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Tarun,
>
> On 3/16/2012 1:24 PM, Tarun Kanti DebBarma wrote:
>> These two patches incorporate changes to OMAP1 and OMAP2 platforms
>> board files whereby older references to OMAP_GPIO_IRQ macro are
>> now replaced with gpio_to_irq(), thereby getting rid of static
>> irq references.
>
> Thanks for the board fix / cleanup.
>
> ...
>
>> =A0 arch/arm/mach-omap1/board-h2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A08 ++++----
>> =A0 arch/arm/mach-omap1/board-h3.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A08 ++++----
>> =A0 arch/arm/mach-omap1/board-htcherald.c =A0 =A0 =A0 =A0| =A0 =A06 =
+++---
>> =A0 arch/arm/mach-omap1/board-innovator.c =A0 =A0 =A0 =A0| =A0 =A04 =
++--
>> =A0 arch/arm/mach-omap1/board-nokia770.c =A0 =A0 =A0 =A0 | =A0 =A01 =
+
>> =A0 arch/arm/mach-omap1/board-osk.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 12 ++++++------
>> =A0 arch/arm/mach-omap1/board-palmte.c =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
>> =A0 arch/arm/mach-omap1/board-palmtt.c =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
>> =A0 arch/arm/mach-omap1/board-palmz71.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
>> =A0 arch/arm/mach-omap1/board-voiceblue.c =A0 =A0 =A0 =A0| =A0 16 ++=
+++++---------
>> =A0 arch/arm/mach-omap2/board-2430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
>> =A0 arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
>> =A0 arch/arm/mach-omap2/board-apollon.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
6 ++++--
>> =A0 arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 =A0 | =A0 =A03 ++=
-
>> =A0 arch/arm/mach-omap2/board-h4.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
>> =A0 arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 | =A0 =A02 =
+-
>> =A0 arch/arm/mach-omap2/board-omap4panda.c =A0 =A0 =A0 | =A0 =A02 +-
>> =A0 arch/arm/mach-omap2/board-rx51-peripherals.c | =A0 =A03 ++-
>> =A0 arch/arm/mach-omap2/board-zoom-debugboard.c =A0| =A0 =A03 ++-
>> =A0 arch/arm/mach-omap2/board-zoom-peripherals.c | =A0 =A06 ++++--
>> =A0 arch/arm/mach-omap2/common-board-devices.c =A0 | =A0 =A02 +-
>
> I guess, you should be able to remove even the MACRO definition?
Yes, there is another file referring to this macro.
I will check and update before removing the macro.

>
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-o=
map/include/plat/gpio.h
> index 9e86ee0..d4df414 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -158,10 +158,6 @@
> =A0#define OMAP_MPUIO(nr) =A0 =A0 =A0 =A0 (OMAP_MAX_GPIO_LINES + (nr)=
)
> =A0#define OMAP_GPIO_IS_MPUIO(nr) ((nr) >=3D OMAP_MAX_GPIO_LINES)
>
> -#define OMAP_GPIO_IRQ(nr) =A0 =A0 =A0(OMAP_GPIO_IS_MPUIO(nr) ? \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IH_M=
PUIO_BASE + ((nr) & 0x0f) : \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IH_G=
PIO_BASE + (nr))
> -
> =A0#define METHOD_MPUIO =A0 =A0 =A0 =A0 =A0 0
> =A0#define METHOD_GPIO_1510 =A0 =A0 =A0 1
> =A0#define METHOD_GPIO_1610 =A0 =A0 =A0 2
>
>
> It will avoid that people use it going forward.
Right. Thanks.
--
Tarun
>
> Regards,
> Benoit
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
