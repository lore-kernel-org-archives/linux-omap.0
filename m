From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
Date: Wed, 08 Feb 2012 16:20:28 -0800
Message-ID: <87ipjgx3g3.fsf@ti.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
	<E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
	<20120208184539.GE29796@atomide.com> <87ty312ae0.fsf@ti.com>
	<20120208235358.GD16877@atomide.com>
	<20120208235620.GE25414@n2100.arm.linux.org.uk>
	<87sjikx3xv.fsf@ti.com>
	<20120209001135.GF25414@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:52143 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755721Ab2BIAUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 19:20:31 -0500
Received: by mail-pz0-f53.google.com with SMTP id y25so1213846dad.12
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 16:20:30 -0800 (PST)
In-Reply-To: <20120209001135.GF25414@n2100.arm.linux.org.uk> (Russell King's
	message of "Thu, 9 Feb 2012 00:11:35 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Feb 08, 2012 at 04:09:48PM -0800, Kevin Hilman wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> > Does it fix the other issues I mention in the commit log as well?
>> 
>> Like your patches 1 & 5, my series fixes the oops and also makes the
>> error strings simple, non-wrapping ones.
>> 
>> The one thing it doesn't fix is the spelling typo you fixed in the
>> comment, but IMO we can leave that out for -rc.
>
> OK, but it would be much better for that simple fix to go with another
> simple patch.  On its own it doesn't make sense as a commit.

Agreed.  We'll have some other VC/VP cleanup for v3.4, and I'll add this
into that cleanup.

Thanks,

Kevin
