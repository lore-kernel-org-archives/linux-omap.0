From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [PATCH] ARM: OMAP3: Update BeagleBoard defconfig
Date: Wed, 6 Aug 2008 07:37:25 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00208C1571C@dbde02.ent.ti.com>
References: <48989EC0.4020806@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41426 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745AbYHFCas convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 22:30:48 -0400
In-Reply-To: <48989EC0.4020806@googlemail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Acked-by: Syed Mohammed Khasim <khasim@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Dirk
> Behme
> Sent: Wednesday, August 06, 2008 12:11 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] ARM: OMAP3: Update BeagleBoard defconfig
>
> From: Dirk Behme <dirk.behme@gmail.com>
>
> Update BeagleBoard defconfig:
>
> - Use MPU timer instead of 32k timer to work around serial hang issue
> - Disable CONFIG_DEBUG_LL
>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
