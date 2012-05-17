From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 10/19] ARM: OMAP4: PM: Work-around for ROM code BUG of IVAHD/TESLA
Date: Thu, 17 May 2012 09:45:31 -0700
Message-ID: <871umi21uc.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-11-git-send-email-t-kristo@ti.com>
	<87zk976827.fsf@ti.com>
	<CAMQu2gzNTjnYGcXzEOD0NVgbCT-nNwMf5A_LypLZCtXmwcKfwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36379 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755099Ab2EQQpc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 12:45:32 -0400
Received: by dadz8 with SMTP id z8so3193993dad.7
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 09:45:31 -0700 (PDT)
In-Reply-To: <CAMQu2gzNTjnYGcXzEOD0NVgbCT-nNwMf5A_LypLZCtXmwcKfwA@mail.gmail.com>
	(Santosh Shilimkar's message of "Thu, 17 May 2012 12:22:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> On Thu, May 17, 2012 at 4:35 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> The ROM BUG is when MPU Domain OFF wake up sequence that can compro=
mise
>>> IVA and Tesla execution.
>>>
>>> At wakeup from MPU OFF on HS device only (not GP device), when
>>> restoring the Secure RAM, the ROM Code reconfigures the clocks the
>>> same way it is done at Cold Reset.
>>
>> Ouch.
>>
>>> The IVAHD Clocks and Power Domain settings are:
>>> =C2=A0 =C2=A0 =C2=A0 IVAHD_CM2 IVAHD_CLKCTRL_MODULE_MODE =3D DISABL=
E
>>> =C2=A0 =C2=A0 =C2=A0 IVAHD_CM2 SL2_CLKCTRL_MODULE_MODE =3D DISABLE
>>> =C2=A0 =C2=A0 =C2=A0 IVAHD_CM2 SL2_CLKSTCTRL_CLKTRCTRL =3D HW_AUTO
>>> =C2=A0 =C2=A0 =C2=A0 IVAHD_PRM IVAHD_PWRSTCTRL_POWERSTATE =3D OFF
>>> The TESLA Clocks and Power Domain settings are:
>>> =C2=A0 =C2=A0 =C2=A0 TESLA_CM1 TESLA_CLKCTRL_MODULE_MODE =3D DISABL=
E
>>> =C2=A0 =C2=A0 =C2=A0 TESLA_CM1 TESLA_CLKSTCTRL_CLKTRCTRL =3D HW_AUT=
O
>>> =C2=A0 =C2=A0 =C2=A0 TESLA_PRM TESLA_PWRSTCTRL_POWERSTATE =3D OFF
>>>
>>> This patch fixes the low power OFF mode code so that the these
>>> registers are saved and restore across MPU OFF state.
>>>
>>> Also because of this limitation, MPU OFF alone is not targeted with=
out
>>> device OFF to avoid IVAHD and TESLA execution impact
>>
>> I don't see where this restriction is implemented.
>>
> It's handled and the patch is in mainline for some time.
> We de-scoped MPU OFF from OMAP4430 devices in SW and
> hardware team de-scoped it in hardware from OMAP4460 onwards.
> Deepest state on MPUSS cluster is OSWR.

The question was about the changelog.

The changelog makes it sound like the restriction is part of the patch,
but it is not.  Please update the changlog to clarify that, ideally
adding a reference to the commit you mentioned.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
