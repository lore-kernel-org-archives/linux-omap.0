From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 4/6] ARM: kernel: update cpu_suspend code to use cache
 LoUIS operations
Date: Thu, 13 Sep 2012 18:48:37 +0530
Message-ID: <CAMQu2gwq_HPJFzjxFzZ9YvFsV+BUovRk_kpAsiEpkgnNLKfaxw@mail.gmail.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20120913125347.GD2470@linaro.org> <CAMQu2gw0650GoDrsnrNvjYWxpUeo-ywuFBw36m=7tp+mpNUG5w@mail.gmail.com>
 <20120913130811.GJ28448@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:55400 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938Ab2IMNTA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 09:19:00 -0400
Received: by vbbff1 with SMTP id ff1so3369095vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 06:18:59 -0700 (PDT)
In-Reply-To: <20120913130811.GJ28448@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Thu, Sep 13, 2012 at 6:38 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 13, 2012 at 06:31:35PM +0530, Shilimkar, Santosh wrote:
>> In the series, there is patch "[PATCH 3/6]" which adds an
>> API which let you operate on a specific level.
>
> Which is introduced but as far as I can see, is never used in the patch
> set.  Therefore, it shouldn't be introduced.
>
> We've been here before many many many times, where people introduce stuff
> into the kernel, and then they never get around to using the damned stuff.
> It's happened far too many times to permit on a "but I will use it in the
> future" kind of arguments.
>
> If you're going to introduce something new, include the users in the patch
> set, or don't bother submitting the new function in the vague hope that
> some day it will get used.

Fair enough. We can postpone adding that API now in this series and
add it along with the user. For the record, it was added to use in the A15
low power code to operate on L1 and L2 levels based on the power domain
states.

Regards
santosh
