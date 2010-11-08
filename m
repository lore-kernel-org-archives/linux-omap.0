From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: Fix: Read correct bit in
 dispc_enable_alpha_blending()
Date: Mon, 08 Nov 2010 14:59:27 +0200
Message-ID: <1289221167.3297.58.camel@tubuntu>
References: <1289217381-601-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:33393 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751660Ab0KHM6V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 07:58:21 -0500
In-Reply-To: <1289217381-601-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-11-08 at 12:56 +0100, ext Archit Taneja wrote:
> Read correct DISPC_CONFIG bit when the channel is DIGIT, remove extra line
> at the end of the function.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>

Thanks, applied.

 Tomi


