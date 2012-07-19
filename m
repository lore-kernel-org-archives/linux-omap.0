From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: OMAP PM late init with DT blob
Date: Thu, 19 Jul 2012 12:26:41 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB13E3B@DBDE01.ent.ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EB110DA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1207171430430.28834@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433EB128F7@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1207181018550.16772@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56425 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab2GSM0r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 08:26:47 -0400
In-Reply-To: <alpine.DEB.2.00.1207181018550.16772@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Jul 18, 2012 at 21:52:41, Paul Walmsley wrote:
> On Wed, 18 Jul 2012, Bedia, Vaibhav wrote:
> 
> > I checked the different inits which get skipped right now. I think _init_voltages()
> > should not really be dependent on the DT check to cover the cases wherein the voltages
> > are controlled using a regular regulator driver. However right now I don't know what
> > approach to take here. For now I have sent an RFC patch [1] with just the movement of
> > suspend ops.
> 
> That seems reasonable based on a quick glance.  Why not update your patch 
> to just keep that code where it is and wrap the the pmic and voltage late 
> init in that DT test?
> 
Done. I had somehow messed up Kevin's address also :\ Fixed now.

Regards,
Vaibhav
