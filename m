From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
Date: Mon, 15 Feb 2010 12:24:46 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D99F@dbde02.ent.ti.com>
References: <1265981968-14696-1-git-send-email-charu@ti.com>
 <alpine.DEB.2.00.1002121455470.28188@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38074 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451Ab0BOGyz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 01:54:55 -0500
In-Reply-To: <alpine.DEB.2.00.1002121455470.28188@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Saturday, February 13, 2010 3:31 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; 
> khilman@deeprootsystems.com
> Subject: Re: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
> 
> By the way:
> 
> On Fri, 12 Feb 2010, Varadarajan, Charulatha wrote:
> 
> > They are boot tested on SDP 3430 and compile tested
> > for OMAP 2420 and 2430.
> 
> This part is really offensively misleading.  It does not 
> matter whether 
> the code has been compile-tested on OMAP24xx if it could 
> never actually 
> run on OMAP24xx.

Charu,

You can mention explicitely in the cover letter that these patches
would break omap2 functionality, since no hwmod struct's are added
for omap2. I agree with Paul that saying they are compile tested might
mislead someone in believing that these patches are tested on omap2.

regards,
Rajendra

> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 