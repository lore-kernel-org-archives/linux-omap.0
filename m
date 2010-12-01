From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 6/7] [RFC] OMAP: hwmod: SYSCONFIG register modification
 for MCBSP
Date: Wed, 1 Dec 2010 17:35:00 +0530
Message-ID: <AANLkTikANE+afG3OWoes=1-BTuDk=Njdr0o8Ro1jpjCK@mail.gmail.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
 <1286296662-7639-6-git-send-email-kishon@ti.com> <4CAECB70.4030705@ti.com>
 <4CB2AC44.6000804@ti.com> <AANLkTi=a80MLvj5YuC==evfGqY6xUToHcBU3TyWEBHAo@mail.gmail.com>
 <AANLkTimExJBgLTfO2Q7zgohHquShvm9kP64=DLjQv21u@mail.gmail.com>
 <4CF52044.6040904@ti.com> <B85A65D85D7EB246BE421B3FB0FBB5930247AFD66A@dbde02.ent.ti.com>
 <4CF62E5A.2080004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43283 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab0LAMFW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 07:05:22 -0500
Received: by wyb28 with SMTP id 28so6865432wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 04:05:20 -0800 (PST)
In-Reply-To: <4CF62E5A.2080004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Basak, Partha" <p-basak2@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, "Govindraj.R" <govindraj.raja@ti.com>

