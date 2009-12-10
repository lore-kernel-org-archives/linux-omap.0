From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHV3 3/4] OMAP3: Correct width for CLKSEL Fields
Date: Thu, 10 Dec 2009 01:40:17 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912100134470.2780@utopia.booyaka.com>
References: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com> <1259211517-12713-2-git-send-email-vishwanath.bs@ti.com> <1259211517-12713-3-git-send-email-vishwanath.bs@ti.com> <1259211517-12713-4-git-send-email-vishwanath.bs@ti.com>
 <alpine.DEB.2.00.0911300310310.17083@utopia.booyaka.com> <FCCFB4CDC6E5564B9182F639FC35608702FAAFE239@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47253 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969AbZLJIkL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 03:40:11 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FAAFE239@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Vishwanath,

On Tue, 8 Dec 2009, Sripathy, Vishwanath wrote:

> I am thinking of adding a new file called /mach-omap2/clock36xx.h and 
> have complete 36xx clock tree defined over there instead of tweaking 
> 34xx clock tree. Any comments?

Aren't most of the clocks shared between 34xx and 36xx?  If so, it seems 
better to try to keep as many structures shared as possible, no?

Also, there is a fairly major clock update that should go in for .33 that 
moves the clock files around.  You might want to base your changes on that 
branch, until Tony pulls it in.  More info here:

    http://marc.info/?l=linux-omap&m=126034503819371&w=2


- Paul
