From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mfd: Fix usbhs_enable error handling
Date: Tue, 26 Apr 2011 12:04:20 +0300
Message-ID: <20110426090418.GJ13227@legolas.emea.dhcp.ti.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com>
 <20110426085846.GI13227@legolas.emea.dhcp.ti.com>
 <3a59290ed8ab560ac9b85fd1f4d5acd4@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54968 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750714Ab1DZJE2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 05:04:28 -0400
Content-Disposition: inline
In-Reply-To: <3a59290ed8ab560ac9b85fd1f4d5acd4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>, Partha Basak <p-basak2@ti.com>, axel.lin@gmail.com, johnstul@us.ibm.com, mpfj-list@mimc.co.uk

On Tue, Apr 26, 2011 at 02:32:04PM +0530, Keshava Munegowda wrote:
> > -----Original Message-----
> > From: Felipe Balbi [mailto:balbi@ti.com]
> > Sent: Tuesday, April 26, 2011 2:29 PM
> > To: Keshava Munegowda
> > Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; balbi@ti.com;
> gadiyar@ti.com; p-
> > basak2@ti.com; axel.lin@gmail.com; johnstul@us.ibm.com;
> mpfj-list@mimc.co.uk
> > Subject: Re: [PATCH] mfd: Fix usbhs_enable error handling
> >
> > Hi,
> >
> > On Thu, Apr 21, 2011 at 07:52:41PM +0530, Keshava Munegowda wrote:
> > > From: Axel Lin <axel.lin@gmail.com>
> > >
> > > In the case of missing platform_data we do not hold a spin_lock,
> > > thus we should not call spin_unlock_irqrestore in the error path.
> > >
> > > Also simplify the error handling by separating the successful path
> > > from error path. I think this change improves readability.
> > >
> > > Signed-off-by: Axel Lin <axel.lin@gmail.com>
> >
> > Can someone give me a Tested-by so I can take these patches.
> >
> > --
> > Balbi
> 
> Hi Balbi
> 
> I have validated this patch and it works :)
> 
> Tested-by: Keshava Munegowda <keshava_mgowda@ti.com>

what about the others ?

-- 
balbi
