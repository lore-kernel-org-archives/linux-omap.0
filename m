From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] McSPI Slave and DMA,FIFO support
Date: Thu, 11 Jun 2009 09:29:49 -0700
Message-ID: <87fxe6rawy.fsf@deeprootsystems.com>
References: <54322.10.24.255.18.1242799009.squirrel@dbdmail.itg.ti.com>
	<20090602180600.GI27332@atomide.com>
	<00fe01c9e5c4$3fc92f70$LocalHost@wipultra793>
	<002701c9eaa1$13f13960$LocalHost@wipultra793>
	<87k53isu7n.fsf@deeprootsystems.com>
	<000e01c9eaab$93825830$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f187.google.com ([209.85.216.187]:35906 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbZFKQ3t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 12:29:49 -0400
Received: by pxi17 with SMTP id 17so104697pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 09:29:51 -0700 (PDT)
In-Reply-To: <000e01c9eaab$93825830$LocalHost@wipultra793> (Hemanth V.'s message of "Thu\, 11 Jun 2009 21\:14\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>

"Hemanth V" <hemanthv@ti.com> writes:

>>
>> A Santosh suggested, you need to break this up into parts that are
>> OMAP specific (arch/arm/*) and parts that go via the SPI subsystem
>> (drivers/spi/*.)  If doing this breaks your series, then fix it
>
> But then that would cause a problem, we will not be able to
> use arch/arm/plat-omap/include/mach/mcspi.h and will need to redefine those
> variables in omap2_mcspi.c which obviously is not the preferred way.

Anything shared between the driver and the arch code should go
into <mach/mcspi.h>, this way the arch code always compiles.

For the driver code, when it's submitted upstream, you state that it
has a dependency on the arch code if it is not yet upstream.

The point is to separate out the arch code and get it submitted/merged
asap so driver code has a smooth path.

Kevin

