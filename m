From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] I2C: Fix for suspend/resume issue in i2c-core
Date: Wed, 01 Sep 2010 08:53:02 -0700
Message-ID: <87occhlau9.fsf@deeprootsystems.com>
References: <1283219414-8798-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62109 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895Ab0IAPxG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 11:53:06 -0400
Received: by pvg2 with SMTP id 2so2908310pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Sep 2010 08:53:06 -0700 (PDT)
In-Reply-To: <1283219414-8798-1-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Tue, 31 Aug 2010 07:20:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>

[removed non-OMAP folks]

Vishwanath BS <vishwanath.bs@ti.com> writes:

> In current i2c core driver, pm_runtime_set_active call from i2c_device_pm_resume
> is not balanced by pm_runtime_set_suspended call from i2c_device_pm_suspend.
> pm_runtime_set_active called from resume path will increase the child_count of
> the device's parent. However, matching pm_runtime_set_suspended is not called
> in suspend routine because of which child_count of the device's parent
> is not balanced, preventing the parent device to idle.
> Issue has been fixed by adding pm_runtime_set_suspended call inside suspend
> reoutine which will make sure that child_counts are balanced.
> This fix has been tested on OMAP4430.

FYI... for OMAP folks.  Now that this is queued for upstream, it will be
included in my pm-backports branch[1] and included in the PM branch until
it gets merged upstream.

Thanks Vishwa/Partha for getting this merged upstream.

Kevin

[1] for a description of the various branches that make up the PM
branch, please see 'What makes up the PM branch' section of the OMAP PM
wiki:

    http://elinux.org/OMAP_Power_Management
