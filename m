From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: On the APIs for Enabling and Disabling Wakeup capability.
Date: Thu, 17 Jun 2010 09:12:00 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026FFCAA53@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com>
 <87vd9isdxb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36584 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756910Ab0FQDmL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 23:42:11 -0400
In-Reply-To: <87vd9isdxb.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Basak, Partha" <p-basak2@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,
Kevin,

There is no errata in the USB which needs the Enable/Disable wakeup to be done 
Seperately. If it can be handled with omap_devie_enable/idle Apis it is sufficient.

But there is a need of setting the Auto idle bit seperately as for the USBOTG there is a need to set the Autoidle only after configuring the smart idle. It is recommended in the TRM not set the auto idle and smart idle together.
This I discussed with Partha he sent a mail to you.

For setting autoidle there is an api at hwmod layer but not yet omap device layer.
Is there a plan to add API at omap device layer for enabling/disabling the autoidle?

Regards,
Hema
 

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: Thursday, June 17, 2010 5:56 AM
>To: Basak, Partha
>Cc: paul@pwsan.com; Kalliguddi, Hema; Nayak, Rajendra; 
>linux-omap@vger.kernel.org
>Subject: Re: On the APIs for Enabling and Disabling Wakeup capability.
>
>"Basak, Partha" <p-basak2@ti.com> writes:
>
>> I wanted to close on the introduction of two new OMAP device APIs
>> omap_device_enable_wakeup () & omap_device_disable_wakeup() in
>> omap_device layer.
>>
>> These APIs are potentially needed by the USB driver (via function
>> pointers) to work around some USB erratum.
>>
>> Alternatively, can we call omap_hwmod_enable_wakeup() via function
>> pointer?  Is it agreeable to call these from driver code (via
>> function pointers)in some special cases such as to handle some
>> errata?
>
>Hi Partha,
>
>First, we need to dig up the Errata details for that USB problem to
>better understand the USB-specific issue.
>
>In addition, Paul and I discussed the option of automatically managing
>the wakeup during the hwmod enable/idle, since there isn't really a
>need to have the wakeup enabled when the hwmod is active.
>
>Do you see any disadvantages to that?  That would be much cleaner than
>manually managing the wakeup feature per-driver.
>
>Kevin
>