From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] OMAP: control: bootaddr and bootmod APIs
Date: Fri, 18 May 2012 16:50:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205181649410.24735@utopia.booyaka.com>
References: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43341 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967822Ab2ERWuB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 18:50:01 -0400
In-Reply-To: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-dev@lists.linaro.org

Hello Omar,

On Wed, 2 May 2012, Omar Ramirez Luna wrote:

> Recently a patch went in for tidspbridge code, to ioremap
> SCM registers and solve a build break[1]. However it has
> been pointed out before that this is a layer violation
> given that control module should handle its own registers, this
> series is an attempt to create APIs for the users of these
> registers.
> 
> With some adaptations this patch might also make use of it:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg66491.html
> 
> Patch: staging: tidspbridge: use scm functions to set boot address and mode,
> will be sent separately to staging tree.
> 
> Tested on OMAP3 Beagleboard.
> 
> [1] http://www.mail-archive.com/devel@linuxdriverproject.org/msg18762.html
> 
> Omar Ramirez Luna (3):
>   OMAP2+: control: new APIs to configure boot address and mode
>   OMAP: dsp: interface to control module functions
>   staging: tidspbridge: use scm functions to set boot address and mode

Thanks, queued for 3.6.

- Paul
