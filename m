From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Thu, 8 Nov 2012 18:59:09 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB68799@DBDE01.ent.ti.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il>
 <509BFFDF.9040605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42233 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466Ab2KHS7T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 13:59:19 -0500
In-Reply-To: <509BFFDF.9040605@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>, Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Fri, Nov 09, 2012 at 00:24:23, Hunter, Jon wrote:
> 
> On 11/08/2012 01:59 AM, Igor Grinberg wrote:
> 
> [snip]
> 
> > There is no reliable way to determine which source should be used in runtime
> > for boards that do not have the 32k oscillator wired.
> 
> So thinking about this some more and given that we are moving away from
> board files, if a board does not provide a 32kHz clock source, then this
> should be reflected in the device-tree source file for that board.
> Hence, at boot time we should be able to determine if a 32kHz clock
> source can be used.
> 

Let me feed some more thoughts here :)

The way it is being detected currently is based on timer idle status bit.
I am worried that, this is the only option we have.

You can also refer to the implementation, so that it will help us to 
conclude on this -

http://arago-project.org/git/projects/?p=linux-am33x.git;a=commitdiff;h=58abec6ac010f4f8818caa4a52d16c4802e14acc

Note that this is based on v3.2 kernel (+ additional patches), you should 
look the implementation of function omap_dm_timer_switch_src().

Thanks,
Vaibhav
