From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: musb OTG broken in 2.6.29-rc3?
Date: Tue, 10 Feb 2009 09:35:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA81B5E5@dbde02.ent.ti.com>
References: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35514 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbZBJEFu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 23:05:50 -0500
In-Reply-To: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Steve
> Sakoman
> Sent: Monday, February 09, 2009 11:11 PM
> To: linux-omap
> Subject: musb OTG broken in 2.6.29-rc3?
> 
> I've been running with musb in host mode on Overo.
> 
> Now that EHCI is working, I decided to try putting musb in OTG mode.
> 
> Last time I tried this was back in 2.6.28 and it seemed to work just fine.
> 
> In 2.6.29-rc3 I don't get any joy - the musb port doesn't seem to
> switch into host mode when I plug in a miniA cable. Booting with the
> miniA cable in place doesn't seem to help.  Compiling the kernel with
> host mode enabled works as expected.
> 
> Before I spend too much time debugging, has anyone else been
> successful with musb OTG in 2.6.29-rc3?  A quick search of this list
> didn't turn up any discussion of issues.

It works fine on OMAP35x EVM too. I had to add a proc entry for session start
(Switching on the vBus).

Ajay

> 
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

