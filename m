From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Get rid of section mismatch warnings
Date: Fri, 27 May 2011 13:51:58 -0700
Message-ID: <877h9byihd.fsf@ti.com>
References: <1306414838-4330-1-git-send-email-silesh@ti.com>
	<4DDE4EEF.8070108@ti.com> <20110526133732.GD11352@atomide.com>
	<20110526135533.GA25841@n2100.arm.linux.org.uk>
	<20110527105414.GE27962@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:41108 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755008Ab1E0UwB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 16:52:01 -0400
Received: by mail-pw0-f52.google.com with SMTP id 4so1324465pwi.11
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 13:52:00 -0700 (PDT)
In-Reply-To: <20110527105414.GE27962@atomide.com> (Tony Lindgren's message of
	"Fri, 27 May 2011 13:54:15 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Silesh C V <silesh@ti.com>, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110526 16:51]:
>> On Thu, May 26, 2011 at 06:37:32AM -0700, Tony Lindgren wrote:
>> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110526 05:56]:
>> > > On 5/26/2011 6:30 PM, Silesh C V wrote:
>> > > >Get rid of the following and 8 other similar section mismatch
>> > > >warnings
>> > > >
>> > > I send this [1] patch a month back. It's still not considered
>> > > though even after reminder.
>> > > 
>> > > [1] https://patchwork.kernel.org/patch/684831/
>> > 
>> > Applying now into devel-fixes with additional fixes from Silesh.
>> > Updated patch below.
>> 
>> I also have this from a while back.  There's also some nastyness in
>> twl4030-power.c which requires basically s/__init/__devinit/ to almost
>> the entire file.
>
> OK thanks. Kevin, can you queue this fix? Assuming the move of omap
> gpio to drivers/gpio happens this merge window, this needs to be
> updated for the path.

Yeah, I'll take care of this.

GPIO move is now merged for 2.6.40, so I'll queue this as a fix for
the first -rc cycle.

Kevin
