From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 10/19] ARM: OMAP4: PM: Work-around for ROM code BUG of IVAHD/TESLA
Date: Fri, 18 May 2012 11:25:13 +0530
Message-ID: <CAMQu2gw_N-pFOJBugEGJK2wFgFYjQu_p5tQ6hAh3kp0B965d_A@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-11-git-send-email-t-kristo@ti.com> <87zk976827.fsf@ti.com>
 <CAMQu2gzNTjnYGcXzEOD0NVgbCT-nNwMf5A_LypLZCtXmwcKfwA@mail.gmail.com> <871umi21uc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46130 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755942Ab2ERFze convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 01:55:34 -0400
Received: by qcmv28 with SMTP id v28so1833972qcm.25
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 22:55:33 -0700 (PDT)
In-Reply-To: <871umi21uc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Thu, May 17, 2012 at 10:15 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
>
>> On Thu, May 17, 2012 at 4:35 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> Tero Kristo <t-kristo@ti.com> writes:
>>>
>>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>
>>>> The ROM BUG is when MPU Domain OFF wake up sequence that can compr=
omise
>>>> IVA and Tesla execution.
>>>>
>>>> At wakeup from MPU OFF on HS device only (not GP device), when
>>>> restoring the Secure RAM, the ROM Code reconfigures the clocks the
>>>> same way it is done at Cold Reset.
>>>
>>> Ouch.
>>>
>>>> The IVAHD Clocks and Power Domain settings are:
>>>> =A0 =A0 =A0 IVAHD_CM2 IVAHD_CLKCTRL_MODULE_MODE =3D DISABLE
>>>> =A0 =A0 =A0 IVAHD_CM2 SL2_CLKCTRL_MODULE_MODE =3D DISABLE
>>>> =A0 =A0 =A0 IVAHD_CM2 SL2_CLKSTCTRL_CLKTRCTRL =3D HW_AUTO
>>>> =A0 =A0 =A0 IVAHD_PRM IVAHD_PWRSTCTRL_POWERSTATE =3D OFF
>>>> The TESLA Clocks and Power Domain settings are:
>>>> =A0 =A0 =A0 TESLA_CM1 TESLA_CLKCTRL_MODULE_MODE =3D DISABLE
>>>> =A0 =A0 =A0 TESLA_CM1 TESLA_CLKSTCTRL_CLKTRCTRL =3D HW_AUTO
>>>> =A0 =A0 =A0 TESLA_PRM TESLA_PWRSTCTRL_POWERSTATE =3D OFF
>>>>
>>>> This patch fixes the low power OFF mode code so that the these
>>>> registers are saved and restore across MPU OFF state.
>>>>
>>>> Also because of this limitation, MPU OFF alone is not targeted wit=
hout
>>>> device OFF to avoid IVAHD and TESLA execution impact
>>>
>>> I don't see where this restriction is implemented.
>>>
>> It's handled and the patch is in mainline for some time.
>> We de-scoped MPU OFF from OMAP4430 devices in SW and
>> hardware team de-scoped it in hardware from OMAP4460 onwards.
>> Deepest state on MPUSS cluster is OSWR.
>
> The question was about the changelog.
>
> The changelog makes it sound like the restriction is part of the patc=
h,
> but it is not. =A0Please update the changlog to clarify that, ideally
> adding a reference to the commit you mentioned.
>
Agree.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
