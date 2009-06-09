From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: RE: [PATCH 0/3] OMAP3:WDT:Enable IVA, SECURE and minor bugfixes
Date: Tue, 9 Jun 2009 20:02:40 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BD76FE8C@dnce02.ent.ti.com>
References: <1244495293-17244-1-git-send-email-ubh@ti.com>
 <87r5xtzcsg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56705 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219AbZFISCq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 14:02:46 -0400
In-Reply-To: <87r5xtzcsg.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, June 09, 2009 9:45 AM
> To: Hald, Ulrik Bech
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 0/3] OMAP3:WDT:Enable IVA, SECURE and minor bugfixes
> 
> Ulrik Bech Hald <ubh@ti.com> writes:
> 
> > This patch series enables support for IVA and SECURE
> > WDTs, available on omap34xx.
> > For omap34xx devices the WDT will be accessible
> > (when present) through:
> > SECURE:	       /dev/watchdog1
> > MPU:	       /dev/watchdog2
> > IVA:	       /dev/watchdog3
> >
> > For devices older than omap34xx only MPU WDT is present
> > and will be accessible through /dev/watchdog
> 
> I think you should make the MPU WDT the first one since it will always
> be present.

The reason, why I numbered them as above, is to make them match the OMAP34xx TRM WDT numbering scheme, where SECURE WDT=WDT1, MPU WDT=WDT2 and IVA WDT=WDT3. My thought was that it would introduce more confusion to change the numbers in /dev/ to something else, although I did consider your point.
Do you still think I should change the numbers?

> 
> > The series also fixes two bugs:
> >
> > 1) Correct timeout value is not loaded upon opening the
> >    watchdog device.
> >
> > 2) clks are not enabled when accessing registers in probe
> 
> Can you fix these existing bugs in a separate patch before you add the
> new features.

Sure, no problem.

> 
> Kevin

