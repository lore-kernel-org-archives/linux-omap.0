From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 2/2] USB: TWL6025 allow different regulator name
Date: Mon, 23 May 2011 06:51:05 +0800
Message-ID: <20110522225103.GB15882@opensource.wolfsonmicro.com>
References: <1306095684-7732-1-git-send-email-gg@slimlogic.co.uk>
 <1306095684-7732-3-git-send-email-gg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36402 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755900Ab1EVWvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 May 2011 18:51:09 -0400
Content-Disposition: inline
In-Reply-To: <1306095684-7732-3-git-send-email-gg@slimlogic.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, lrg@slimlogic.co.uk, lrg@ti.com, linux@slimlogic.co.uk, balajitk@ti.com

On Sun, May 22, 2011 at 09:21:24PM +0100, Graeme Gregory wrote:
> The twl6025 uses a different regulator for USB than the 6030 so select
> the correct regulator name depending on the subclass of device.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
