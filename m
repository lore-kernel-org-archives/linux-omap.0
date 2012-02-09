From: Tony Lindgren <tony@atomide.com>
Subject: Re: Incorrect Register Offsets in OMAP Mailbox
Date: Thu, 9 Feb 2012 09:47:10 -0800
Message-ID: <20120209174709.GH1426@atomide.com>
References: <331ABD5ECB02734CA317220B2BBEABC1317897C8@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433179B3F8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47094 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab2BIRrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 12:47:12 -0500
Content-Disposition: inline
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433179B3F8@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "enli.chan@gmail.com" <enli.chan@gmail.com>

* Bedia, Vaibhav <vaibhav.bedia@ti.com> [120209 02:54]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Henry Chan
> > Sent: Tuesday, February 07, 2012 11:27 PM
> > To: linux-omap@vger.kernel.org
> > Subject: Incorrect Register Offsets in OMAP Mailbox
> > 
> > Hi,
> > 
> > Looks like the register offsets are incorrect in the OMAP mailbox code
> > (arch/arm/mach-omap2/mailbox.c) for the OMAP4_MAILBOX_IRQ* macros. The
> > discrepancy is with p.224 of TI document SPRUGX9 and p3891 of SWPU231K.
> > Patch attached.
> > 
> > My hardware hasn't come in yet, so I would appreciate it if anyone can
> > share their experience using this code.
> > 
> 
> Yes, this change is required. Other than this fix the code is fine IMO.
> 
> I guess the address calculation macros can be simplified to match with the
> terminology used in the TRM. I'll submit a patch for that once I manage to
> get some time for doing it right.

Care to reply with Acked-by/Tested-by so I can queue this into fixes?

Regards,

Tony
