From: <Madhusudhan.Gowda@elektrobit.com>
Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3
Date: Fri, 24 Feb 2012 11:20:41 +0200
Message-ID: <AA48DD8077D5D945A49BD1782C1140F10122E744@fioues08.ebgroup.elektrobit.com>
References: <87liw8agk4.fsf@ti.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com><20120127190239.GC9339@atomide.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC8@fioues08.ebgroup.elektrobit.com><AA48DD8077D5D945A49BD1782C1140F10122E2B7@fioues08.ebgroup.elektrobit.com> <87linxa5gk.fsf@ti.com> <AA48DD8077D5D945A49BD1782C1140F10122E4FF@fioues08.ebgroup.elektrobit.com> <alpine.DEB.2.00.1202222021460.12198@utopia.booyaka.com> <AA48DD8077D5D945A49BD1782C1140F10122E640@fioues08.ebgroup.elektrobit.com> <alpine.DEB.2.00.1202231627001.9361@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpgw2fi.elektrobit.com ([194.136.18.129]:38942 "EHLO
	smtpgw1fi.elektrobit.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754754Ab2BXJUt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 04:20:49 -0500
Received: from fioumg02.ebgroup.elektrobit.com (smtpgw2fi.ebgroup.elektrobit.com [127.0.0.1])
	by smtpgw1fi.elektrobit.com (8.13.8/8.13.8) with ESMTP id q1O9KkVH000940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Feb 2012 11:20:46 +0200
Received: (from defang@localhost)
	by fioumg02.ebgroup.elektrobit.com (8.13.8/8.13.8/Submit) id q1O9KiL5000935
	for <linux-omap@vger.kernel.org>; Fri, 24 Feb 2012 11:20:44 +0200
Content-class: urn:content-classes:message
In-Reply-To: <alpine.DEB.2.00.1202231627001.9361@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

Please find my comments inlined

Thanks
Gowda

-----Original Message-----
From: Paul Walmsley [mailto:paul@pwsan.com] 
Sent: 24 February 2012 02:11
To: Gowda Madhusudhan
Cc: khilman@ti.com; tony@atomide.com; linux-omap@vger.kernel.org;
linux-arm-kernel@lists.infradead.org
Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3

Hi

On Thu, 23 Feb 2012, Madhusudhan.Gowda@elektrobit.com wrote:

> [Gowda] I found this BUG in the CM code while trying to use both SDTI 
> as well as requirement of enabling Hardware supervised transition 
> CLKTRCTRL_EMU to 0x3.
> 
> SDTI requires the softwre supervised transition to keep connected, by 
> enabling Hardware supervised transition SDTI does not like it so Jouni

> had commented out the HW supervised transtion. Which I agree it is 
> fine on SDTI part.
> .flags          = /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
> 
> But my point here is when I set the HW supervised transition, across 
> MPU OFF the register loses its previous value and changes to reset 
> value 0x2 (SW supervised) is not correct. So I submitted this patch 
> for fixing this general CM code bug.

Okay, that's a little more clear.  So this patch does not affect the
SDTI functionality with your driver?  Your patch description reads:

"Embedded trace debug tools like Serial Trace Interface(sti) using  EMU
domain loses connection across MPU OFF. The patch fixes this issue"

But it sounds like that's not the case?  At least, if the reset value
for CM_CLKSTCTRL_EMU is 0x2, I don't understand how this patch could fix
it.

[GOWDA] I think I should edit the commit log to avoid any confusion on
SDTI functionality, is it ok if I do this on the GIT PULL branch ?

About the patch - I'm fine with the basic underlying idea, but so far it
looks like this is material for 3.4 rather than 3.3-rc, since it's not a
regression?
[GOWDA] I agree it is not a regression patch so can be queued for 3.4.

> Please let me know if my comments answers your question.

Well I was hoping that you might answer my earlier questions about
whether the driver you're using calls into the OMAP infrastructure via
pm_runtime*(), and whether its clocks and hwmod data are defined.
[GOWDA] It does not use the runtime pm infrastructure. In my environment
# CONFIG_PM_RUNTIME is not set


- Paul
