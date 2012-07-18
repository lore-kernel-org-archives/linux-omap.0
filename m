From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP PM late init with DT blob
Date: Wed, 18 Jul 2012 10:22:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207181018550.16772@utopia.booyaka.com>
References: <B5906170F1614E41A8A28DE3B8D121433EB110DA@DBDE01.ent.ti.com> <alpine.DEB.2.00.1207171430430.28834@utopia.booyaka.com> <B5906170F1614E41A8A28DE3B8D121433EB128F7@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45937 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab2GRQWm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 12:22:42 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EB128F7@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, 18 Jul 2012, Bedia, Vaibhav wrote:

> I checked the different inits which get skipped right now. I think _init_voltages()
> should not really be dependent on the DT check to cover the cases wherein the voltages
> are controlled using a regular regulator driver. However right now I don't know what
> approach to take here. For now I have sent an RFC patch [1] with just the movement of
> suspend ops.

That seems reasonable based on a quick glance.  Why not update your patch 
to just keep that code where it is and wrap the the pmic and voltage late 
init in that DT test?


- Paul
