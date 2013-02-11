From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
Date: Mon, 11 Feb 2013 10:17:42 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229B966E@DBDE01.ent.ti.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081855370.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57263 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732Ab3BKKRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 05:17:50 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

> -----Original Message-----
> From: J, KEERTHY
> Sent: Monday, February 11, 2013 10:16 AM
> To: 'Paul Walmsley'
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
> 
> Hi Paul,
> 
> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Saturday, February 09, 2013 12:29 AM
> > To: J, KEERTHY
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
> >
> > Hi Keerthy,
> >
> > On Fri, 8 Feb 2013, Paul Walmsley wrote:
> >
> > > On Fri, 8 Feb 2013, J, KEERTHY wrote:
> > >
> > > > Thanks for updating. Yes renaming the
> > > > 'omap_clocks_register_links() Is fine. I had blindly followed the
> > > > hwmod function naming
> > convention.
> > > > The new name makes sense.
> > >
> > > OK great.  BTW don't forget to cc the linux-arm-kernel mailing list
> > for
> > > all patches, otherwise we won't be able to merge the patches.
> > > Taking
> > care
> > > of it now in this case.
> >
> > Just noticed during final testing of this patch that it causes some
> > problems with power management on OMAP4460: (see the suspend/resume
> > messages)
> >
> 
> I understand that retention is broken from the logs.
> I first tried seeing if the retention is working without the patch And
> I see that even without the patch retention fails.
> 
> I am attaching the log.
> 
> I just want to confirm if the retention is working fine without
> Applying the patch on mainline.
> 
> Top Commit ID: 836dc9e3fbbab0c30aa6e664417225f5c1fb1c39
> Defconfig: omap2plus_defconfig
> 
> Am I missing something here?

That was a bootloader issue. I am able to see that the mainline uImage
Hits retention. I could not apply the updated version of this patch from
You. I guess the updated version is on top of other non merged patches.

I just applied the earlier version of this patch and saw that
Retention is fine on OMAP4460.

Can I pull the other patches and rebase this patch on top of them?
I need the branch where I can pull the other clock related patches.
I will rebase this patch on top, Verify the PM suspend on OMAP4460
And post it.

> 
> >
> http://www.pwsan.com/omap/testlogs/jk_clock_flags_cleanup_3.9/20130207
> > 1 83613/pm/4460pandaes/4460pandaes_log.txt
> >
> > Could you please take a look at this and see what happened?  I
> suspect
> > that I screwed something up as I was rebasing the patch.
> > Unfortunately I don't have the time to debug it further.
> >
> >
> > - Paul
> 
> Regards,
> Keerthy

Regards,
Keerthy
