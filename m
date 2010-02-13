From: Andreas Hartmetz <ahartmetz@gmail.com>
Subject: Re: USB lockup on OMAP3530
Date: Sat, 13 Feb 2010 21:49:22 +0100
Message-ID: <f3642e6b1002131249y2af6704bk13875ab575c28e62@mail.gmail.com>
References: <f3642e6b1001261430n32d55can502931fc93271f67@mail.gmail.com>
	 <4551feaf1001261513vf8ba655ua1c050a28f1d57eb@mail.gmail.com>
	 <201001272046.42946.ahartmetz@gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB031E80D1A1@dbde02.ent.ti.com>
	 <4B745311.4000708@panicking.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:48587 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab0BMUtZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Feb 2010 15:49:25 -0500
Received: by fxm27 with SMTP id 27so44353fxm.25
        for <linux-omap@vger.kernel.org>; Sat, 13 Feb 2010 12:49:23 -0800 (PST)
In-Reply-To: <4B745311.4000708@panicking.kicks-ass.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@panicking.kicks-ass.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Robert Nelson <robertcnelson@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Feb 11, 2010 at 7:57 PM, Michael Trimarchi
<michael@panicking.kicks-ass.org> wrote:
>
> Use an hub with external power and connect the hub to the OTG and the device
> to the HUB.
> Is it the same?
>
Uhm... what do you think how I attached a hard disk and a network
device to the Beagle's USB OTG port (ONE port) that can only supply
100 mA?
Of course I have everything connected to a powered hub that is
connected to the OTG port.
Note that my bug report is not about USB devices not working at all.
