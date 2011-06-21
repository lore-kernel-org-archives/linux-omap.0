From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 20/28] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Tue, 21 Jun 2011 18:18:29 +0300
Message-ID: <1308669509.1872.32.camel@deskari>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307627810-3768-21-git-send-email-tomi.valkeinen@ti.com>
	 <87vcvzz1bc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:58764 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751954Ab1FUPSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jun 2011 11:18:34 -0400
In-Reply-To: <87vcvzz1bc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com

On Tue, 2011-06-21 at 07:49 -0700, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > Use PM runtime and HWMOD support to handle enabling and disabling of DSS
> > modules.
> >
> > Each DSS module will have get and put functions which can be used to
> > enable and disable that module. The functions use pm_runtime and hwmod
> > opt-clocks to enable the hardware.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Runtime PM usage is much better on this version, thanks!
> 
> Like Paul, I'm not crazy about the helper functions, especially the ones
> that don't do much other than call runtime PM with some debug code
> around them since runtime PM already has useful debug.
> 
> However, you're the maintainer and the one who has to debug this code
> more than I do, so that decision is up to you.

I have to say I'm not familiar with runtime PM's debug (yet, I need to
check it out), but if I'm debugging DSS, I'm not interested in runtime
PM's debug concerning some other drivers or any verbose details about
runtime PM.

So by having the wrappers I can just observe DSS debug, and see when DSS
enables/disables runtime PM etc.

If runtime PM's debug allows me to easily only see debugs about DSS,
then I agree that the wrappers are extra.

 Tomi


