From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: OMAP PM late init with DT blob
Date: Tue, 17 Jul 2012 11:24:06 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB110DA@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60597 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab2GQLYM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 07:24:12 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi,

I am looking at adding PM support for AM335x based on l-o/master.
arch/arm/mach-omap2/pm.c has the following comment:

/*
 * In the case of DT, the PMIC and SR initialization will be done using
 * a completely different mechanism.
 * Disable this part if a DT blob is available.
 */
if (of_have_populated_dt())
        return 0;

Basic DT support for AM335x is already in mainline so this check causes
various PM related inits and also the registration of the suspend ops to be
skipped.

I tried searching the list archives for any discussion on this but could not
find anything. Can someone shed some light on the how the device tree is to
be used for PMIC and SR initialization. 

Any objections to moving the suspend ops registration before the DT blob check?

Regards,
Vaibhav B.


