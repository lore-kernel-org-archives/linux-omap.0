From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
Date: Thu, 14 Jun 2012 14:33:26 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
References: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40768 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478Ab2FNOdf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 10:33:35 -0400
In-Reply-To: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 11, 2012 at 18:52:54, Hiremath, Vaibhav wrote:
> As omap1 and omap2 will never be compiled together, due to
> different compiler flags, so we can simply make
> cpu_class_is_omap2() = true, for all non-omap1 platforms.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/cpu.h |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 

Tony,

Ping???

Thanks,
Vaibhav

