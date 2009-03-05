From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
Date: Thu, 5 Mar 2009 06:29:40 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF3500A2@dlee02.ent.ti.com>
References: <12362344552581-git-send-email-ext-eero.nurkkala@nokia.com>
	 <alpine.DEB.2.00.0903050113021.26353@utopia.booyaka.com>
 <1236242774.29572.45.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48004 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbZCEM3x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 07:29:53 -0500
In-Reply-To: <1236242774.29572.45.camel@eenurkka-desktop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>, ext Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Eero Nurkkala
> Sent: Thursday, March 05, 2009 10:46 AM
> To: ext Paul Walmsley
> Cc: linux-omap@vger.kernel.org; Woodruff, Richard
> Subject: Re: [RFC] OMAP: I2C: Use correct bit for CLOCKACTIVITY
> 
> On Thu, 2009-03-05 at 09:42 +0100, ext Paul Walmsley wrote:
> > Hello Eero,
> > Hmm.  Looking at the 34xx Rev O TRM register tables, it looks like most
> > modules use bit 9 to indicate that FCLK should be kept on and bit 8 to
> > indicate that the ICLK should be kept on?  DSI, DISPC, SR, DMA4 are some
> > examples.
> 
> How about McBSP? Same TRM.. I2C, Table 18-5 tells exactly the opposite
> for I2C than what's said in Table 18-44: I2C_SYSC!!
> 
Yep, that does look nuts :(.. Have pinged internally.. 

Regards,
Nishanth Menon
