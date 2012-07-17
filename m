From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP PM late init with DT blob
Date: Tue, 17 Jul 2012 14:33:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207171430430.28834@utopia.booyaka.com>
References: <B5906170F1614E41A8A28DE3B8D121433EB110DA@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35722 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab2GQUdF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 16:33:05 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EB110DA@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Tue, 17 Jul 2012, Bedia, Vaibhav wrote:

> I am looking at adding PM support for AM335x based on l-o/master.
> arch/arm/mach-omap2/pm.c has the following comment:
> 
> /*
>  * In the case of DT, the PMIC and SR initialization will be done using
>  * a completely different mechanism.
>  * Disable this part if a DT blob is available.
>  */
> if (of_have_populated_dt())
>         return 0;
> 
> Basic DT support for AM335x is already in mainline so this check causes
> various PM related inits and also the registration of the suspend ops to be
> skipped.
> 
> I tried searching the list archives for any discussion on this but could not
> find anything. Can someone shed some light on the how the device tree is to
> be used for PMIC and SR initialization. 
> 
> Any objections to moving the suspend ops registration before the DT blob check?

Moving the registration makes sense to me, based on a quick look.

IMHO, a better approach for this code would be to reverse the sense of 
that of_have_populated_dt() test, and specifically wrap the parts that are 
going to be changed by DT.  The rationale here is that only certain steps 
need to be skipped, so those should probably be skipped explicitly rather 
than skipping the whole function.


- Paul
