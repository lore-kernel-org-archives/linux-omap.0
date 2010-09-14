From: venki kaps <venkiece2005@gmail.com>
Subject: Re: OMAP3 DSP MMU fault + off mode issue
Date: Tue, 14 Sep 2010 20:54:22 +0530
Message-ID: <AANLkTimd_sRpOYaurOT0iSbfd0pMZvhxgUcaqbQvSobu__21809.728004928$1284477883$gmane$org@mail.gmail.com>
References: <AANLkTikHM+o_FCgnVzGhs8UtQ_geXFzKNQpGSZiEN7sx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36443 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0INPYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 11:24:23 -0400
In-Reply-To: <AANLkTikHM+o_FCgnVzGhs8UtQ_geXFzKNQpGSZiEN7sx@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com, h-kanigeri2@ti.com, ameya.palande@nokia.com, fernando.lugo@ti.com, x0hebbar@ti.com, ernesto@ti.com, felipe.contreras@gmail.com, s-anna@ti.com, grgupta@ti.com, iva

On Tue, Sep 14, 2010 at 1:28 AM, venki kaps <venkiece2005@gmail.com> wr=
ote:
> Dear all,
>
> I have been facing an issue with OMAP3 PM with DSP MMU Fault (Kernel =
2.6.32).
>
> The issue is describing as below mentioned way,
> =A0 =A0 =A0 =A01). The Device is getting DSP MMU Fault when playing M=
P4 video clip.
>
> The system is not hitting off mode in the below scenario,
> =A0 =A0 =A0 =A02). System boot ->play mp4 clip ->DSP MMU Fault -> all=
ow off
> mode -----------> Never hits off mode
>
> But surprisingly the system is hitting off mode in the below scenario=
,
> =A0 =A0 =A0 3). System boot ->allow off mode ->play mp4 clip ->DSP MM=
U
> Fault -> allow off mode -----------> perfectly works
>
>
> =A0- Could you please describe the root cause about the above issues =
1 & 2?
> =A0- How could solve the above issues?

I have found the issue with UART3.
In System configuration register (SYSC),-
             IDLEMODE  - Smart idle -------> working scenario  ------>
system hits off mode.
             IDLEMODE  - No idle -------> Non working scenario
------> system never hits off mode.

Could you please explain why UART3 is not able to hit smart idle after
DSP MMU fault ( System boot ->play mp4 clip ->DSP MMU Fault -> allow
off -----------> Never hits off mode).,

Thanks in advance.

> Best Regards,
> Venkii
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
