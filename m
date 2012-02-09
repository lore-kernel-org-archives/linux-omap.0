From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC PATCH 3/8] misc: emif: add register definitions for EMIF
Date: Thu, 9 Feb 2012 14:44:25 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433179B866@DBDE01.ent.ti.com>
References: <331ABD5ECB02734CA317220B2BBEABC1317897B8@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433179B3F3@DBDE01.ent.ti.com>
 <4F33D62E.8070403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44817 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab2BIOoe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 09:44:34 -0500
In-Reply-To: <4F33D62E.8070403@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "V, Aneesh" <aneesh@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 09, 2012 at 19:50:30, V, Aneesh wrote:
> On Thursday 09 February 2012 04:55 PM, Bedia, Vaibhav wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of V, Aneesh
> >> Sent: Saturday, February 04, 2012 5:46 PM
> >> To: linux-omap@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org; akpm@linux-foundation.org; V, Aneesh
> >> Subject: [RFC PATCH 3/8] misc: emif: add register definitions for EMIF
> >>
> >
> > Sorry for the delayed response. Can these register definitions be put in a place
> > where the code from the arch/arm/mach-omap2/* can also access it?
> 
> I don't have any issues with it as long as everybody is in agreement.
> 

Ok. Thanks.

> >
> > Devices like AM335x and TI814x will need to reconfigure the EMIF when coming out
> > of low power states and putting these register definitions in a common place
> > will help us avoid some code duplication.
> 
> Can you elaborate on that. Does EMIF lose its settings in low-power
> mode? If so, are you going to do the re-initialization from internal
> RAM or something? For us EMIF doesn't lose its state in low power modes.
> 

Yes, on AM335x the EMIF happens to be in peripheral domain, which in the lowest power mode
loses its settings. So, while suspending, we save the various EMIF parameters
with the help of some assembly code that is running from the internal RAM. During resume,
we just store the settings and jump back to SDRAM. 

Since the header that you are adding is coming from the h/w database I guess it makes more
sense to reuse that.

Regards,
Vaibhav
