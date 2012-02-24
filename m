From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3
Date: Fri, 24 Feb 2012 14:03:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202241401300.23504@utopia.booyaka.com>
References: <87liw8agk4.fsf@ti.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com><20120127190239.GC9339@atomide.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC8@fioues08.ebgroup.elektrobit.com><AA48DD8077D5D945A49BD1782C1140F10122E2B7@fioues08.ebgroup.elektrobit.com>
 <87linxa5gk.fsf@ti.com> <AA48DD8077D5D945A49BD1782C1140F10122E4FF@fioues08.ebgroup.elektrobit.com> <alpine.DEB.2.00.1202222021460.12198@utopia.booyaka.com> <AA48DD8077D5D945A49BD1782C1140F10122E640@fioues08.ebgroup.elektrobit.com>
 <alpine.DEB.2.00.1202231627001.9361@utopia.booyaka.com> <AA48DD8077D5D945A49BD1782C1140F10122E744@fioues08.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55436 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173Ab2BXVDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 16:03:21 -0500
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F10122E744@fioues08.ebgroup.elektrobit.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan.Gowda@elektrobit.com
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 24 Feb 2012, Madhusudhan.Gowda@elektrobit.com wrote:

> [GOWDA] I think I should edit the commit log to avoid any confusion on
> SDTI functionality, is it ok if I do this on the GIT PULL branch ?

I'll just download your patch off the list, since I have some local 
changes to make.  So if you'd like to edit the patch description, I'd 
suggest just replying with the updated message to this thread.

> [GOWDA] I agree it is not a regression patch so can be queued for 3.4.

Great.

> [GOWDA] It does not use the runtime pm infrastructure. In my environment
> # CONFIG_PM_RUNTIME is not set

Interesting.


- Paul
