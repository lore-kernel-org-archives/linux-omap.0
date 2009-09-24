From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH][RFC] OMAP3630: Create architecture macros and config
 entries.
Date: Thu, 24 Sep 2009 21:24:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDA2D872@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402534261B3@dbde02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA9DD85B939@dnce01.ent.ti.com>,<A24693684029E5489D1D202277BE89444C6864B8@dlee02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C861E2@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DD9920F8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38800 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753104AbZIXPyl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 11:54:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8OFsghr023654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 10:54:45 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8OFsgYu017601
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 21:24:42 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD9920F8@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Pais, Allen" <allen.pais@ti.com>, linux-omap@vger.k
Cc: "Raju, Veeramanikandan" <veera@ti.com>, "Bongale, Hariprasad" <hariprasad.bongale@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Tuesday, September 22, 2009 5:18 PM
> To: Gadiyar, Anand; Aguirre Rodriguez, Sergio Alberto; 
> Cousson, Benoit; Pais, Allen; linux-omap@vger.kernel.org
> Cc: Raju, Veeramanikandan; Bongale, Hariprasad
> Subject: RE: [PATCH][RFC] OMAP3630: Create architecture 
> macros and config entries.
> 
>  
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Gadiyar, Anand
> > Sent: Tuesday, September 22, 2009 12:12 AM
> > To: Aguirre Rodriguez, Sergio Alberto; Cousson, Benoit; Pais, 
> > Allen; linux-omap@vger.kernel.org
> > Cc: Raju, Veeramanikandan; Bongale, Hariprasad
> > Subject: RE: [PATCH][RFC] OMAP3630: Create architecture 
> > macros and config entries.
> > 
> 
>   snip -- snip --- snip
> 
> > > 
> > > I respectfully tend to disagree with this, since there are 
> > some components
> > > inside the chip that aren't specifically fixes, so IMHO 
> > they need to start
> > > from scratch about silicon revisions because of that.
> > > 
> > > If there are many common points between 34xx/35xx/36xx, 
> > then rename the
> > > reused functions/defines to omap3, instead of 
> > omap34xx/omap35xx/omap36xx.
> 
> [sp] We had same discussion in context of OMAP3517. And the
>      Where the IPs and features etc have been more than just
>      fixes.
> 
>      I will be submitting a patch later today; that will
>      illustrate that cpu_is_xxx() changes are usually limited.

[sp] Do take a look at the patch-set I just submitted:
     Common mechanism to identify Si revision

~sanjeev

> > > 
> > > Regards,
> > > Sergio
> > > 
> > 
> > I agree with Sergio.
> > 
> > While it is definitely possible to write code treating the 3430
> > and the 3630 as the same, they are not the same animal. We will
> > need to distinguish between the two at more than a few locations
> > in code, and we might as well add the ability to do that now.
> > 
> > I see a need to distinguish between 3430 and 3630 in 
> several locations
> > - there are changes in hardware IPs that are not reflected in the IP
> > revision information (meaning we cannot always go by 
> > CPU_HAS_FEATURE() ),
> > and we will need some kind of a cpu_is_* check for sure.
> 
> [sp] See my response above.
> 
> Also, we seem to be at a juncture where may seemlingly similar but
> Different silicons are coming up. I believe it is the *best* time to
> come up with a framework where the IP/feature based checks can be
> Streamlined.
> 
> Best regards,
> Sanjeev
> 
> > 
> > Regards,
> > Anand
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 