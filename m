From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [RFC/PATH] OMAP: HSMMC: Fixes for 1.8V MMC2 interface
Date: Tue, 1 Apr 2008 20:44:47 +0530
Message-ID: <004901c8940b$20f1fca0$438918ac@ent.ti.com>
References: <20080331014640.GA14188@ubuntu-workstation> <47F14D61.5030109@indt.org.br> <20080401005137.GA22520@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53692 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbYDAPPX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Apr 2008 11:15:23 -0400
In-Reply-To: <20080401005137.GA22520@ubuntu-workstation>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Seth Forshee' <seth.forshee@gmail.com>, 'Francisco Alecrim' <francisco.alecrim@indt.org.br>
Cc: linux-omap@vger.kernel.org

Hi,

I did not see any board level code to power up the second slot along with this patch.
Where is the code that enables 1.8V to the second slot?

Regards,
Madhu 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Seth Forshee
> Sent: Tuesday, April 01, 2008 6:22 AM
> To: Francisco Alecrim
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC/PATH] OMAP: HSMMC: Fixes for 1.8V MMC2 interface
> 
> On Mon, Mar 31, 2008 at 11:45:21PM +0300, Francisco Alecrim wrote:
> > Hello Seth,
> >    It's fine and work for 3430! Maybe you should resend 
> changing the 
> > commit message. It's too big.
> > 
> > Remove "RFC" from subject.
> > 
> > What do you think?
> > 
> > if(changes)
> >    Acked-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
> 
> Thank you for reviewing/testing.  I wanted to get 
> verification for OMAP3430
> before I officially submitted the patch, and since you have 
> done that I will
> submit it now.
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