On Wed, Dec 1, 2010 at 4:45 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> + Govindraj
>
> Hi Partha,
>
> On 12/1/2010 8:14 AM, Basak, Partha wrote:
>>
>>> From: Cousson, Benoit
>>> Sent: Tuesday, November 30, 2010 9:33 PM
>>>
>>> Hi Kishon,
>>>
>>> Sorry, for the delay.
>>>
>>> On 11/22/2010 4:59 PM, ABRAHAM, KISHON VIJAY wrote:
>>>>
>>>> Resending the mail in plain text format..
>>>>
>>>> On Mon, Nov 22, 2010 at 9:20 PM, ABRAHAM, KISHON VIJAY<kishon@ti.c=
om>
>>>
>>> wrote:
>>>>>
>>>>> On Mon, Oct 11, 2010 at 11:48 AM, ABRAHAM, KISHON
>>>
>>> VIJAY<kishon@ti.com> =A0 wrote:
>>>>>>
>>>>>> On Friday 08 October 2010 01:12 PM, Cousson, Benoit wrote:
>>>>>>>
>>>>>>> Hi Kishon,
>>>>>>>
>>>>>>> On 10/5/2010 6:37 PM, ABRAHAM, KISHON VIJAY wrote:
>>>>>>>>
>>>>>>>> MCBSP 2 and 3 in OMAP3 has sidetone feature which requires
>>>>>>>> autoidle to be disabled before starting the sidetone. Also
>>>
>>> SYSCONFIG
>>>>>>>>
>>>>>>>> register has to be set with smart idle or no idle depending on
>>>
>>> the
>>>>>>>>
>>>>>>>> dma op mode (threshold or element sync). For doing these
>>>
>>> operations
>>>>>>>>
>>>>>>>> dynamically at runtime, hwmod API'S are used to modify SYSCONF=
IG
>>>>>>
>>>>>> register
>>>>>>>>
>>>>>>>> directly.
>>>>>>>
>>>>>>> OK, it looks like we don't have the choice... But for the
>>>>>>> implementation, please discussed with Manju on that, He is doin=
g
>>>
>>> the
>>>>>>>
>>>>>>> similar thing for the smartstandby issue on SDMA.
>>>>>>
>>>>>> =A0 =A0OK.
>>>>>
>>>>>
>>>>> =A0 =A0 =A0 =A0Looks like we have a problem when we write an API =
similar to
>>>
>>> the one written
>>>>>
>>>>> =A0 =A0 =A0 =A0by Manju (omap_hwmod_set_master_standbymode()) [1]=
=2E In the
>>>
>>> case of McBSP,
>>>>>
>>>>> =A0 =A0 =A0 =A0I have to modify omap_hwmod_set_slave_idlemode() (=
which is
>>>
>>> already existing),
>>>>>
>>>>> =A0 =A0 =A0 =A0to include something like
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ =A0 =A0if (s=
f& =A0 SYSC_HAS_SIDLEMODE) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ =A0 =A0 =A0 =
=A0if (idlemode)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ =A0 =A0 =A0 =
=A0 =A0 =A0idlemode =3D HWMOD_IDLEMODE_NO;
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ =A0 =A0 =A0 =
=A0else
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ =A0 =A0 =A0 =
=A0 =A0 =A0idlemode =3D (oh->flags&
>>>
>>> HWMOD_SWSUP_SIDLE) ?
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0HWMOD_IDLEMODE_NO :
>>>
>>> HWMOD_IDLEMODE_SMART;
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ =A0 =A0}
>>>
>>> How to you enable HWMOD_IDLEMODE_FORCE mode in that case?
>>>
>>>>> =A0 =A0 =A0 =A0Then an API like omap_device_require_no_idle() and
>>>
>>> omap_device_release_no_idle()
>>>>>
>>>>> =A0 =A0 =A0 =A0would be written similar to omap_device_require_no=
_mstandby
>>>
>>> and
>>>>>
>>>>> =A0 =A0 =A0 =A0omap_device_release_no_mstandby() (see [1]) that c=
alls
>>>>> =A0 =A0 =A0 =A0omap_hwmod_set_slave_idlemode() with true/false. P=
assing true
>>>
>>> to
>>>>>
>>>>> =A0 =A0 =A0 =A0omap_hwmod_set_slave_idlemode() will write SIDLE b=
its with
>>>>> =A0 =A0 =A0 =A0HWMOD_IDLEMODE_NO and false to it will write
>>>>> =A0 =A0 =A0 =A0HWMOD_IDLEMODE_NO/HWMOD_IDLEMODE_SMART depending o=
n
>>>>> =A0 =A0 =A0 =A0HWMOD_SWSUP_SIDLE to SIDLE bits.
>>>>>
>>>>> =A0 =A0 =A0 =A0This works fine for McBSP since only two modes com=
e to play
>>>
>>> here
>>>>>
>>>>> =A0 =A0 =A0 =A0(HWMOD_IDLEMODE_NO/HWMOD_IDLEMODE_SMART).
>>>>>
>>>>> =A0 =A0 =A0 =A0But omap_hwmod_set_slave_idlemode() API is used by=
 UART
>>>>> =A0 =A0 =A0 =A0(serial.c Please refer [2]) which writes SIDLE bit=
s to
>>>>> =A0 =A0 =A0 =A0HWMOD_IDLEMODE_NO/HWMOD_IDLEMODE_SMART/ and
>>>>> =A0 =A0 =A0 =A0HWMOD_IDLEMODE_FORCE.
>>>
>>> That code should not be there. It was a temporary hacks that should=
 be
