From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHV3 1/2] OMAP3: Set MPU and IVA bypass Clock Divider
Date: Wed, 14 Apr 2010 00:06:18 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E68EB97C@dbde02.ent.ti.com>
References: <> <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com>
 <1270117939-10730-2-git-send-email-vishwanath.bs@ti.com>
 <alpine.DEB.2.00.1004010245420.27004@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608703049B666B@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1004050507520.14339@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608703049B66BC@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E66994C0@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703049B6D06@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50956 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356Ab0DMSg3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 14:36:29 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703049B6D06@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Sripathy, Vishwanath 
> Sent: Tuesday, April 06, 2010 6:45 PM
> To: Premi, Sanjeev; Paul Walmsley
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCHV3 1/2] OMAP3: Set MPU and IVA bypass Clock Divider
> 

[snip]--[snip] 

> > I have been trying to find a good place for the same myself. Though,
> > my reason is different. The default kernel boots with the OPP3 for
> > OMAP34xx; but when mpurate is used to set 720; I feel sometimes the
> > boot may fail if the voltage isn't right.
> I thought uboot would have set the right voltage while 
> setting the MPU rate. Isn't that true?

"mpurate" is argument passed to kernel. u-boot is not doing much with it.

> > 
> > The voltage does stabilize when smartrelex reflex is initialized.
> Why do you have dependency on SR for voltage stabilization? 
> You can set the right voltage even w/o SR (via VP). SR is 
> only for optimizing Voltage for a given OPP. 

In the default flow, clock_arch_init() where mpurate is acted upon,
I didn't want to start changing the VP. Else some part of the code
in SR - related to VP - will be duplicated. OR needs to be exported.

Still not made my mind; as I have been away from this problem for a
while now :(

~sanjeev

> 
> Regards
> Vishwa
> > 
> > I was trying to move smartreflex above in the init sequence; after
> > i2c has been initialized.
> > 
> > Comments/ thoughts?
> > 
> > Best regards,
> > Sanjeev
> > 

[snip]--[snip]
