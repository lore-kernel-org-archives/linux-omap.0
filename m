From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 14/20] OMAPDSS: remove dssdev->channel assignments
Date: Mon, 11 Mar 2013 11:54:21 +0530
Message-ID: <513D7895.2030307@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-15-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40507 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab3CKGZE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 02:25:04 -0400
In-Reply-To: <1362743515-10152-15-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
> Now that the driver uses ooutput->recommended_channel, we can remove the

Typo above for 'output'. We could discard this patch if we don't add 
dssdev->channel assignments in patch # 10.

Archit
