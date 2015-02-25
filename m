From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 7/8 v2] ARM OMAP2+ GPMC: calculate GPMCFCLKDIVIDER based
 on WAITMONITORINGTIME
Date: Wed, 25 Feb 2015 18:24:26 +0100
Message-ID: <54EE054A.7060203@cit-ec.uni-bielefeld.de>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-7-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDF969.1070902@ti.com> <54EE0468.3090000@ti.com>
Reply-To: rabel@cit-ec.uni-bielefeld.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EE0468.3090000@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On 25 Feb 2015 18:20, Roger Quadros wrote:
> Need to patch mach-omap2/usb-tusb6010.c as well. else we get
>
> arch/arm/mach-omap2/usb-tusb6010.c: In function =E2=80=98tusb_set_asy=
nc_mode=E2=80=99:
> arch/arm/mach-omap2/usb-tusb6010.c:74:2: error: too few arguments to =
function =E2=80=98gpmc_cs_set_timings=E2=80=99
> In file included from arch/arm/mach-omap2/gpmc.h:14:0,
>                   from arch/arm/mach-omap2/usb-tusb6010.c:23:
> include/linux/omap-gpmc.h:166:12: note: declared here
> arch/arm/mach-omap2/usb-tusb6010.c: In function =E2=80=98tusb_set_syn=
c_mode=E2=80=99:
> arch/arm/mach-omap2/usb-tusb6010.c:101:2: error: too few arguments to=
 function =E2=80=98gpmc_cs_set_timings=E2=80=99
> In file included from arch/arm/mach-omap2/gpmc.h:14:0,
>                   from arch/arm/mach-omap2/usb-tusb6010.c:23:
> include/linux/omap-gpmc.h:166:12: note: declared here
Argh... Another one of those exported function calls :|

Robert
