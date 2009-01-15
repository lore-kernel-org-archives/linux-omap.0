From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 0/3] Add support for OMAP35x processors (v3)
Date: Thu, 15 Jan 2009 14:23:45 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB8D81FC@dbde02.ent.ti.com>
References: <1231617620-18667-1-git-send-email-premi@ti.com>
 <87hc43j8o7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35482 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757324AbZAOIyD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 03:54:03 -0500
In-Reply-To: <87hc43j8o7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, January 14, 2009 1:11 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 0/3] Add support for OMAP35x processors (v3)
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > These patches provide support for the OMAP35x processors.
> >
> > This is essentially a re-submit after series of discusions 
> earlier in 
> > the list. It had always been getting pushed in my to-do list :(
> > See: http://marc.info/?l=linux-omap&m=122029900603111&w=2
> >
> > Based on the comments received, this patch includes following:
> >   1) Updates to Kconfig
> >      (Includes the changes suggested by Aguirre Rodriguez)
> >   2) Runtime check for OMAP35x
> >   3) Updates to omap3_evm_defconfig
> >
> > If the changes look good, I can make updates to Beagle, Overo and 
> > Pandora boards as well.
> >
> > Best regards,
> > Sanjeev
> 
> Sanjeev,
> 
> Is the HEAD of linux-omap working for you on omap3evm?  I 
> just got my EVM and am getting it going but it doesn't boot 
> without CONFIG_DEBUG_LL, and with that enabled, as soon as 
> the normal serial driver is enabled, the serial console goes 
> crazy with garbage output.

Here is the git-log from my working branch that works fine for me.

commit 15f75b6226c2d3b82062bb721e7cb9a1d6f35efd
Author: Ajay Kumar Gupta <ajay.gupta@ti.com>
Date:   Tue Jan 13 14:08:44 2009 +0200
    usb: musb: fix bug in musbhsdma programming
    <snip>--<snip>

commit 0ec95b96fd77036a13398c66901e11cd301190d0
Author: Jouni Hogander <jouni.hogander@nokia.com>
Date:   Fri Jan 9 09:52:33 2009 +0200
    OMAP3: PM: Emu_pwrdm is switched off by hardware even when sdti is in use
    <snip>--<snip>
> 
> I'm about to push a new PM branch and wanted to do some 
> testing on the EVM.
> 

Currently building HEAD of your branch will update soon.

Best regards,
Sanjeev
