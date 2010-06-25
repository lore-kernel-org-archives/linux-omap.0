From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [RFC] omap: hwspinlock: Added hwspinlock driver
Date: Fri, 25 Jun 2010 23:02:52 +0200
Message-ID: <74583B8642AB8841B30447520659FCA901AA60B735@dnce01.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
 <4C2464B1.6030008@ti.com>
 <F39349C6FA641B4A831B7BF4EBF4D4E14728E3B0@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51242 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0FYVC4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 17:02:56 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E14728E3B0@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

>From: Que, Simon
>Sent: Friday, June 25, 2010 8:14 PM
>
>Benoit,
>
>Thanks for the comments.  My responses are below.
>
>> Why using a Kconfig option in that case? You can reserve the locks at
>> run time based on other driver request. The goal of the
>hwspinlock is to
>> protect data shared between various processors inside OMAP4 like ipu,
>> iva, dsp and mpu. So in anycase the syslink driver can request the
>> needed locks at init time on behalf of the dsp or the ipu.
>>
>> Since you don't even know the number of locks because it is
>determined
>> at init time, you cannot know at build time that information.
>>
>> You should add an API to reserve some locks at run time
>instead of doing
>> that.
>
>The reserved locks are not meant for syslink use only.  It
>will also be used by i2c, which does not go through syslink.
>If we were to follow your suggestion, who should call the
>function to establish number of reserved locks?  We can
>instead think of the config option as requesting a particular
>number of reserved locks for system use, independent of how
>many locks actually exist in the system.  How many reserved
>locks there are, and which driver is using which reserved
>locks -- that is a system integration issue that should be
>sorted out at a higher level.

Syslink was just an example, any driver including i2c can reserve any number of locks.
The MPU is always the master, so no other processor will start if the MPU didn't
enable them previously. You can always reserve lock at runtime, during board init.
BTW, the spinlock is not a system wide resources but more a Soc resource.

>> It is a details, but why are you renaming the registers with the HW
>> prefix? The module name is spinlock not hwspinlock.
>>
>> The names should be that:
>> #define SPINLOCK_REVISION                    0x0000
>> #define SPINLOCK_SYSCONFIG                   0x0010
>> #define SPINLOCK_SYSSTATUS                   0x0014
>> #define SPINLOCK_LOCK_BASE                   0x0800
>>
>> or even that since you are not sharing these defines:
>> #define REVISION                    0x0000
>> #define SYSCONFIG                   0x0010
>> #define SYSSTATUS                   0x0014
>> #define LOCK_BASE                   0x0800
>>
>> Every IPs are by definition an HW module, so that
>information is useless.
>
>You have a good point, I will make this change.
>
>>
>> Since it is a new driver for a new IP, why don't you use directly the
>> omap_device / omap_hwmod abstraction?
>
>hwmod for spinlock is not currently ready.  We want to
>integrate with the platform/driver/device system for now, as a
>first step.  hwmod can be implemented later.

Not ready??? The data was in my git tree for months and is available in Kevin's tree for a while. http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod_44xx_data.c;h=20f5f8c2a67e6e82854f66761f08faf7f65d6ee1;hb=7aefc6cd5c93afe464bcf527d20fdac81d00af77#l3597

Why did you think it was not ready?

Even if it was not there, it takes about 30 minutes to write the hwmod for such a basic IP.

Doing the platform driver first was perhaps needed for legacy code, in your case, you are probably wasting your time writing code that was be already there and that you will have to remove later.

Benoit
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



