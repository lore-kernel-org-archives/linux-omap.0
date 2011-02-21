From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Re: Ping-> Subject:    [PATCH] omap: omap3evm: add support for
 the WL12xx WLAN module to the omap3evm
Date: Mon, 21 Feb 2011 14:59:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BD488FB@dbde02.ent.ti.com>
References: <EC51CDB0807A51469E0C9CB8CF72D65F032D73AA68@dnce02.ent.ti.com>
 <20110217222027.GD20795@atomide.com>
 <EC51CDB0807A51469E0C9CB8CF72D65F033179C274@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51018 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab1BUJ3p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 04:29:45 -0500
In-Reply-To: <EC51CDB0807A51469E0C9CB8CF72D65F033179C274@dnce02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reizer, Eyal" <eyalr@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Reizer, Eyal
> Sent: Sunday, February 20, 2011 4:20 PM
> To: tony@atomide.com
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Re: Ping-> Subject: [PATCH] omap: omap3evm: add support for
> the WL12xx WLAN module to the omap3evm
> 
> On Thu, 2011-02-17 at 14:20 -0800, Tony Lindgren wrote:
> > * Reizer, Eyal <eyalr@ti.com> [110215 07:11]:
> > > Dear Tony,
> > >
> > > I did not receive any comments to the patch I have send in the
> following link:
> > >
> > > http://marc.info/?l=linux-omap&m=129612179900695&w=2
> > >
> > > Are there any issues with excepting this patch?
> >
> > Pushing to devel-board branch for the upcoming merge window.
> > Can you please check it's working? I had to merge some other
> > evm board changes manually..
> >
> > Tony
> 
> Dear Tony,
> 
> As you requested, I have tested the devel-board branch this morning and
> found one merge issue.
> I see that there are now two mux arrays, one for omap35x and one for
> omap36x.
> You have merged the muxes changes to the omap35x_board_mux[] array, but
> have missed the other structure called omap36x_board_mux[].
> The same change should be merged there as well.
> The result is that it would work OK on an evm with an omap35x SOM but
> not on  aboard with an omap37x SOM.
> Please find below a fix for that.
> 

Eyal,

I am assuming that you will be sending an updated version of the patch
fixing some of the issues pointed in this response:
http://marc.info/?l=linux-omap&m=129820402332111&w=2

You can add the patch below to updated submission.

~sanjeev

> Best Regards,
> Eyal Reizer
> 

[snip]...[snip]

