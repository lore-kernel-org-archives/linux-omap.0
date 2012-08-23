From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 0/2] OMAPDSS: fixes for -rc
Date: Thu, 23 Aug 2012 20:34:08 +0000
Message-ID: <503693C0.5000103@gmx.de>
References: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:33656 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751581Ab2HWUeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Aug 2012 16:34:14 -0400
In-Reply-To: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Hi Tomi,

On 08/21/2012 06:09 AM, Tomi Valkeinen wrote:
> Hi Florian,
> 
> Here are two small fixes for omapfb and omapdss. The first one fixes an old bug
> that causes colors to be wrong on fb console. The other fixes SDI output that
> got broken in the previous merge window.

Applied both patches. ("The first" is actually 2/2)


Thanks,

Florian Tobias Schandinat

> 
>  Tomi
> 
> Grazvydas Ignotas (1):
>   OMAPFB: fix framebuffer console colors
> 
> Tomi Valkeinen (1):
>   OMAPDSS: Fix SDI PLL locking
> 
>  drivers/video/omap2/dss/sdi.c            |   14 ++++++++++++++
>  drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 

