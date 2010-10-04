From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
Date: Tue, 5 Oct 2010 00:22:51 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CD8A@dbde02.ent.ti.com>
References: <1285069770-4261-1-git-send-email-manjugk@ti.com>
 <1285076060.14206.3.camel@chotu>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402785A3478@dbde02.ent.ti.com>
 <20100921162658.GA2310@core.coreip.homeip.net>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C98C@dbde02.ent.ti.com>
 <20101004182834.GE8321@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37185 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242Ab0JDSxE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 14:53:04 -0400
In-Reply-To: <20101004182834.GE8321@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>




> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
> Sent: Monday, October 04, 2010 11:59 PM
> To: G, Manjunath Kondaiah
> Cc: Ameya Palande; linux-omap@vger.kernel.org; 
> linux-input@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Tony Lindgren
> Subject: Re: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
> 
> On Mon, Oct 04, 2010 at 01:32:29PM +0530, G, Manjunath Kondaiah wrote:
> > Dmitry,
> > As agreed, can you push this patch?
> > https://patchwork.kernel.org/patch/197442/
> > 
> 
> Manjunath,
> 
> It is queued for 2.6.37 (take a peek at 'next' branch of my 
> tree) - I do not believe that the failure is critical enough for .36.

Thanks for queuing this patch for 2.6.37

-Manjunath
