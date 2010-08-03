From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITFORVSYNC
Date: Tue, 03 Aug 2010 15:02:24 +0300
Message-ID: <1280836944.3436.135.camel@tubuntu.research.nokia.com>
References: <1278104096-27809-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:35041 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab0HCMC1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 08:02:27 -0400
In-Reply-To: <1278104096-27809-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vaibhav Hiremath <hvaibhav@ti.com>

On Fri, 2010-07-02 at 22:54 +0200, ext Grazvydas Ignotas wrote:
> FBIO_WAITFORVSYNC is a stardard ioctl for waiting vsync, already
> used by some userspace, so add it as an alias for OMAPFB_WAITFORVSYNC.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> Tomi,
> 
> I know I already sent this earlier, but as now FBIO_WAITFORVSYNC is a
> standard ioctl, so why don't we support it? I know you might not like
> that omapfb_ioctl will have one standard ioctl handler between all OMAP
> specific ones, but that's something plenty of other drivers do.

One could ask that if FBIO_WAITFORSYNC is a standard ioctl, why do we
need to handle it in omapfb's custom ioctl function =).

But I think this is fine, I'll apply.

 Tomi


