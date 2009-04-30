From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP: sDMA: Correct the the omap_request_dma_chain()
 signature
Date: Thu, 30 Apr 2009 10:02:29 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B446F94B@dbde02.ent.ti.com>
References: <1241006956-29268-1-git-send-email-santosh.shilimkar@ti.com>
 <20090429220804.2d130ceb.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55766 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbZD3Eci convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 00:32:38 -0400
In-Reply-To: <20090429220804.2d130ceb.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Jarkko Nikula [mailto:jhnikula@gmail.com] 
> Sent: Thursday, April 30, 2009 12:38 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP: sDMA: Correct the the 
> omap_request_dma_chain() signature
> 
> On Wed, 29 Apr 2009 17:39:16 +0530
> Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> 
> > Original OMAP DMA chaining design has chain_id as one of 
> the callback
> > parameters. The below patch broke the desing.
> > 
> http://git.omapzoom.org/?p=repo/omapkernel.git;a=commitdiff;h=
> 538528de0cb256f65716ab2e9613d9e920f97fe2
> > Now callback returns logical channel number and not chain_id. 
> > Hence the signature of the omap_request_dma_chain() functions needs
> > to be corrected to avoid any confusion.
> > 
> > More details are on this email thread :
> > http://marc.info/?l=linux-omap&m=122961071931459&w=2
> > 
> Thanks! And this thread where I promised to send a patch but 
> never done
> it...
> 
> http://marc.info/?l=linux-omap&m=122770291205164&w=2
> 
> Two comments:
> "Now callback returns logical channel number and not chain_id. "
> You mean callback gets lch instead of chain_id as an argument?
Yes.
> Change also kernel-doc function comment for omap_request_dma_chain.
> I.e. those comment lines few lines before the function itself.
Yes would do that and send the patch.

Regards,
Santosh