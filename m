From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [RFC] [PATCH] Board changes for tmp105 temperature sensor
Date: Thu, 1 Jul 2010 18:02:30 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B360314E@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C003B34A6404@dbde02.ent.ti.com>
 <20100701121711.GM2822@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49102 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755651Ab0GAMdB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 08:33:01 -0400
In-Reply-To: <20100701121711.GM2822@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, July 01, 2010 5:47 PM
> To: Datta, Shubhrajyoti
> Cc: linux-omap@vger.kernel.org; LM Sensors
> Subject: Re: [RFC] [PATCH] Board changes for tmp105 temperature sensor
> 
> * Datta, Shubhrajyoti <shubhrajyoti@ti.com> [100615 17:40]:
> > Adding board configuration for the tmp105
> > temperature sensor. The interface to the sensor
> > is I2C.
> >
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> >  mode change 100644 => 100755 arch/arm/mach-omap2/board-4430sdp.c
> 
> Please be careful with the mode changes.
Will send a corrected patch
> 
> Tony
