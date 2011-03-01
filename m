From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 0/3]: Update OPP Table and Voltage Rail Values
Date: Tue, 1 Mar 2011 11:02:30 +0530
Message-ID: <AANLkTin1kzuwZtDhkhhYr3Xjr7SBViEtzDAL-8w8V+2o@mail.gmail.com>
References: <1297836995-8747-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50159 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938Ab1CAFcc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 00:32:32 -0500
Received: by mail-bw0-f44.google.com with SMTP id 13so4986942bwz.31
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 21:32:30 -0800 (PST)
In-Reply-To: <1297836995-8747-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>

Hi,

On Wed, Feb 16, 2011 at 11:46 AM, Shweta Gulati <shweta.gulati@ti.com> =
wrote:
> The series mainly does below:
>
> OMAP4 only
> =A0 =A0 =A0 - Update MPU VOltage rail values for all OPPs
> =A0 =A0 =A0 - Enable OPP-Nitro and OPP-Turbo for all boards
> OMAP2PLUS
> =A0 =A0 =A0 -Replace hardcoded Voltage values in OPP Table
> =A0 =A0 =A0 =A0with Voltage Macros.
>
> Baseline:
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.g=
it
> Branch: pm
>
> Tested on OMAP4430 SDP, OMAP3630 SDP and OMAP3430 SDP.
>
> Shweta Gulati (2):
> =A0OMAP4: Revise MPU Voltage rail values.
> =A0OMAP4: Enable Turbo and Nitro OPP for OMAP4
>
> Vishwanath BS (1):
> =A0OMAP2+: Replace Voltage values with Macros.
>
> =A0arch/arm/mach-omap2/opp3xxx_data.c =A0 =A0 =A0 =A0| =A0 47 +++++++=
++++++++--------------
> =A0arch/arm/mach-omap2/opp4xxx_data.c =A0 =A0 =A0 =A0| =A0 13 ++++---=
-
> =A0arch/arm/plat-omap/include/plat/voltage.h | =A0 =A08 ++--
> =A03 files changed, 35 insertions(+), 33 deletions(-)
>
>
Any Comments on this Patch Series.


--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
