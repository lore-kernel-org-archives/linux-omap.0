From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 0/5] New mux code for 34xx
Date: Thu, 29 Oct 2009 23:19:40 +0200
Message-ID: <f870da180910291419l1ed0f663xb3c6042a07dec55d@mail.gmail.com>
References: <20091029203124.11843.89983.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:55016 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbZJ2VTg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 17:19:36 -0400
Received: by iwn10 with SMTP id 10so1692473iwn.4
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 14:19:41 -0700 (PDT)
In-Reply-To: <20091029203124.11843.89983.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

On Thu, Oct 29, 2009 at 10:35 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> Hi all,
>
> Here's an initial version of the new mux code to play with.
> Big thanks to Paul & Benoit for the 34xx mux data!
>
> To try out the new code, compile a kernel with CONFIG_OMAP_MUX
> and CONFIG_DEBUG_FS and these patches. The series is also
> availabe in the l-o git in mux branch.

Great work! I'm too sleepy now to make proper review, and I'm trying
not to take work home, so I'll pull and test your patches only next
week.
And, still, I'm missing PXA-style defines for particular pin
configuration :) I really like
       OMAP3_CAM_D0_GPIO_99,
more than
       OMAP3_MUX(CAM_D0, OMAP_PIN_OUTPUT | OMAP_PIN_OFF_NONE |
OMAP_MUX_MODE4, 0),
:)

> To see the mux configuration on your board:
>
> # mount -t debugfs debugfs /sys/kernel/debug
> # cat /sys/kernel/debug/omap_mux | less
> OMAP3_MUX(CAM_D0, OMAP_PIN_INPUT | OMAP_PIN_OFF_NONE | OMAP_PIN_OFF_W=
AKEUPENABLE
> =A0| OMAP_MUX_MODE4, 0),
> padconf: cam_d0 signal: gpio_99: =A0 =A0 =A0 =A0offset: 0x0e6 =A0 val=
ue: 0x4104
> m0: cam_d0 =A0 =A0 =A0m1: =A0 =A0 =A0 =A0 =A0 =A0 m2: =A0 =A0 =A0 =A0=
 =A0 =A0 m3:
> m4: gpio_99 =A0 =A0 m5: =A0 =A0 =A0 =A0 =A0 =A0 m6: =A0 =A0 =A0 =A0 =A0=
 =A0 m7: safe_mode
> phys: 0x48002116 =A0 =A0 =A0 =A0ball bottom: ag17 =A0 =A0 =A0 =A0ball=
 top:
>
> OMAP3_MUX(CAM_D10, OMAP_PIN_OUTPUT | OMAP_PIN_OFF_NONE | OMAP_MUX_MOD=
E7, 0),
> padconf: cam_d10 =A0 =A0 =A0 =A0signal: safe_mode: =A0 =A0 =A0offset:=
 0x0fa =A0 value: 0x0007
> m0: cam_d10 =A0 =A0 m1: =A0 =A0 =A0 =A0 =A0 =A0 m2: =A0 =A0 =A0 =A0 =A0=
 =A0 m3:
> m4: gpio_109 =A0 =A0m5: =A0 =A0 =A0 =A0 =A0 =A0 m6: =A0 =A0 =A0 =A0 =A0=
 =A0 m7: safe_mode
> phys: 0x4800212a =A0 =A0 =A0 =A0ball bottom: b25 =A0 =A0 =A0 =A0 ball=
 top:
> ...
>
> Then to produce a list of board mux entries from a working
> system, do:
>
> # cat /sys/kernel/debug/omap_mux | grep OMAP3_MUX
> OMAP3_MUX(CAM_D0, OMAP_PIN_INPUT | OMAP_PIN_OFF_NONE | OMAP_PIN_OFF_W=
AKEUPENABLE
> =A0| OMAP_MUX_MODE4, 0),
> OMAP3_MUX(CAM_D10, OMAP_PIN_OUTPUT | OMAP_PIN_OFF_NONE | OMAP_MUX_MOD=
E7, 0),
> OMAP3_MUX(CAM_D11, OMAP_PIN_INPUT | OMAP_PIN_OFF_NONE | OMAP_PIN_OFF_=
WAKEUPENABL
> E | OMAP_MUX_MODE4, 0),
> OMAP3_MUX(CAM_D1, OMAP_PIN_INPUT | OMAP_PIN_INPUT_PULLUP | OMAP_PIN_O=
=46F_NONE | O
> MAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE4, 0),
> ...
>
> Currenly no write support to tweak the pins via debugfs,
> but I'll add that soon with command line support too.
>
> I have not really verified the data yet, but it mostly looks
> right. Adding support for 3630 and omap4 should be easy
> after generating the data. It's currently implemented only
> for 34xx.
>
> I guess the next step would be to convert all omap3 calls
> to omap_cfg_reg() to use omap_mux_set() instead with the
> new data and make sure things work. Then we can remove the
> old data for 34xx.
>
> Comments welcome as always.
>
> Regards,
>
> Tony
>
>
> ---
>
> Mike Rapoport (1):
> =A0 =A0 =A0omap2: mux: intoduce omap_mux_{read,write}
>
> Tony Lindgren (4):
> =A0 =A0 =A0omap: mux: Add debugfs support for new mux code
> =A0 =A0 =A0omap: mux: Add new style init functions to omap3 board-*.c=
 files
> =A0 =A0 =A0omap: mux: Add new style pin multiplexing data for 34xx
> =A0 =A0 =A0omap: mux: Add new style pin multiplexing code for omap3
>
>
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0| =A0 =A09
> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 | =A0 =A09
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0| =A0 =A09
> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0| =A0 =A09
> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 | =A0 =A09
> =A0arch/arm/mach-omap2/board-omap3pandora.c | =A0 =A09
> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 =A0| =A0 =A08
> =A0arch/arm/mach-omap2/board-rx51.c =A0 =A0 =A0 =A0 | =A0 10
> =A0arch/arm/mach-omap2/board-zoom2.c =A0 =A0 =A0 =A0| =A0 =A08
> =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0424 =
++++++++
> =A0arch/arm/mach-omap2/mux.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0127 =
++
> =A0arch/arm/mach-omap2/mux34xx.c =A0 =A0 =A0 =A0 =A0 =A0| 1552 ++++++=
++++++++++++++++++++++++
> =A0arch/arm/mach-omap2/mux34xx.h =A0 =A0 =A0 =A0 =A0 =A0| =A0352 ++++=
+++
> =A014 files changed, 2533 insertions(+), 6 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/mux.h
> =A0create mode 100644 arch/arm/mach-omap2/mux34xx.c
> =A0create mode 100644 arch/arm/mach-omap2/mux34xx.h
>
> --
> Signature
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
