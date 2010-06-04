From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH v6 4/7] omap3: pm: changing vdd0_/vdd1_ to vdd1_/vdd2_ in VC param structure
Date: Fri, 4 Jun 2010 13:25:46 +0530
Message-ID: <007601cb03bb$573cef50$e08818ac@apr.dhcp.ti.com>
References: <1274186139-23960-1-git-send-email-leslyam@ti.com> <87r5koui2k.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55093 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab0FDHzz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 03:55:55 -0400
In-Reply-To: <87r5koui2k.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

Hi Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, June 03, 2010 11:15 PM
> To: Lesly A M
> Cc: linux-omap@vger.kernel.org; Lesly A M; Nishanth Menon; David Derrick;
> Samuel Ortiz
> Subject: Re: [PATCH v6 4/7] omap3: pm: changing vdd0_/vdd1_ to vdd1_/vdd2_
> in VC param structure
> 
> Lesly A M <leslyam@ti.com> writes:
> 
> > Rename vdd0_/vdd1_ to vdd1_/vdd2_ in VC param structure.
> 
> That answers "what?", but not "why?"
> 
> Yes, I know the answer right now, but I forget things often.
> 
> Please help ease the pain of my forgetfullness by writing a
> descriptive changelog so when I or anyone else looks at this in the
> git history, they will be able to understand.
> 
> Kevin

Actually there is no VDD0, its VDD1 & VDD2. So the renaming is done just to
avoid the confusion.

Regards,
Lesly A M

