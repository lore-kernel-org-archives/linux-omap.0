From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 01/12] OMAPFB: remove use of extended edid block
Date: Wed, 31 Oct 2012 11:40:21 +0530
Message-ID: <5090C0CD.7070104@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39908 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194Ab2JaGKi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 02:10:38 -0400
In-Reply-To: <1351613409-21186-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

On Tuesday 30 October 2012 09:39 PM, Tomi Valkeinen wrote:
> It seems that using the second EDID block causes more problems than is
> of any help. The first mode in the extended block will get
> FB_MODE_IS_FIRST set, which will override the first mode from the first
> EDID block, thus making the default videomode selection not to work
> properly.
>
> This patch removes the use of the extended edid block for now.

Looks like you had posted this one(and also the next one)in the previous 
cleanup/fixes series also.

Archit

