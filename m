From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH V2] OMAP: DSS2: don't power off a panel twice
Date: Tue, 17 Aug 2010 13:34:11 +0300
Message-ID: <1282041251.2348.24.camel@tubuntu.research.nokia.com>
References: <1281496753-17471-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:19892 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757176Ab0HQKeS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 06:34:18 -0400
In-Reply-To: <1281496753-17471-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Stanley.Miao" <stanley.miao@windriver.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lwalkera@ieee.org" <lwalkera@ieee.org>, "lwalkera@gmail.com" <lwalkera@gmail.com>

Hi,

On Wed, 2010-08-11 at 05:19 +0200, ext Stanley.Miao wrote:
> If we blank the panel by
> echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
> 
> Then, we reboot the sytem, the kernel will crash at
> drivers/video/omap2/dss/core.c:323
> 
> This is because the panel is closed twice. Now check the state of a dssdev
> to forbid a panel is power on or power off twice.

Otherwise this looks fine, except that panel-taal.c does not need
modifications, as it already handles this case.

Also, at some point I (or somebody else =) should think how to do proper
locking for the panel drivers. Currently it's rather broken, and, for
example, enabling and disabling a panel at the same time will cause
problems. Except for panel-taal, which uses its own lock.

 Tomi


