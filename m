From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/5] OMAP: DSS2: Add support for NV12 format
Date: Thu, 19 May 2011 09:51:58 +0300
Message-ID: <1305787918.1849.40.camel@deskari>
References: <1305783090-21214-1-git-send-email-amber@ti.com>
	 <1305783090-21214-6-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:46529 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754845Ab1ESGwJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 02:52:09 -0400
Received: by eye13 with SMTP id 13so1051708eye.17
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 23:52:01 -0700 (PDT)
In-Reply-To: <1305783090-21214-6-git-send-email-amber@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amber Jain <amber@ti.com>
Cc: linux-omap@vger.kernel.org, molnar@ti.com

On Thu, 2011-05-19 at 11:01 +0530, Amber Jain wrote:
> Adds the support for NV12 color format.
> Added basic scaling support for the UV-plane in case of NV12 format.

This is the most complex part of the patch set, do you feel the lines
above explain what the patch is about? What about this patch affecting
the old YUV modes? The scaler being enabled always for YUV modes on
OMAP4? Any other areas the patch could affect? Things like that should
be mentioned here.

 Tomi


