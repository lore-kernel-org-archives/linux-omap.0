From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC][PATCH] Fix SND_OMAP_SOC_MCBSP=m undefined symbols
Date: Mon, 2 Mar 2009 10:18:12 +0200
Message-ID: <20090302101812.0d8af61d.jarkko.nikula@nokia.com>
References: <20090227173338.GE15536@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18976 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbZCBISg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 03:18:36 -0500
In-Reply-To: <20090227173338.GE15536@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext George G. Davis" <gdavis@mvista.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 27 Feb 2009 18:33:39 +0100
"ext George G. Davis" <gdavis@mvista.com> wrote:

> 
> When building ASoC drivers as modules for SND_OMAP_SOC_MCBSP based
> targets, the build fails because omap_ctrl_{read,write}l lack exports.
> So add the missing exports for omap_ctrl_{read,write}[bwl] to allow
> building these ASoC (and other) drivers as modules.
> 
> Signed-off-by: George G. Davis <gdavis@mvista.com>
> 
Thanks! CONFIG_SND_OMAP_SOC_N810=m works fine. And which indicates that
I haven't tested to compile them as modules...

I would use "ARM: OMAP2: Fix missing system control module exports"
or something as a subject. But otherwise fine to me.

Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
