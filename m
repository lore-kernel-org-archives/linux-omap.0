From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 04/10] OMAP4: DSS: HDMI: Move the common header file
Date: Thu, 01 Sep 2011 12:00:24 +0300
Message-ID: <1314867624.2169.21.camel@lappyti>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
	 <1314598500-24005-2-git-send-email-mythripk@ti.com>
	 <1314598500-24005-3-git-send-email-mythripk@ti.com>
	 <1314598500-24005-4-git-send-email-mythripk@ti.com>
	 <1314598500-24005-5-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53666 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932097Ab1IAJAa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 05:00:30 -0400
Received: by bkbzs2 with SMTP id zs2so2491490bkb.39
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 02:00:27 -0700 (PDT)
In-Reply-To: <1314598500-24005-5-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> Some of the header file definitions of HDMI IP are needed by audio driver thus
> moving the common defintion to more generic Include/video.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/dss.h  |   10 -----
>  drivers/video/omap2/dss/hdmi.c |    1 +
>  drivers/video/omap2/dss/hdmi.h |   53 ------------------------
>  include/video/omaphdmi.h       |   86 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+), 63 deletions(-)
>  create mode 100644 include/video/omaphdmi.h

As the functions will be renamed to hdmi_ti_4xxx_*, perhaps the header
file is a bit misnamed.

Also, please first do the changes/renamings/etc, and only then move the
finished header file to include/video/ to prevent unnecessary changes in
include/video.

 Tomi


