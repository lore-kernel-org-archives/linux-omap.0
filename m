From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH]omap: i2c: Avoid compilation error in case the header is
 included multiple times
Date: Wed, 25 Aug 2010 00:27:59 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E8351872@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E835183B@dbde02.ent.ti.com>
 <20100824184912.GA29744@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54035 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab0HXS6I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 14:58:08 -0400
In-Reply-To: <20100824184912.GA29744@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "tony@atomide.com" <tony@atomide.com>

Hi Felipe,

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
> Sent: Tuesday, August 24, 2010 1:49 PM
> To: C.A, Subramaniam
> Cc: linux-omap@vger.kernel.org; Gadiyar, Anand; tony@atomide.com
> Subject: Re: [PATCH]omap: i2c: Avoid compilation error in 
> case the header is included multiple times
> 
> On Tue, Aug 24, 2010 at 07:14:30PM +0200, ext C.A, Subramaniam wrote:
> >>From e3c3ee9317850b2b26e02680a0c976d3c75febab Mon Sep 17 
> 00:00:00 2001
> >From: Subramaniam C.A <subramaniam.ca@ti.com>
> >Date: Tue, 24 Aug 2010 12:02:28 -0500
> >Subject: [PATCH] omap: i2c: Avoid compilation error in case 
> the header is included multiple times.
> >
> >Added defines to avoid compilation error.
> >
> 
> could you list one such case ?
This caused a compilation error for the OMAP4 tree, where the ipu_pm.c file was including plat/i2c.h and plat/omap-pm.h.
Ref: http://dev.omapzoom.org/?p=integration/kernel-omap4.git;a=blob;f=drivers/dsp/syslink/ipu_pm/ipu_pm.c;h=b1791d4e7f2113eed046d3785106360dbe1cfc86;hb=d67c37aaadb80a6209f07618302bb84e1c952e97

omap-pm.h indirectly includes plat/i2c.h and hence the compilation error.

Yes we could have removed the,

#include <plat/i2c.h>

from the ipu_pm.c file and avoided the compilation error, but it still made sense to have this patch.

> 
> >Signed-off-by: Subramaniam C.A <subramaniam.ca@ti.com>
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> --
> balbi
> 
> DefectiveByDesign.org
> 

BR
Subbu