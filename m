From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH v10 0/7] MFD: TWL4030: power script and workaround for
 erratum 27
Date: Thu, 2 Jun 2011 08:36:44 -0700
Message-ID: <BANLkTinEmyxuNb9p=VNkeLM1zMcxqBiCzA@mail.gmail.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46980 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab1FBPgo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 11:36:44 -0400
Received: by vxi39 with SMTP id 39so714932vxi.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 08:36:44 -0700 (PDT)
In-Reply-To: <1304687833-4578-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Fri, May 6, 2011 at 6:17 AM, Lesly A M <leslyam@ti.com> wrote:
> Patch series for TWL4030 power scripts for OMAP3 boards and
> workaround for TWL erratum 27.
>
> Changes for implementing TWL4030 power scripts recommended by hardwar=
e team.
> Introduced a new TWL4030 power script file, which can be used by diff=
erent
> OMAP3 board with the power companion chip TWL4030.
>
> Updated the changes for TWL4030 errata 27 & 28, and modified
> the TWL4030 power script.
> Workaround for TWL4030 erratum 27 is required for Si version less tha=
n or
> equal to TWL5030 ES1.1.
>
> TWL4030 script changes re-based on Kevin's PM tree in pm branch.
>
> This patch series have a dependency with the patch:
> =A0 =A0 =A0 =A0http://www.spinics.net/lists/linux-omap/msg50547.html
>
> Changes in v7:
> =A0 =A0 =A0 =A0changes to fix Nishanth Menon's comments
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) Added the workaround for TWL4030 Er=
ratum 27
>
> =A0 =A0 =A0 =A0split the first patch in v6
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) =A0fix for twl4030 script load
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ii) correct the warning print during s=
cript loading
>
> =A0 =A0 =A0 =A0Added new patch files
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) changing sys_off signal polarity
>
> Changes in v8:
> =A0 =A0 =A0 =A0updated the change logs
> =A0 =A0 =A0 =A0moving the TWL IDCODE checking to twl-core.c
>
> Changes in V9:
> =A0 =A0 =A0 =A0changes to fix David Derrick's comments
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) turn OFF the NRES_PWRON resource in=
 warm reset sequence
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ii) optimize the i2c writes during res=
ource configuration
>
> Changes in V10:
> =A0 =A0 =A0 =A0changes for Tony's comments
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) making the TWL4030 power scripts lo=
adable module
>
> Since the voltage layer is evolving to a new design, the voltage depe=
ndant
> changes required for the TWL4030 script are not incorporated in the p=
atch series.
> So this TWL4030 script patch series can be tested with a separate pat=
ch for
> voltage layer changes.
>
> =A0 =A0 =A0 =A0link: http://pastebin.mozilla.org/1219625
>
> This changes are tested on OMAP3430 & OMAP3630 SDP with off mode enab=
led in suspend path.
> =A0 =A0 =A0 =A0Tested with suspend/resume script, which will test sys=
tem suspend in a loop.
> =A0 =A0 =A0 =A0Tested for more than 1000 iterations.
> =A0 =A0 =A0 =A0Also tested the reboot with WRM_RST button & reboot co=
mmand.

I've tested this series on Overo and it seems to have no effect.

After 'echo mem > /sys/power/state' my system draws 53mA both with and
without the above patch set.

Has anyone else confirmed these changes on a platform other than the SD=
P?

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
