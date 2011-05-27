From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 2/2] OMAP: add omap_device_reset()
Date: Fri, 27 May 2011 15:46:07 +0300
Message-ID: <1306500367.1905.18.camel@deskari>
References: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>
	 <1306481908-7386-3-git-send-email-tomi.valkeinen@ti.com>
	 <4DDF9B5D.7060408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:60573 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754413Ab1E0MqM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 08:46:12 -0400
Received: by mail-ew0-f52.google.com with SMTP id 28so843738ewy.11
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 05:46:10 -0700 (PDT)
In-Reply-To: <4DDF9B5D.7060408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 2011-05-27 at 14:38 +0200, Cousson, Benoit wrote:
> Hi Tomi,
> 
> On 5/27/2011 9:38 AM, Valkeinen, Tomi wrote:
> > Add omap_device_reset() function which can be used to reset the hwmods
> > associated with the given platform device.
> 
> We've never exposed it because we are trying to avoid that any driver 
> play with asynchronous HW reset. That can lead to undefined HW behavior :-(
> 
> Do you have some strong need for that?

DSS driver has been designed so that it resets the HW before it begins
programming it. That way we get the HW into known state. Otherwise we
need to be extra careful to program all possible registers to a sane
value. Not impossible, of course, but requires extra work.

I noticed the problem with DSI driver, it didn't work anymore if I
didn't reset it.

Why does it lead to undefined HW behaviour? Isn't it much better to
reset the HW before starting to use it to be 100% sure it's in known and
valid state?

Especially in error situations it may be difficult (even impossible) to
recover without reset. DISPC has been known to froze in some sync lost
situations, and, if I recall right, if DSI transfer is aborted the only
way to recover is to reset the DSI block (on OMAP3).

 Tomi


