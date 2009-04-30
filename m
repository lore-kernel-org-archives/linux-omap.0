From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP: sDMA: Correct the the omap_request_dma_chain()
 signature
Date: Thu, 30 Apr 2009 10:18:16 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B446F96B@dbde02.ent.ti.com>
References: <1241006956-29268-1-git-send-email-santosh.shilimkar@ti.com>
 <20090429220804.2d130ceb.jhnikula@gmail.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B446F94B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52497 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbZD3EsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 00:48:25 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B446F94B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Regards,
Santosh
 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Shilimkar, Santosh
> Sent: Thursday, April 30, 2009 10:02 AM
> To: Jarkko Nikula
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] OMAP: sDMA: Correct the the 
> omap_request_dma_chain() signature
> 
> > -----Original Message-----
> > From: Jarkko Nikula [mailto:jhnikula@gmail.com] 
> > Sent: Thursday, April 30, 2009 12:38 AM
> > To: Shilimkar, Santosh
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] OMAP: sDMA: Correct the the 
> > omap_request_dma_chain() signature
> > 
> > On Wed, 29 Apr 2009 17:39:16 +0530
> > Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> > 
> > > Original OMAP DMA chaining design has chain_id as one of 
> > the callback
> > > parameters. The below patch broke the desing.
> > > 
> > http://git.omapzoom.org/?p=repo/omapkernel.git;a=commitdiff;h=
> > 538528de0cb256f65716ab2e9613d9e920f97fe2
> > > Now callback returns logical channel number and not chain_id. 
> > > Hence the signature of the omap_request_dma_chain() 
> functions needs
> > > to be corrected to avoid any confusion.
> > > 
> > > More details are on this email thread :
> > > http://marc.info/?l=linux-omap&m=122961071931459&w=2
> > > 
> > Thanks! And this thread where I promised to send a patch but 
> > never done
> > it...
> > 
> > http://marc.info/?l=linux-omap&m=122770291205164&w=2
> > 
> > Two comments:
> > "Now callback returns logical channel number and not chain_id. "
> > You mean callback gets lch instead of chain_id as an argument?
> Yes.
> > Change also kernel-doc function comment for omap_request_dma_chain.
> > I.e. those comment lines few lines before the function itself.
> Yes would do that and send the patch.
There is no change needed in the documentation part since there is no description about the callback parameters.
/**
 * @brief omap_request_dma_chain : Request a chain of DMA channels
 *
 * @param dev_id - Device id using the dma channel
 * @param dev_name - Device name
 * @param callback - Call back function
 * @chain_id -
 * @no_of_chans - Number of channels requested
 * @chain_mode - Dynamic or static chaining : OMAP_DMA_STATIC_CHAIN
 * 					      OMAP_DMA_DYNAMIC_CHAIN
 * @params - Channel parameters
 *
 * @return - Succes : 0
 * 	     Failure: -EINVAL/-ENOMEM
 */
int omap_request_dma_chain(int dev_id, const char *dev_name,
			   void (*callback) (int chain_id, u16 ch_status,
					     void *data),
			   int *chain_id, int no_of_chans, int chain_mode,
			   struct omap_dma_channel_params params)
{

So no need to change the patch.

