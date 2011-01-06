From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build break because of clktrctrl_mask
Date: Thu, 06 Jan 2011 10:28:09 -0800
Message-ID: <87ipy1vqdi.fsf@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	<87fwt7z1p3.fsf@ti.com>
	<alpine.DEB.2.00.1101061059590.22048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47655 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751686Ab1AFS2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:28:12 -0500
Received: by mail-pw0-f41.google.com with SMTP id 8so3036276pwj.0
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 10:28:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101061059590.22048@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 6 Jan 2011 11:02:02 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> On Wed, 5 Jan 2011, Kevin Hilman wrote:
>
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>> 
>> > struct clockdomain member clktrctrl_mask is available for only for OMAP2
>> > and OMAP3 architectures. Technially it is also used only for these archs
>> > but this breaks the build with custom OMAP4 configuration.
>> 
>> I'll queue patches 3-5 for the 2.6.38-rc fixes cycle.
>> 
>> With Paul's ack, I can queue the others too, or Paul can decide to take
>> them via his tree.  Paul can decide.
>
> I've acked one and requested minor changes on the other, after which it 
> can be acked by me.  You're welcome to take them at that point.  Just a 
> request, maybe you can post a branch with just these patches in them; that 
> way Rajendra and/or I can rebase his new clockdomain changes on it until 
> -rc1 comes out.

Sure, will do.

I currently have a 'fixes-for-tony' branch in my tree which has all the
fixes I've collected for the -rc cycle.

If you prefer something separate with only the prm and clockdomain
patches from this series, I can do that as well.

Kevin
