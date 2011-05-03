From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 0/2] OMAP: DSS: Support new dpi panels
Date: Tue, 03 May 2011 10:54:04 +0300
Message-ID: <1304409244.2180.26.camel@deskari>
References: <1304406457-5109-1-git-send-email-eballetbo@iseebcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:41682 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750881Ab1ECHyK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 03:54:10 -0400
In-Reply-To: <1304406457-5109-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, 2011-05-03 at 09:07 +0200, Enric Balletbo i Serra wrote:
> Hi all,
> 
> These patches add support for two new panels to the generic-dpi-panel.
> 
> The first patch adds support for the Seiko 70WVW1TZ3 LCD panel, and the second
> adds support for the Powertip PH480272T LCD panel.
> 
> Tested with an IGEP v2 board.
> 
> Changes since v1:
>   - Change the names of both panels in the panel_config struct to
>     include the name of the manufacturer.
>   - Mention the board which uses those panels.
> 
> Please consider to add in next merge window, thanks,
> 
> Enric Balletbo i Serra (2):
>   OMAP: DSS2: Support for Seiko 70WVW1TZ3
>   OMAP: DSS2: Support for Powertip PH480272T
> 
>  drivers/video/omap2/displays/panel-generic-dpi.c |   50 ++++++++++++++++++++++
>  1 files changed, 50 insertions(+), 0 deletions(-)

Thanks, applied to DSS tree.

 Tomi



