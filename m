From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap: dsp: fix for ioremap()
Date: Tue, 19 Oct 2010 10:38:34 +0300
Message-ID: <20101019073834.GB12470@legolas.emea.dhcp.ti.com>
References: <1287473844-6228-1-git-send-email-felipe.contreras@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37837 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755871Ab0JSHi5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 03:38:57 -0400
Content-Disposition: inline
In-Reply-To: <1287473844-6228-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

On Tue, Oct 19, 2010 at 02:37:23AM -0500, Felipe Contreras wrote:
>Since ioremap() on RAM will be soon disallowed, this is required.
>
>This also requires a patch like:
>http://article.gmane.org/gmane.linux.kernel/1047146
>
>Felipe Contreras (1):
>  omap: dsp: remove shm from normal memory
>
> arch/arm/plat-omap/devices.c |    4 +++-
> 1 files changed, 3 insertions(+), 1 deletions(-)

-ENOPATCH ??

-- 
balbi
