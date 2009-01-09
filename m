From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Powertop on Beagle
Date: Fri, 9 Jan 2009 20:35:04 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB8589FF@dbde02.ent.ti.com>
References: <49675282.1040100@balister.org>
 <13B9B4C6EF24D648824FF11BE8967162036D4E6661@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35377 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbZAIPFQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 10:05:16 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036D4E6661@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Philip Balister <philip@balister.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Woodruff, Richard
> Sent: Friday, January 09, 2009 7:25 PM
> To: Philip Balister; linux-omap@vger.kernel.org
> Subject: RE: Powertop on Beagle
> 
> > I'm trying to get powertop running on the latest git. It basically 
> > works, but I do not get displays for the C and P states. This has 
> > worked in the past, but the OE kernel I'm using had a lot 
> of patches 
> > then :)
> >
> > Does anyone have a list of things to check, before I start working 
> > through my kernel patch history?
> 
> For kernel:
> You need cpuidle in kernel and configured on.
> You need to enable timerstats under kernel debug options.
> 
> For Userspace:
> You need powetop binary
> You need ncurses package installed

You may want to check this URL as well:
http://tiexpressdsp.com/wiki/index.php?title=Running_PowerTOP_on_OMAP35x_platform

> 
> Regards,
> Richard W.
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 