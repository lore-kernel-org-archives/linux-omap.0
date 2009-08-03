From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: VDD2 setting question
Date: Mon, 3 Aug 2009 13:35:28 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C011EB6D687@dlee02.ent.ti.com>
References: <3DB2B9F4-7903-47BA-9E66-1E34C512A3FD@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60375 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351AbZHCSfg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 14:35:36 -0400
In-Reply-To: <3DB2B9F4-7903-47BA-9E66-1E34C512A3FD@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, Linux OMAP Users <linux-omap@vger.kernel.org>

Koen,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Monday, August 03, 2009 9:49 AM
> To: Linux OMAP Users
> Subject: VDD2 setting question
> I'm to trying to lower VDD2 on beagleboard to something slightly below
> 1V instead of the current slightly above 1V setting, but I'm having a
VDD2 is tied to OMAP voltage, am I right?
OPP2 and OPP3 are respectively at 1.15  and 1.06 or there abouts if I am not wrong -> since VDD2 essentially drives core domain (including L3 and SDRAM as a result), you really don't want to move the voltage lower without considering the implications. Smartreflex is the guy who can measure various points on OMAP and decide if the voltage can safely be lowered without impacting device behavior.

> hard time figuring out how to do that in the linux-omap (non-PM) tree.
> I grepped in (admittedly 2.6.29) arch/arm/mach-omap2 and it only
> returned hits that seem to be related to smartreflex. Now, enabling
If you still insist on doing this, see arch/arm/mach-omap2/omap3-opp.h
 
> And the most important question:
> 
> o Would a patch to lower the default value of VDD2 be accepted into
> the tree? Can it be lowered globally or should it be guarded with an
> machine_is_omap3beagle() clause?
I don't think this is even valid. 

Regards,
Nishanth Menon
