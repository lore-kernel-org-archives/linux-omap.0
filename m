From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Support for Innolux AT070TN83
Date: Fri, 02 Sep 2011 10:58:04 +0300
Message-ID: <1314950284.3374.31.camel@deskari>
References: <1314859332.1933.4.camel@deskari>
	 <1314882308-25915-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:53914 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933135Ab1IBJSn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 05:18:43 -0400
Received: by mail-bw0-f44.google.com with SMTP id r4so3714602bka.17
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 02:18:41 -0700 (PDT)
In-Reply-To: <1314882308-25915-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org

On Thu, 2011-09-01 at 15:05 +0200, Thomas Weber wrote:
> Add support for Innolux AT070TN83, a 7 inch LCD
> with RGB-Interface and touch panel to panel-generic-dpi.
> 
> Tested with Devkit8000.
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
>  drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)

Thanks, these look fine to me.

The subject suggests there are 3 patches, but I presume that's wrong?

 Tomi


