From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: OMAP PM late init with DT blob
Date: Wed, 18 Jul 2012 11:03:25 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB128F7@DBDE01.ent.ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EB110DA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1207171430430.28834@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54505 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab2GRLDa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 07:03:30 -0400
In-Reply-To: <alpine.DEB.2.00.1207171430430.28834@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Paul,

On Wed, Jul 18, 2012 at 02:03:04, Paul Walmsley wrote:
> On Tue, 17 Jul 2012, Bedia, Vaibhav wrote:
> 
> > I am looking at adding PM support for AM335x based on l-o/master.
> > arch/arm/mach-omap2/pm.c has the following comment:
> > 
> > /*
> >  * In the case of DT, the PMIC and SR initialization will be done using
> >  * a completely different mechanism.
> >  * Disable this part if a DT blob is available.
> >  */
> > if (of_have_populated_dt())
> >         return 0;
> > 
> > Basic DT support for AM335x is already in mainline so this check causes
> > various PM related inits and also the registration of the suspend ops to be
> > skipped.
> > 
> > I tried searching the list archives for any discussion on this but could not
> > find anything. Can someone shed some light on the how the device tree is to
> > be used for PMIC and SR initialization. 
> > 
> > Any objections to moving the suspend ops registration before the DT blob check?
> 
> Moving the registration makes sense to me, based on a quick look.
> 
> IMHO, a better approach for this code would be to reverse the sense of 
> that of_have_populated_dt() test, and specifically wrap the parts that are 
> going to be changed by DT.  The rationale here is that only certain steps 
> need to be skipped, so those should probably be skipped explicitly rather 
> than skipping the whole function.
> 

I checked the different inits which get skipped right now. I think _init_voltages()
should not really be dependent on the DT check to cover the cases wherein the voltages
are controlled using a regular regulator driver. However right now I don't know what
approach to take here. For now I have sent an RFC patch [1] with just the movement of
suspend ops.

Regards,
Vaibhav B.

[1] http://marc.info/?l=linux-omap&m=134260813520149&w=2 

