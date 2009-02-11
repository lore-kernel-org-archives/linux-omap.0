From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: OMAP [TV] video
Date: Wed, 11 Feb 2009 05:25:37 -0700
Message-ID: <4992C3C1.50709@mlbassoc.com>
References: <19F8576C6E063C45BE387C64729E739403FA81B912@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 137-67-76-76-skybeam.com ([76.76.67.137]:2028 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754968AbZBKMZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2009 07:25:48 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403FA81B912@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Linux OMAP <linux-omap@vger.kernel.org>

Hiremath, Vaibhav wrote:
> 
> Thanks,
> Vaibhav Hiremath
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Gary Thomas
>> Sent: Tuesday, February 10, 2009 9:35 PM
>> To: Linux OMAP
>> Subject: OMAP [TV] video
>>
>> I'm trying to get TV [S-Video] working on my 3530 board.
>> The settings in the current kernel don't seem to work very
>> well on my TV (U.S. NTSC, standard).  Comparing the video
>> encoder setup with the suggested values in the manual, I
>> find many differences, mostly with respect to the framing
>> (signal shaping).
>>
>> Questions:
>> * Are the settings in the kernel tree known to work [as is]?
>> * Why the divergence from the recommended values?
>>
>> Any ideas or helpful pointers would be graciously accepted
>>
> [Hiremath, Vaibhav] Can you provide some more details like,
> 
> Which kernel version are you using?

I started with the "official" OMAP tree (git://git.omapzoom.org/repo/omapkernel.git)

If there is a better starting point, I'd certainly like to know.
Trying to find the correct tree to use is challenging.

> Are you using DSS2 for TV out?

Not sure exactly what that means.  Again, trying to follow this
development is not straight forward - it seems that those who
know the answers assume that everyone does, so why bother explaining
anything?  (Maybe that's a bit cynical, but my experience so far)

> Which board you are using, (must be EVM)?

It's a new board under development, more or less like the beagle.

Again, I'd appreciate any help or pointers.  Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
