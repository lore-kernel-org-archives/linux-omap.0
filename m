From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v5] ARM: omap: edma: add suspend suspend/resume hooks
Date: Fri, 08 Nov 2013 08:59:33 +0100
Message-ID: <527C99E5.9020305@gmail.com>
References: <1383863549-7438-1-git-send-email-zonque@gmail.com> <87siv7pxpp.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:54719 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3KHH7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Nov 2013 02:59:37 -0500
Received: by mail-bk0-f49.google.com with SMTP id w14so714389bkz.22
        for <linux-omap@vger.kernel.org>; Thu, 07 Nov 2013 23:59:36 -0800 (PST)
In-Reply-To: <87siv7pxpp.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, joelf@ti.com, gururaja.hebbar@ti.com, balajitk@ti.com, s.neumann@raumfeld.com, mporter@ti.com, nsekhar@ti.com, Russ.Dill@ti.com, nm@ti.com, vaibhav.bedia@gmail.com, linux-arm-kernel@lists.infradead.org

On 11/08/2013 01:02 AM, Kevin Hilman wrote:
> Daniel Mack <zonque@gmail.com> writes:

>> +	.resume_noirq	= edma_pm_resume,
>> +};
> 
> Also, I believe it was already suggested by Nishanth, but the late/early
> callbacks are probably more appropriate here than the noirq callbacks.
> Unless there's a *really* good reason to use the noirq callbacks, they
> should be avoided.

Ok, no problem to change that. Regarding the function ordering,
late/early didn't show any lockup in my tests yet.

> That being said, I wonder if the whole approach here is the right one.
> I know you're basing your stuff on some TI tree, but that doesn't make
> it the right way (usually, it's the opposite, but I digress...)  ;)

:)

Well, I was primarily looking for a solution to bring the edma back to
life after suspend. As I wrote in the first version of this patch that I
sent, I didn't even intent that patch to go mainline at all, given that
arch/arm/common/edma.c woill go away soon.

> IMO, EDMA should be done like we currently do I2C and not implement
> suspend/resume at all.  Instead, the driver should do runtime PM done on
> a per xfer basis.  Then when suspend comes along, all that needs to be
> done is ensure all in-flight xfers are done, then runtime PM will kick
> in.

I see your point in general, but isn't runtime PM there to actually save
power at runtime? Does disabling unused channels in the EDMA really
reduce the consumption of that IP block?


Daniel

