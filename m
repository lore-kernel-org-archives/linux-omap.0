From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP4: Intialize IVA Device in addition to DSP device.
Date: Fri, 11 Mar 2011 11:09:02 +0530
Message-ID: <AANLkTiku50dsYOM0d7kYqL+AngvAhxh8_YOyfuYB65xp@mail.gmail.com>
References: <1299738148-28557-1-git-send-email-shweta.gulati@ti.com>
	<fc1162b5d4e1a7deb77aa800a3e8fdb3@mail.gmail.com>
	<4D78D860.2050609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53498 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751194Ab1CKFjF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 00:39:05 -0500
Received: by bwz14 with SMTP id 14so2633390bwz.30
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 21:39:02 -0800 (PST)
In-Reply-To: <4D78D860.2050609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, Mar 10, 2011 at 7:25 PM, Nishanth Menon <nm@ti.com> wrote:
> Few cosmetic comments follow:
> Vishwanath Sripathy wrote, on 03/10/2011 02:36 PM:
>>>
>>> -----Original Message-----
>>> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-ar=
m-
>>> kernel-bounces@lists.infradead.org] On Behalf Of Shweta Gulati
>>> Sent: Thursday, March 10, 2011 11:52 AM
>>> To: linux-omap@vger.kernel.org
>>> Cc: Shweta Gulati; linux-arm-kernel@lists.infradead.org
>>> Subject: [PATCH] OMAP4: Intialize IVA Device in addition to DSP dev=
ice.
>>>
>>> OMAP4 has two different Devices IVA and DSP. DSP is bound
>>> with MPU for DVFS and IVA has its own well defined OPPs.
>>
>> DSP is not in MPU voltage domain. DSP(Tesla) and IVAHD are in the sa=
me
>> voltage domain. Pls correct this in the commit log.
>
> True for OMAP4 - DSP and MPU DVFS are independent, in OMAP3, they wer=
e
> scaled together ;)
Will correct the Commit log.
> [...]
>>>
>>> This Patch adds IVA init to 'omap2_init_processor_devices'
>>> and make sure that API 'omap2_set_init_voltage' is called
>>> for apt dev pointer.
>
> set_init_voltage error is just one symptom of the problem. infact, if=
 we
> wanted to do anything with iva - e.g. dvfs, we would'nt have been abl=
e to
> without the device being registered.
Yes, Fair enough need to rephrase whole Log.
>>
>>> It fixes Error logs:
>
> "This also fixes the following error seen during boot as
> omap2_set_init_voltage can now find the iva device" is better than th=
e "This
> patch...."?
Will do.
>>>
>>> =A0 =A0 =A0 =A0omap2_set_init_voltage: Invalid parameters!
>>> =A0 =A0 =A0 =A0omap2_set_init_voltage: Unable to put vdd_iva to its=
 init voltage
>
> Thanks for catching and fixing this - I had noticed this in my SR 1.5
> testing(should have posted as well), but had'nt tried to dig further.
>
>>>
>>> Tested on OMAP4430 SDP Board.
>>> Baseline:
>>> http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-
>>> pm.git
>>> Branch :pm-core
>
> Do you really want this information in commit log? I suggest you move=
 this
> to the diffstat section.
Will do.
>>>
>>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>>> ---
>>> =A0arch/arm/mach-omap2/pm.c | =A0 =A01 +
>>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>>> index 30af335..49486f5 100644
>>> --- a/arch/arm/mach-omap2/pm.c
>>> +++ b/arch/arm/mach-omap2/pm.c
>>> @@ -89,6 +89,7 @@ static void omap2_init_processor_devices(void)
>>> =A0 =A0 =A0 =A0if (cpu_is_omap44xx()) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_init_omap_device("l3_main_1",&l3_de=
v);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_init_omap_device("dsp",&dsp_dev);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _init_omap_device("iva",&iva_dev);
>>> =A0 =A0 =A0 =A0} else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_init_omap_device("l3_main",&l3_dev)=
;
>>> =A0 =A0 =A0 =A0}
>
>
>
> --
> Regards,
> Nishanth Menon
>

--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
