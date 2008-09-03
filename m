From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: RE: [PATCH 1/3][OMAP 3/4] likely/unlikely for status checking
Date: Tue, 2 Sep 2008 23:02:53 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53449000F6@dlee03.ent.ti.com>
References: <20080902224418.GJ23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56708 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbYICEDF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 00:03:05 -0400
In-Reply-To: <20080902224418.GJ23085@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks for the tip. I'll use it from now on.

- omar

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, September 02, 2008 5:44 PM
> To: Ramirez Luna, Omar
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/3][OMAP 3/4] likely/unlikely for status checking
> 
> Hi,
> 
> * Ramirez Luna, Omar <x00omar@ti.com> [080828 18:28]:
> > This patch was made by Hiroshi Doyu, I don't deserve any kind of credit
> for this.
> 
> You can keep the original author by adding a second From: field to the
> top of the message like this:
> 
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> That way git-am will credit it the right way.
> 
> Tony
> 
> 
> > For better performance, using likely/unlikely for branch prediction
> optimizations
> >
> > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > ---
> >
