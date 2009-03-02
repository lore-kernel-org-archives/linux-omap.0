From: "ext George G. Davis" <gdavis@mvista.com>
Subject: Re: [RFC][PATCH] Fix SND_OMAP_SOC_MCBSP=m undefined symbols
Date: Mon, 2 Mar 2009 09:43:00 -0500
Message-ID: <20090302144259.GC18140@mvista.com>
References: <20090227173338.GE15536@mvista.com> <20090302101812.0d8af61d.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:9893 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbZCBOnE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 09:43:04 -0500
Content-Disposition: inline
In-Reply-To: <20090302101812.0d8af61d.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, Mar 02, 2009 at 10:18:12AM +0200, Jarkko Nikula wrote:
> On Fri, 27 Feb 2009 18:33:39 +0100
> "ext George G. Davis" <gdavis@mvista.com> wrote:
> 
> > 
> > When building ASoC drivers as modules for SND_OMAP_SOC_MCBSP based
> > targets, the build fails because omap_ctrl_{read,write}l lack exports.
> > So add the missing exports for omap_ctrl_{read,write}[bwl] to allow
> > building these ASoC (and other) drivers as modules.
> > 
> > Signed-off-by: George G. Davis <gdavis@mvista.com>
> > 
> Thanks! CONFIG_SND_OMAP_SOC_N810=m works fine. And which indicates that
> I haven't tested to compile them as modules...
> 
> I would use "ARM: OMAP2: Fix missing system control module exports"
> or something as a subject. But otherwise fine to me.

Ok, thanks!

> 
> Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>

Added, thanks!

--
Regards,
George
