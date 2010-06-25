From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] omap: hwspinlock: Added hwspinlock driver
Date: Fri, 25 Jun 2010 11:38:00 -0700
Message-ID: <87ocezklfb.fsf@deeprootsystems.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
	<4C2464B1.6030008@ti.com>
	<F39349C6FA641B4A831B7BF4EBF4D4E14728E3B0@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:52093 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab0FYSiD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 14:38:03 -0400
Received: by pxi8 with SMTP id 8so835844pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 11:38:02 -0700 (PDT)
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E14728E3B0@dlee03.ent.ti.com>
	(Simon Que's message of "Fri, 25 Jun 2010 13:13:35 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

"Que, Simon" <sque@ti.com> writes:

[...]

>> Why using a Kconfig option in that case? You can reserve the locks at
>> run time based on other driver request. The goal of the hwspinlock is to
>> protect data shared between various processors inside OMAP4 like ipu,
>> iva, dsp and mpu. So in anycase the syslink driver can request the
>> needed locks at init time on behalf of the dsp or the ipu.
>> 
>> Since you don't even know the number of locks because it is determined
>> at init time, you cannot know at build time that information.
>> 
>> You should add an API to reserve some locks at run time instead of doing
>> that.
>
> The reserved locks are not meant for syslink use only.  It will also
> be used by i2c, which does not go through syslink.  If we were to
> follow your suggestion, who should call the function to establish
> number of reserved locks?  

Board code.

> We can instead think of the config option as requesting a particular
> number of reserved locks for system use, independent of how many locks
> actually exist in the system.  How many reserved locks there are, and
> which driver is using which reserved locks -- that is a system
> integration issue that should be sorted out at a higher level.

Still, Benoit is right.  It should be a run-time decision, not a
compile-time decision, and it could be done by a board file as needed.

Also, you wouldn't even need a new API for this.  Just have the board
code request the specific spinlocks it would like to reserve.

>> 
>> Since it is a new driver for a new IP, why don't you use directly the
>> omap_device / omap_hwmod abstraction?
>
> hwmod for spinlock is not currently ready.  

Then please help get it ready.  We need to work together to get hwmods
ready and validated for all IP blocks.

> We want to integrate with the platform/driver/device system for now,
> as a first step.  hwmod can be implemented later.

As we are now switching to to hwmods, new drivers will not be merged
without hwmod support.

As a starint point, you can base your changes on the pm-wip/hwmods-omap4
branch of my linux-omap-pm git tree[1]

Many other folks are currently working hwmod conversions for several
other drivers using this as a base.  Please help us with that effort.

Thanks,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
