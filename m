From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] OMAP: DSS: Support new dpi panels
Date: Tue, 03 May 2011 09:48:14 +0300
Message-ID: <1304405294.2180.5.camel@deskari>
References: <1304332184-14687-1-git-send-email-eballetbo@iseebcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58233 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752019Ab1ECGsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 02:48:19 -0400
In-Reply-To: <1304332184-14687-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Mon, 2011-05-02 at 12:29 +0200, Enric Balletbo i Serra wrote:
> Hi all,
> 
> These patches add support for two new panels to the generic-dpi-panel.
> 
> The first patch adds support for the Seiko 70WVW1TZ3 LCD panel, and the second
> adds support for the Powertip PH480272T LCD panel.
> 
> Tested with an IGEP v2 board.
> 
> Please consider to add in next merge window, thanks,
> 
> Enric Balletbo i Serra (2):
>   OMAP: DSS2: Support for Seiko 70WVW1TZ3
>   OMAP: DSS2: Support for Powertip PH480272T
> 
>  drivers/video/omap2/displays/panel-generic-dpi.c |   50 ++++++++++++++++++++++
>  1 files changed, 50 insertions(+), 0 deletions(-)

Could you change the names of both panels in the panel_config struct to
include the name of the manufacturer, like the other panels? So
"70wvw1tz3" -> "seiko_70wvw1tz3".

And you could mention the the board which uses those panels in the
commit messages, just for reference.

Otherwise looks fine.

 Tomi


