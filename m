From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2] OMAP: DSS2: OMAPFB: Add null pointer check
Date: Tue, 16 Nov 2010 15:36:41 +0200
Message-ID: <1289914601.2668.97.camel@tubuntu>
References: <1289908147-12468-1-git-send-email-samreen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:28961 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab0KPOR0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 09:17:26 -0500
In-Reply-To: <1289908147-12468-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Samreen <samreen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tue, 2010-11-16 at 12:49 +0100, ext Samreen wrote:
> A null pointer check added. And using kstrdup()
> instead of kmalloc() & strcpy()
> 
> Signed-off-by: Samreen <samreen@ti.com>
> ---
> Version2:
>    - Using kstrdup() instead of kmalloc() & strcpy()
>    - Using ENOMEM as error code instead of EINVAL
>    - Subject changed appropriately
> 
> The link to v1 of patch is:
> https://patchwork.kernel.org/patch/319642/

Thanks, applied.

 Tomi


