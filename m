From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Wed, 08 Jun 2011 10:55:52 +0300
Message-ID: <1307519752.1944.21.camel@deskari>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>
	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>
	 <87hb86a5mm.fsf@ti.com> <1307174504.1777.24.camel@lappyti>
	 <4DECCE90.6070201@ti.com> <1307365290.1910.39.camel@deskari>
	 <4DECD2D7.6030207@ti.com> <1307366474.1910.44.camel@deskari>
	 <4DECDA3A.7080808@ti.com> <1307368525.1910.50.camel@deskari>
	 <4DECF215.5020505@ti.com> <1307429547.1858.10.camel@deskari>
	 <4DEE0D7E.6090309@ti.com> <1307447504.1858.37.camel@deskari>
	 <4DEE5537.7060008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:56165 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752211Ab1FHHz6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 03:55:58 -0400
In-Reply-To: <4DEE5537.7060008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

On Tue, 2011-06-07 at 18:43 +0200, Cousson, Benoit wrote:
> On 6/7/2011 1:51 PM, Valkeinen, Tomi wrote:
> > On Tue, 2011-06-07 at 13:37 +0200, Cousson, Benoit wrote:

> >> The issue is that there is only one modulemode for the whole DSS.
> >> Potentially only the dss_hwmod should have it. But then you have to
> >> ensure that this device is enabled before any other DSS devices.
> >
> > Does that change anything? Isn't the above (modulemode enabled before
> > opt clock) still true, even if it was enabled only once for the dss_core
> > hwmod?
> 
> It does not really change anything, but it is more accurate.
> Modulemode need to be enable after the opt clocks that act as a 
> functional clock and before enabling HW_AUTO for the clockdomain.
> 
> The important parameter is the clock domain mode change. It is another 
> issue that we have to fix. It might not affect you for the moment.

Ok. But the main issue now is the PM. If I change the clocks in hwmod
data as you suggested, dss_fck will always stay enabled and prevent RET
and OFF. So the fix is not acceptable even for temporary use.

So is there some way to fix this, or shall we just go forward with the
current patch series having the somewhat hacky way to use pm_runtime?

I would personally like to get the driver right from the start, even if
that means more hacks in the hwmod fmwk (because that's where the
problems are). But if that is very difficult, I'm fine with the current
patch series.

 Tomi


