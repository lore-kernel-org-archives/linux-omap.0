From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
Date: Tue, 14 Feb 2012 10:44:56 +0530
Message-ID: <4F39EDD0.9010304@ti.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com> <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com> <20120210191813.GU1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:58363 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750767Ab2BNFPE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 00:15:04 -0500
Received: by mail-iy0-f182.google.com with SMTP id o4so6466099iae.41
        for <linux-omap@vger.kernel.org>; Mon, 13 Feb 2012 21:15:02 -0800 (PST)
In-Reply-To: <20120210191813.GU1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Saturday 11 February 2012 12:48 AM, Tony Lindgren wrote:
> * Santosh Shilimkar<santosh.shilimkar@ti.com>  [120202 05:33]:
>> >  From: Rajendra Nayak<rnayak@ti.com>
>> >
>> >  hwmod setup already does a reset and sets the OCP sysconfig
>> >  registers appropriately. Avoid doing a reset again and overriding
>> >  the OCP sysconfig settings in the system timer init code.
 >
> If we want this queued as a fix, it should also describe what
> actually breaks? Timer? PM?

It only fixes the redundant reset and overriding the smartidle-wakeup
OCP setting (done by hwmod) with the smartidle in the driver.
Doing this doesn't really break anything as yet in mainline, but will
cause timer wakeup issues once OFF mode is in place for OMAP4. On OMAP5
however this was causing more issues as the softreset bit position is
different than on OMAP2/3/4.
So it should be ok to queue this in for 3.4 considering neither OMAP4
OFF, not OMAP5 support is in mainline yet.


