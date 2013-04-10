From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Wed, 10 Apr 2013 15:27:50 -0700
Message-ID: <20130410222749.GR10155@atomide.com>
References: <20130409212318.GR10155@atomide.com>
 <5165A1DB.3020404@ti.com>
 <20130410182034.GH10155@atomide.com>
 <5165CED4.1040800@ti.com>
 <20130410205407.GQ10155@atomide.com>
 <5165E6F1.8040102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65503 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762521Ab3DJW1w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 18:27:52 -0400
Content-Disposition: inline
In-Reply-To: <5165E6F1.8040102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

* Jon Hunter <jon-hunter@ti.com> [130410 15:30]:
> 
> Are you saying that you want to use the version with that is using the
> pre-processor definitions? I was thinking that may be we could do that
> as a clean-up for v3.11 and just use the original version I posted
> earlier. Seems cleaner to me.

No let's do that the preprocessor conversion for v3.11.
 
> > Also, is there need to back port these two patches to v3.9-rc?
> > If nobody has noticed, I guess not?
> 
> This should only be applicable to v3.10 so no need to backport. Or are
> you saying that you are seeing this with v3.9 also? That would be odd.

Not seeing it in v3.9, but I was wondering if it's lurking there too
in some format. But I guess not.

Regards,

Tony
