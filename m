From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH v2 0/7] uio_pruss cleanup and platform support
Date: Mon, 8 Oct 2012 05:13:32 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA9DDE7@DBDE01.ent.ti.com>
References: <1348861072-14507-1-git-send-email-mporter@ti.com>
 <20121003150058.GB11180@beef>
 <1BAFE6F6C881BF42822005164F1491C33EA9C6B7@DBDE01.ent.ti.com>
 <20121005212826.GN11149@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48258 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab2JHFOG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 01:14:06 -0400
In-Reply-To: <20121005212826.GN11149@beef>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Porter, Matt" <mporter@ti.com>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Russell King <linux@arm.linux.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Linux OMAP List <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Sat, Oct 06, 2012 at 02:58:26, Porter, Matt wrote:
> On Fri, Oct 05, 2012 at 04:43:56AM +0000, Hebbar, Gururaja wrote:
> > Matt,
> > 
> > On Wed, Oct 03, 2012 at 20:30:58, Porter, Matt wrote:
> > > On Fri, Sep 28, 2012 at 03:37:45PM -0400, Matt Porter wrote:
> > > > Changes since v1:
> > > > 	- Replaced uio_pruss private SRAM API use with genalloc
> > > > 	- Added DA850 platform device and clock support
> > > > 	- Added DA850 L3 RAM gen_pool support
> > > > 	- Split out DT binding
> > > > 
> > > > This series enables uio_pruss on both DA850 and AM33xx. The driver
> > > > previously was not enabled by any platform and the private SRAM API
> > > > was accessing an invalid SRAM bank for use on DA850. For AM33xx,
> > > > DT, pinctrl, and runtime PM support are added since AM33xx only
> > > > boots via DT.
> > > 
> > > I'm dropping AM33xx/OMAP support from v3 for this series 
> > 
> > Just for my clarification, I believe you will be taking up AM33xx/OMAP 
> > SRAM support later once you have completed supporting DaVinci. Right?
> 
> There's no SRAM support for uio_pruss to be handled for AM33xx, 

Sorry for not being clearer.

I was referring to adding SRAM support for McASP module on AM335x platform.


> but I
> will be posting a separate series with the DT portion and some alternate
> hard reset handling implementation. I find the private OMAP reset api to
> be very ugly but we might have to go with that for now. I didn't want
> the OMAP hard reset portion to hold up the more important part of this
> cleanup.
> 
> -Matt
> 
> > > since the
> > > focus has turned to fixing Davinci SRAM to provide genalloc support
> > > and the associated use of that in the driver.
> > > 
> > > I'll have a separate series with AM33xx support since dealing cleanly
> > > with external resets on OMAP is a bigger issue.
> > > 
> > > -Matt
> > > _______________________________________________
> > > Davinci-linux-open-source mailing list
> > > Davinci-linux-open-source@linux.davincidsp.com
> > > http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> > > 
> > 
> > 
> > Regards, 
> > Gururaja
> > _______________________________________________
> > Davinci-linux-open-source mailing list
> > Davinci-linux-open-source@linux.davincidsp.com
> > http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 


Regards, 
Gururaja
