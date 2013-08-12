From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Mon, 12 Aug 2013 09:09:43 -0700
Message-ID: <87haeuvqk8.fsf@kernel.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-9-git-send-email-d-gerlach@ti.com>
	<CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
	<52038E88.2050604@ti.com> <5203B336.90102@ti.com>
	<5203C211.7040207@ti.com> <87iozfga1t.fsf@kernel.org>
	<52040E67.4050402@ti.com> <87pptndbtj.fsf@kernel.org>
	<520506B6.7060806@ti.com> <87wqnu9720.fsf@kernel.org>
	<52051A9B.1060606@ti.com> <87bo5661sv.fsf@kernel.org>
	<CA+Bv8XabqNkQzjD93kQZvjdozxjAntNRkY3uCOv0n05UzJ=Zug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62625 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab3HLQJr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Aug 2013 12:09:47 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so7603530pab.1
        for <linux-omap@vger.kernel.org>; Mon, 12 Aug 2013 09:09:46 -0700 (PDT)
In-Reply-To: <CA+Bv8XabqNkQzjD93kQZvjdozxjAntNRkY3uCOv0n05UzJ=Zug@mail.gmail.com>
	(Russ Dill's message of "Fri, 9 Aug 2013 15:28:37 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>

Hi Russ,

Russ Dill <russ.dill@gmail.com> writes:

[...]

> I was taking a look at this situation, figuring that the
> suspend/resume callbacks in omap_device might be the right place to do
> it, and came across this:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=72bb6f9b51c82c820ddef892455a85b115460904
>
> Under what situations would the driver callbacks be present if probe
> fails? I'm looking at really_probe in drivers/base/dd.c, and if probe
> fails, dev->driver is set to NULL. What was the condition this was
> protecting against?

The static suspend/resume methods for PM domains don't check for
dev->driver.  (c.f. device_resume_noirq()), so during system suspend,
the PM domain callbacks are called whether or not there is a driver.

A simlar fix could've been done by checking for the existence of
dev->driver (and maybe that's a better solution), but I chose the latter
so omap_device has a finer grained track of the driver status.

> Also, by modifying _od_suspend_noirq, can we force idle unbound omap
> device? Would we need a new omap_hwmod flag to check which devices
> should be force idled if no driver is bound?

I suppose you could, but that would probably mask driver bugs where the
driver is not properly runtime suspending itself before being removed.

Kevin
