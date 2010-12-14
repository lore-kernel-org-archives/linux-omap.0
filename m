From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v7] OMAP2+: PM: omap device: API's for handling
 mstandby mode
Date: Tue, 14 Dec 2010 07:18:22 +0530
Message-ID: <20101214014822.GA3858@manju-desktop>
References: <1291298392-28729-1-git-send-email-manjugk@ti.com>
 <4CF8AC8B.9040800@ti.com>
 <20101203092514.GA10048@GLPP-machine>
 <4CF8E03A.4010000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:40678 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758932Ab0LNBsj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 20:48:39 -0500
Received: by mail-yx0-f176.google.com with SMTP id 8so65478yxm.21
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 17:48:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF8E03A.4010000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Paul/Benoit,

On Fri, Dec 03, 2010 at 01:19:06PM +0100, Cousson, Benoit wrote:
> On 12/3/2010 10:47 AM, G, Manjunath Kondaiah wrote:
> >* Cousson, Benoit<b-cousson@ti.com>  [2010-12-03 09:38:35 +0100]:
> 
> [...]
> 
> >>>v7: replaced mutex lock with spin lock. Added use count for controlling
> >>>access to sysconfig registers in case if overlapping request/release API's
> >>>are used.
> >>
> >>I'm not sure it should be done here. I'd rather keep that code in
> >>the DMA, since this is the only user of that feature.
> >
> >Are you referring to spin lock or usage count?
> 
> The spinlock is needed, I was referring to the usage count.
> 
> That being said, the API proposed by Paul (request/release
> ) sound like a get/put, so maybe he had that kind of usage in mind.
> 
> I'm still not convince it should be done at hwmod API level.
> 
> 
> Paul,
> Any thoughts on that?

How do we proceed further?

-Manjunath

