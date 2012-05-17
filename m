From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 10/19] ARM: OMAP4: PM: Work-around for ROM code BUG of IVAHD/TESLA
Date: Thu, 17 May 2012 12:22:19 +0530
Message-ID: <CAMQu2gzNTjnYGcXzEOD0NVgbCT-nNwMf5A_LypLZCtXmwcKfwA@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-11-git-send-email-t-kristo@ti.com> <87zk976827.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60435 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759674Ab2EQGwl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 02:52:41 -0400
Received: by qcsg15 with SMTP id g15so1306725qcs.13
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 23:52:40 -0700 (PDT)
In-Reply-To: <87zk976827.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Thu, May 17, 2012 at 4:35 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> The ROM BUG is when MPU Domain OFF wake up sequence that can comprom=
ise
>> IVA and Tesla execution.
>>
>> At wakeup from MPU OFF on HS device only (not GP device), when
>> restoring the Secure RAM, the ROM Code reconfigures the clocks the
>> same way it is done at Cold Reset.
>
> Ouch.
>
>> The IVAHD Clocks and Power Domain settings are:
>> =A0 =A0 =A0 IVAHD_CM2 IVAHD_CLKCTRL_MODULE_MODE =3D DISABLE
>> =A0 =A0 =A0 IVAHD_CM2 SL2_CLKCTRL_MODULE_MODE =3D DISABLE
>> =A0 =A0 =A0 IVAHD_CM2 SL2_CLKSTCTRL_CLKTRCTRL =3D HW_AUTO
>> =A0 =A0 =A0 IVAHD_PRM IVAHD_PWRSTCTRL_POWERSTATE =3D OFF
>> The TESLA Clocks and Power Domain settings are:
>> =A0 =A0 =A0 TESLA_CM1 TESLA_CLKCTRL_MODULE_MODE =3D DISABLE
>> =A0 =A0 =A0 TESLA_CM1 TESLA_CLKSTCTRL_CLKTRCTRL =3D HW_AUTO
>> =A0 =A0 =A0 TESLA_PRM TESLA_PWRSTCTRL_POWERSTATE =3D OFF
>>
>> This patch fixes the low power OFF mode code so that the these
>> registers are saved and restore across MPU OFF state.
>>
>> Also because of this limitation, MPU OFF alone is not targeted witho=
ut
>> device OFF to avoid IVAHD and TESLA execution impact
>
> I don't see where this restriction is implemented.
>
It's handled and the patch is in mainline for some time.
We de-scoped MPU OFF from OMAP4430 devices in SW and
hardware team de-scoped it in hardware from OMAP4460 onwards.
Deepest state on MPUSS cluster is OSWR.

------------
commit a57341f780660800e1463eaedb80ed152ad6b5de
Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date:   Sat Jul 9 20:42:59 2011 -0600

    OMAP4: powerdomain data: Remove unsupported MPU powerdomain state

    On OMAP4430 devices, because of boot ROM code bug, MPU OFF state ca=
n't
    be attempted independently. When coming out of MPU OFF state, ROM c=
ode
    disables the clocks of IVAHD, TESLA which is not desirable. Hence t=
he
    MPU OFF state is not usable on OMAP4430 devices.

    OMAP4460 onwards, MPU OFF state will be descoped completely because
    the DDR firewall falls in MPU power domain. When the MPU hit OFF st=
ate,
    DDR won't be accessible for other initiators. The deepest state sup=
ported
    is open switch retention (OSWR) just like CORE and PER PD on OMAP44=
30.

    So in summary MPU power domain OFF state is not supported on OMAP4
    and onwards designs. Thanks to new PRCM design, device off mode can
    still be achieved with power domains hitting OSWR state.

    Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Signed-off-by: Rajendra Nayak <rnayak@ti.com>
    [b-cousson@ti.com: Fix changelog typos]
    Signed-off-by: Benoit Cousson <b-cousson@ti.com>
    Signed-off-by: Paul Walmsley <paul@pwsan.com>

---------------------------------------------

> And, can this be hooked into cluster PM notifiers.
>
Not needed.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
