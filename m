From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v13] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Tue, 11 Oct 2011 13:29:55 +0530
Message-ID: <CAP05o4K8BBwh5nbQpuc180WD2=ON+wksEz=gku=Y4GDQzx=BdA@mail.gmail.com>
References: <1317901123-2546-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1110101835070.5205@utopia.booyaka.com>
	<CAP05o4+Y3_-mFYdsta4DM7EfkYEq1-6psjvawN5pCWX++8jm8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:43722 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752010Ab1JKH75 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 03:59:57 -0400
In-Reply-To: <CAP05o4+Y3_-mFYdsta4DM7EfkYEq1-6psjvawN5pCWX++8jm8A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com

On Tue, Oct 11, 2011 at 11:18 AM, Munegowda, Keshava
<keshava_mgowda@ti.com> wrote:
> On Tue, Oct 11, 2011 at 6:08 AM, Paul Walmsley <paul@pwsan.com> wrote=
:
>> Hi
>>
>> so I just noticed another problem with these hwmods:
>>
>> On Thu, 6 Oct 2011, Keshava Munegowda wrote:
>>
>>> Following 2 hwmod structures are added
>>> =A0 =A0 1. usb_host_hs
>>> =A0 =A0 =A0 =A0 =A0The hwmod of usbhs with uhh, ehci and ohci base =
addresses
>>> =A0 =A0 =A0 =A0 =A0functional clock and ehci, ohci irqs
>>>
>>> =A0 =A0 2. usb_tll_hs
>>> =A0 =A0 =A0 =A0 =A0 hwmod of usbhs with the TLL base address and ir=
q.
>>>
>>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>>> Reviewed-by: Partha Basak <parthab@india.ti.com>
>>> ---
>>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0227 ++++++++++++=
++++++++++++++++
>>> =A01 files changed, 227 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/=
mach-omap2/omap_hwmod_3xxx_data.c
>>> index 59fdb9f..b8ca690 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>>
>> ...
>>
>>> +static struct omap_hwmod_ocp_if omap34xx_ick_cfg__usb_tll_hs =3D {
>>
>> This interface is missing a .master and .slave. =A0It must have both=
=2E =A0So,
>> dropping this patch until it's fixed.
>>
>> Clearly we also need to modify the hwmod code needs to reject any
>> instances where either .master or .slave is NULL.
>>
>>
>> - Paul
>
> Hi Paul
> =A0 =A0 =A0 =A0 =A0 I will fix it today only and I will send the upda=
ted
> patches in couple of hours.
> please help me to make it in this merge window.
>


Hi Paul
      I have posted v14 of the patches; please do review
if it is OK, please merge to your branch for 3.2 version
please let me know if you have any comments here.

 Thanks and Regards
 keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
