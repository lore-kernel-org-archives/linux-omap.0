From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 0/6] OMAP: DSS: porting old drivers to DSS2 (board
 files part)
Date: Mon, 19 Sep 2011 10:38:35 +0300
Message-ID: <1316417915.1978.52.camel@deskari>
References: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:37380 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751153Ab1ISHim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Sep 2011 03:38:42 -0400
Received: by bkbzt19 with SMTP id zt19so5820429bkb.23
        for <linux-omap@vger.kernel.org>; Mon, 19 Sep 2011 00:38:39 -0700 (PDT)
In-Reply-To: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: archit@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

Hi Tony, 

On Mon, 2011-09-12 at 14:20 +0300, Tomi Valkeinen wrote:
> This patch set ports all the OMAP2/3 boards, except N8x0, that use the old
> omapfb to use the newer DSS2 driver. Only board files are changed, the panel
> driver additions are done in separate patch set. Applying this set without the
> driver changes will obviously disable the displays of the affected boards until
> the drivers are also merged.
> 
> Some board files contained old omapfb code, but there wasn't a matching LCD
> driver. That board file code is also removed.

Any chances to get these in for the next merge window? These will remove
most of the OMAP2/3 users of the old omapfb, and when the old omapfb is
used only by OMAP1, we can remove quite a bit of code there.

 Tomi


