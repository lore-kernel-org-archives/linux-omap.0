From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: OMAP TV video
Date: Wed, 04 Feb 2009 08:33:07 -0700
Message-ID: <4989B533.9080303@mlbassoc.com>
References: <4989ACE1.7050409@mlbassoc.com> <20090204151541.GC22351@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 137-67-76-76-skybeam.com ([76.76.67.137]:1593 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbZBDPdP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 10:33:15 -0500
In-Reply-To: <20090204151541.GC22351@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Imre Deak wrote:
> On Wed, Feb 04, 2009 at 03:57:37PM +0100, ext Gary Thomas wrote:
>> Note: if this is the wrong list, or if there's a better place
>> to ask these questions, please redirect me.
>>
>> I have an OMAP/Zoom1 (3430 LDP).  I'm trying to use the
>> S-Video output, without much success.  Today, I grabbed
>> the latest tree (as least from what I can gather from various
>> web pages) from git://git.omapzoom.org/repo/omapkernel.git
>>
>> When I try to use the TV, the kernel crashes immediately:
>> Unhandled fault: external abort on non-linefetch (0x1008) at 0xd8050440
> 
> I'm guessing that the external abort is caused by the DSS interface
> clock being disabled.

How can I fix it?  Am I missing some setup?

How am I supposed to use the S-Video (TV) interface?  Currently,
I'm executing this (which used to work):
  echo tv >/sys/class/display_control/omap_disp_control/graphics

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
