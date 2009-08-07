From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH 12/15] OMAP: DSS2: Add panel drivers
Date: Fri, 07 Aug 2009 14:50:25 +0300
Message-ID: <4A7C1501.9070602@nokia.com>
References: <1249481741-14008-1-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-2-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-3-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-4-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-6-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-7-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-8-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-9-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-10-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-11-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-12-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-13-git-send-email-tomi.valkeinen@no
 kia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26764 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431AbZHGLvM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 07:51:12 -0400
In-Reply-To: <1249481741-14008-13-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

ext Tomi Valkeinen wrote:
> - Generic panel
> - Samsung LTE430WQ-F0C LCD Panel
> - Sharp LS037V7DW01 LCD Panel
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  drivers/video/omap2/displays/Kconfig               |   18 +++
>  drivers/video/omap2/displays/Makefile              |    3 +
>  drivers/video/omap2/displays/panel-generic.c       |  104 +++++++++++++
>  .../omap2/displays/panel-samsung-lte430wq-f0c.c    |  113 +++++++++++++++
>  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |  153 ++++++++++++++++++++
>  5 files changed, 391 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/panel-generic.c
>  create mode 100644 drivers/video/omap2/displays/panel-samsung-lte430wq-f0c.c
>  create mode 100644 drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> 
This does not apply on linux-omap tree.

I get,

Applying: OMAP: DSS2: Add panel drivers
error: drivers/video/omap2/displays/Kconfig: does not exist in index
error: drivers/video/omap2/displays/Makefile: does not exist in index
Patch failed at 0011.

probably missing the 'new file node' attribute here too.

-roger
