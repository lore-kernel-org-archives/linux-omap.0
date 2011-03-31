From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Thu, 31 Mar 2011 10:34:06 +0300
Message-ID: <1301556846.2470.2.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>
	 <1301489930.15095.51.camel@deskari>  <4D932E62.2050903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:48854 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752947Ab1CaHeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 03:34:10 -0400
Received: by mail-ey0-f176.google.com with SMTP id 28so613511eya.7
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 00:34:09 -0700 (PDT)
In-Reply-To: <4D932E62.2050903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, 2011-03-30 at 15:21 +0200, Cousson, Benoit wrote:
> On 3/30/2011 2:58 PM, Valkeinen, Tomi wrote:

> > Anyway. To get things working for rc2 (DSS currently crashes due to not
> > enabling dss_clk) we need to either:
> > 1) Change the clock aliases as above
> 
> Changing the clock alias for my point of view is like hacking the HW 
> definition to fit your need. Even if this is temporary, I do not like 
> that approach.
> 
> > 2) Add something like Sumit's patch (attached) to handle dss_clk. While
> > the patch is not that complex, it feels rather hacky.
> 
> Yes, I'd rather hack that issue internally, because this is something 
> you should fix as soon as you switch to PM runtime.
> 
> > What's your opinion?
> 
> Definitively #2.

Ok, let's go with that. I don't like it but hopefully pm_runtime will
clear the mess from dss driver.

Thanks for your time explaining the clock setup to me =)

 Tomi


