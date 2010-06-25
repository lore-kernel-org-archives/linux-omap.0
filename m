From: "Que, Simon" <sque@ti.com>
Subject: RE: [RFC] omap: hwspinlock: Added hwspinlock driver
Date: Fri, 25 Jun 2010 13:13:35 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E14728E3B0@dlee03.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
 <4C2464B1.6030008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42982 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab0FYSNi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 14:13:38 -0400
In-Reply-To: <4C2464B1.6030008@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Benoit,

Thanks for the comments.  My responses are below.

> Why using a Kconfig option in that case? You can reserve the locks at
> run time based on other driver request. The goal of the hwspinlock is to
> protect data shared between various processors inside OMAP4 like ipu,
> iva, dsp and mpu. So in anycase the syslink driver can request the
> needed locks at init time on behalf of the dsp or the ipu.
> 
> Since you don't even know the number of locks because it is determined
> at init time, you cannot know at build time that information.
> 
> You should add an API to reserve some locks at run time instead of doing
> that.

The reserved locks are not meant for syslink use only.  It will also be used by i2c, which does not go through syslink.  If we were to follow your suggestion, who should call the function to establish number of reserved locks?  We can instead think of the config option as requesting a particular number of reserved locks for system use, independent of how many locks actually exist in the system.  How many reserved locks there are, and which driver is using which reserved locks -- that is a system integration issue that should be sorted out at a higher level.

> It is a details, but why are you renaming the registers with the HW
> prefix? The module name is spinlock not hwspinlock.
> 
> The names should be that:
> #define SPINLOCK_REVISION                    0x0000
> #define SPINLOCK_SYSCONFIG                   0x0010
> #define SPINLOCK_SYSSTATUS                   0x0014
> #define SPINLOCK_LOCK_BASE                   0x0800
> 
> or even that since you are not sharing these defines:
> #define REVISION                    0x0000
> #define SYSCONFIG                   0x0010
> #define SYSSTATUS                   0x0014
> #define LOCK_BASE                   0x0800
> 
> Every IPs are by definition an HW module, so that information is useless.

You have a good point, I will make this change.

> 
> Since it is a new driver for a new IP, why don't you use directly the
> omap_device / omap_hwmod abstraction?

hwmod for spinlock is not currently ready.  We want to integrate with the platform/driver/device system for now, as a first step.  hwmod can be implemented later.


Simon