>>> replaced eventually with a clean omap_device API like the one you a=
re
>>> currently implementing.
>>> There are a bunch of direct access to omap_hwmod struct that need t=
o be
>>> removed as well.
>>>
>>>>> =A0 =A0 =A0 =A0Modifying omap_hwmod_set_slave_idlemode() will req=
uire
>>>>> =A0 =A0 =A0 =A0 =A0 =A01) serial.c to be modified to call functio=
ns like
>>>
>>> 'omap_device_require_no_idle(),
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_device_release_no_idle()' and
>>>
>>> 'omap_device_require_force_idle() and
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_device_release_force_idle()' =
instead of
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hwmod_set_slave_idlemode() wh=
ich is currently
>>>
>>> present.
>>>
>>> Yep, you're right.
>>>
>>>>>
>>>>> =A0 =A0 =A0 =A0There are 2 problems associated with it
>>>>> =A0 =A0 =A0 =A01) The first problem is having a single API like
>>>
>>> omap_hwmod_set_slave_idlemode() to
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0set two different values like HWMOD_IDLEMO=
DE_NO or
>>>>> =A0 =A0 =A0 =A0 =A0 =A0HWMOD_IDLEMODE_FORCE (intended to be calle=
d by
>>>
>>> omap_device_require_no_idle()
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0and omap_device_require_force_idle() respe=
ctively).
>>>
>>> According to the new design
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0omap_hwmod_set_slave_idlemode() is intende=
d to take only
>>>
>>> true/false as
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0arguments.
>>>>>
>>>>> =A0 =A0 =A0 =A02) The second problem is having the release API's
>>>
>>> (omap_device_release_no_idle() and
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 omap_device_release_force_idle()) to rest=
ore the
>>>
>>> SYSCONFIG to the previous state.
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 Remember, this was not problem for McBSP =
since only two
>>>
>>> modes were needed.
>>>
>>> And what about 3 APIs?
>>>
>>> omap_device_force_idle
>>> omap_device_no_idle
>>> omap_device_smart_idle
>>
>> Want to reiterate Paul Walmsley's comments on Manju's DMA email date=
d
>> 11/11/2010
>> <snip>
>> 2. =A0Rather than just using a single omap_device_mstandby() functio=
n call,
>> I'd rather see something like omap_device_require_no_standby() and
>> omap_device_release_no_standby(). =A0omap_device_require_no_standby(=
) would
>> force the initiator port into no-standby.
>> omap_device_release_no_standby() would return the initiator port
>> MSTANDBYMODE to whatever the state should be (this depends on whethe=
r
>> HWMOD_SWSUP_MSTDBY is set). =A0I'd rather not have the drivers manag=
e the
>> contents of the MSTANDBYMODE bits directly. =A0Then you should be ab=
le to
>> drop _get_master_standbymode() and omap_hwmod_get_master_idlemode() =
also.
>> Can you please make these changes?
>> <snip>
>>
>> The key point is, in the absence of any special situation like errat=
a etc,
>> the IdleMode settings should
>> be dicated solely by the hwmod flags. We should have a mechanism tho=
ugh to
>> supersede this setting& =A0request
>> /release customized settings to handle errata etc.
>>
>> So, it makes sense to have request/release API pairs. In this case,
>> omap_device_request_no_idle()& =A0omap_device_release_no_idle().
>>
>> omap_hwmod_set_slave_idlemode should continue to take absolute value=
s
>> instead of true/false to support
>> all possible settings of IdleMode.
>
> Mmm, and how that email is helping to progress in the discussion?
>
> The issue is not really for the mcbsp but for the serial that need to=
 handle
> the 3 different states.
>
> =A0 =A0 =A0 =A0if (enable) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/**
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Errata 2.15: [UART]:Cannot Acknowle=
dge Idle Requests
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * in Smartidle Mode When Configured f=
or DMA Operations.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (uart->dma_enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0idlemode =3D HWMOD_IDL=
EMODE_FORCE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0idlemode =3D HWMOD_IDL=
EMODE_SMART;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0idlemode =3D HWMOD_IDLEMODE_NO;
> =A0 =A0 =A0 =A0}
>
> You do need to explicitly set the 3 modes, hence the following 3 APIs=
:
> omap_device_force_idle
> omap_device_no_idle
> omap_device_smart_idle

Agree, if we have to hide "oh" info from driver use only pdev.
we need those 3 exported API's.

>
> You can potentially add another API to restore the default idle mode:
>
> omap_device_default_idle

If default mode is smart idle mode?
we cant enter low power states as we may need to be in force idle mode.

--
Thanks
Govindraj.R

>
> That seems much simpler than 3 pairs of APIs.
>
> Regards,
> Benoit
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
