From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: On the APIs for Enabling and Disabling Wakeup capability.
Date: Fri, 18 Jun 2010 14:29:12 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270056DEE@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com>
 <87vd9isdxb.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026FFCAA53@dbde02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA901AA4908FF@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49584 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756281Ab0FRI7W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 04:59:22 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA901AA4908FF@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Basak, Partha" <p-basak2@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Benoit,

I have 2 cases in usb for the need of separate API for setting the auto=
 idle bit.

1. Below the link for omap3430TRM. Please refer 24.1.5.4.2 and 24.1.5.4=
=2E3 there is note not to set smart
idle and autoidle bit simultaneously. Suggestion is to set the auto idl=
e 0 before setting smart idle. Then set to 1.
This applicable for omap4 as well.  I don't have the omap4430 pblic TRM=
 to share.
http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf=20

2. There is a Errata in OMAP3 errata #1.59 that If auto idle is set the=
n the USB can't  wakeup the system by
usb external events. The suggested workaround is to disable the autoIdl=
e for omap3.

Regards,
Hema

>-----Original Message-----
>From: Cousson, Benoit=20
>Sent: Thursday, June 17, 2010 3:04 PM
>To: Kalliguddi, Hema; Kevin Hilman; Basak, Partha
>Cc: paul@pwsan.com; Nayak, Rajendra; linux-omap@vger.kernel.org
>Subject: RE: On the APIs for Enabling and Disabling Wakeup capability.
>
>Hi Hema,
>
>>From: linux-omap-owner@vger.kernel.org=20
>>
>>Kevin,
>>
>>There is no errata in the USB which needs the Enable/Disable=20
>>wakeup to be done=20
>>Seperately. If it can be handled with omap_devie_enable/idle=20
>>Apis it is sufficient.
>>
>>But there is a need of setting the Auto idle bit seperately as=20
>>for the USBOTG there is a need to set the Autoidle only after=20
>>configuring the smart idle. It is recommended in the TRM not=20
>>set the auto idle and smart idle together.
>>This I discussed with Partha he sent a mail to you.
>>
>>For setting autoidle there is an api at hwmod layer but not=20
>>yet omap device layer.
>>Is there a plan to add API at omap device layer for=20
>>enabling/disabling the autoidle?
>
>The whole issue with exposing all the low level stuff at driver level
>is that the hwmod abstraction become less and less useful.
>Drivers will start hacking with that for no good reason. And=20
>then we will start adding again some omap version specific=20
>hacks in the driver.
>
>Could you provide the full errata description of that USB_OTG=20
>issue? Or at least that TRM part you are talking about.
>
>Thanks,
>Benoit
>
>>Regards,
>>Hema
>>=20
>>
>>>
>Texas Instruments France SA, 821 Avenue Jack Kilby, 06270=20
>Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920
>=A0
>-----Original Message-----
>
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
>>>Sent: Thursday, June 17, 2010 5:56 AM
>>>To: Basak, Partha
>>>Cc: paul@pwsan.com; Kalliguddi, Hema; Nayak, Rajendra;=20
>>>linux-omap@vger.kernel.org
>>>Subject: Re: On the APIs for Enabling and Disabling Wakeup=20
>capability.
>>>
>>>"Basak, Partha" <p-basak2@ti.com> writes:
>>>
>>>> I wanted to close on the introduction of two new OMAP device APIs
>>>> omap_device_enable_wakeup () & omap_device_disable_wakeup() in
>>>> omap_device layer.
>>>>
>>>> These APIs are potentially needed by the USB driver (via function
>>>> pointers) to work around some USB erratum.
>>>>
>>>> Alternatively, can we call omap_hwmod_enable_wakeup() via function
>>>> pointer?  Is it agreeable to call these from driver code (via
>>>> function pointers)in some special cases such as to handle some
>>>> errata?
>>>
>>>Hi Partha,
>>>
>>>First, we need to dig up the Errata details for that USB problem to
>>>better understand the USB-specific issue.
>>>
>>>In addition, Paul and I discussed the option of=20
>automatically managing
>>>the wakeup during the hwmod enable/idle, since there isn't really a
>>>need to have the wakeup enabled when the hwmod is active.
>>>
>>>Do you see any disadvantages to that?  That would be much=20
>cleaner than
>>>manually managing the wakeup feature per-driver.
>>>
>>>Kevin
>>>--
>>To unsubscribe from this list: send the line "unsubscribe=20
>>linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
