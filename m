From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: Incorrect Register Offsets in OMAP Mailbox
Date: Thu, 9 Feb 2012 11:25:48 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433179B3F8@DBDE01.ent.ti.com>
References: <331ABD5ECB02734CA317220B2BBEABC1317897C8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38026 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360Ab2BILZw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 06:25:52 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC1317897C8@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "enli.chan@gmail.com" <enli.chan@gmail.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Henry Chan
> Sent: Tuesday, February 07, 2012 11:27 PM
> To: linux-omap@vger.kernel.org
> Subject: Incorrect Register Offsets in OMAP Mailbox
> 
> Hi,
> 
> Looks like the register offsets are incorrect in the OMAP mailbox code
> (arch/arm/mach-omap2/mailbox.c) for the OMAP4_MAILBOX_IRQ* macros. The
> discrepancy is with p.224 of TI document SPRUGX9 and p3891 of SWPU231K.
> Patch attached.
> 
> My hardware hasn't come in yet, so I would appreciate it if anyone can
> share their experience using this code.
> 

Yes, this change is required. Other than this fix the code is fine IMO.

I guess the address calculation macros can be simplified to match with the
terminology used in the TRM. I'll submit a patch for that once I manage to
get some time for doing it right.

Regards,
Vaibhav
