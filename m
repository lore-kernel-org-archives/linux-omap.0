From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: On the APIs for Enabling and Disabling Wakeup capability.
Date: Thu, 24 Jun 2010 20:12:14 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402700F3038@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com>
	<87vd9isdxb.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026FFCAA53@dbde02.ent.ti.com>
	<74583B8642AB8841B30447520659FCA901AA4908FF@dnce01.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E940270056DEE@dbde02.ent.ti.com>
 <87ljacbd5u.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59433 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755464Ab0FXOmH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 10:42:07 -0400
In-Reply-To: <87ljacbd5u.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Kamat, Nishant" <nskamat@ti.com>

Kevin,

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
>Sent: Friday, June 18, 2010 8:29 PM
>To: Kalliguddi, Hema
>Cc: Cousson, Benoit; Basak, Partha; paul@pwsan.com; Nayak,=20
>Rajendra; linux-omap@vger.kernel.org
>Subject: Re: On the APIs for Enabling and Disabling Wakeup capability.
>
>"Kalliguddi, Hema" <hemahk@ti.com> writes:
>
>> Hi Benoit,
>>
>> I have 2 cases in usb for the need of separate API for=20
>setting the auto idle bit.
>>
>> 1. Below the link for omap3430TRM. Please refer 24.1.5.4.2=20
>and 24.1.5.4.3 there is note not to set smart
>> idle and autoidle bit simultaneously. Suggestion is to set=20
>the auto idle 0 before setting smart idle. Then set to 1.
>
>Maybe this sequence should be enforced by the hwmod code itself,
>rather than the knowledge living in the driver.
>
>However, based on the errata below, auto-idle will always be zero so
>the there should be no conflict in setting smart-idle and auto-idle
>simultaneously today.

The errata is applicable to OMAP3430 only.
But this sequence applicable for omap4 as well. So for submitting the c=
hanges we need=20
to have the HWMOD api to be changed to enaforce the Autodile set only a=
fter the smart idle.

>
>> This applicable for omap4 as well.  I don't have the=20
>omap4430 pblic TRM to share.
>> http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf=20
>>
>> 2. There is a Errata in OMAP3 errata #1.59 that If auto idle=20
>is set then the USB can't  wakeup the system by
>> usb external events. The suggested workaround is to disable=20
>the autoIdle for omap3.
>
>This one could be handled at init time in usb-musb.c by setting
>HWMOD_NO_OCP_AUTOIDLE for the hwmod with a comment summarizing this
>errata.
>
>Note also that Errata 1.166 is another one related to MUSB auto-idle
>and we have a workaround in the PM branch to ensure that MUSB
>auto-idle is disabled in the idle path since it may be re-enabled
>after an off-mode transition.
>

I agree that this can be hanled using hw->flags for omap3.=20
Can you please point me the commit for the above errata fix? I am succe=
ssful in getting the exact commit.

There are few observation in the USBOTG with respect to offmode and sys=
config settings.
Still the investigations are in progress. Current mainline code for 363=
0 have a patch for the offmode as below.

Enable the force ilde and force standby before going to offmode.
Reset the sysconfig with smart standby and smartidle in restore path.
With the current API support I will not be in a position to implement t=
he this workaround.

I think there are some more errata which needs the dynamic configuratio=
n of the sysconfig register like
Set the force idle when data transfer is complete and set back to smart=
 idle/smart standby during data transfer.
I see the errata already in UART #2.15.

Can you please let me know how do we meet such requirement using the ex=
isting APIs?

~Hema
>Kevin
>

>>
>>>-----Original Message-----
>>>From: Cousson, Benoit=20
>>>Sent: Thursday, June 17, 2010 3:04 PM
>>>To: Kalliguddi, Hema; Kevin Hilman; Basak, Partha
>>>Cc: paul@pwsan.com; Nayak, Rajendra; linux-omap@vger.kernel.org
>>>Subject: RE: On the APIs for Enabling and Disabling Wakeup=20
>capability.
>>>
>>>Hi Hema,
>>>
>>>>From: linux-omap-owner@vger.kernel.org=20
>>>>
>>>>Kevin,
>>>>
>>>>There is no errata in the USB which needs the Enable/Disable=20
>>>>wakeup to be done=20
>>>>Seperately. If it can be handled with omap_devie_enable/idle=20
>>>>Apis it is sufficient.
>>>>
>>>>But there is a need of setting the Auto idle bit seperately as=20
>>>>for the USBOTG there is a need to set the Autoidle only after=20
>>>>configuring the smart idle. It is recommended in the TRM not=20
>>>>set the auto idle and smart idle together.
>>>>This I discussed with Partha he sent a mail to you.
>>>>
>>>>For setting autoidle there is an api at hwmod layer but not=20
>>>>yet omap device layer.
>>>>Is there a plan to add API at omap device layer for=20
>>>>enabling/disabling the autoidle?
>>>
>>>The whole issue with exposing all the low level stuff at driver leve=
l
>>>is that the hwmod abstraction become less and less useful.
>>>Drivers will start hacking with that for no good reason. And=20
>>>then we will start adding again some omap version specific=20
>>>hacks in the driver.
>>>
>>>Could you provide the full errata description of that USB_OTG=20
>>>issue? Or at least that TRM part you are talking about.
>>>
>>>Thanks,
>>>Benoit
>>>
>>>>Regards,
>>>>Hema
>>>>=20
>>>>
>>>>>
>>>Texas Instruments France SA, 821 Avenue Jack Kilby, 06270=20
>>>Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920
>>>=A0
>>>-----Original Message-----
>>>
>>>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
>>>>>Sent: Thursday, June 17, 2010 5:56 AM
>>>>>To: Basak, Partha
>>>>>Cc: paul@pwsan.com; Kalliguddi, Hema; Nayak, Rajendra;=20
>>>>>linux-omap@vger.kernel.org
>>>>>Subject: Re: On the APIs for Enabling and Disabling Wakeup=20
>>>capability.
>>>>>
>>>>>"Basak, Partha" <p-basak2@ti.com> writes:
>>>>>
>>>>>> I wanted to close on the introduction of two new OMAP device API=
s
>>>>>> omap_device_enable_wakeup () & omap_device_disable_wakeup() in
>>>>>> omap_device layer.
>>>>>>
>>>>>> These APIs are potentially needed by the USB driver (via functio=
n
>>>>>> pointers) to work around some USB erratum.
>>>>>>
>>>>>> Alternatively, can we call omap_hwmod_enable_wakeup()=20
>via function
>>>>>> pointer?  Is it agreeable to call these from driver code (via
>>>>>> function pointers)in some special cases such as to handle some
>>>>>> errata?
>>>>>
>>>>>Hi Partha,
>>>>>
>>>>>First, we need to dig up the Errata details for that USB problem t=
o
>>>>>better understand the USB-specific issue.
>>>>>
>>>>>In addition, Paul and I discussed the option of=20
>>>automatically managing
>>>>>the wakeup during the hwmod enable/idle, since there isn't really =
a
>>>>>need to have the wakeup enabled when the hwmod is active.
>>>>>
>>>>>Do you see any disadvantages to that?  That would be much=20
>>>cleaner than
>>>>>manually managing the wakeup feature per-driver.
>>>>>
>>>>>Kevin
>>>>>--
>>>>To unsubscribe from this list: send the line "unsubscribe=20
>>>>linux-omap" in
>>>>the body of a message to majordomo@vger.kernel.org
>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
