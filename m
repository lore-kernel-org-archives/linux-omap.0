From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RESUBMIT PATCH] ARM: OMAP2+: am33xx: Add low level debugging
 support
Date: Tue, 29 May 2012 06:12:59 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA39248@DBDE01.ent.ti.com>
References: <1336639981-27194-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57598 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab2E2GNG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 May 2012 02:13:06 -0400
In-Reply-To: <1336639981-27194-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

On Thu, May 10, 2012 at 14:23:01, Hiremath, Vaibhav wrote:
> From: Afzal Mohammed <afzal@ti.com>
> 
> Add support for low level debugging on AM335X EVM (AM33XX family).
> Currently only support for UART1 console, which is used on AM335X EVM
> is added.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> This patch had been Reviewed and accepted earlier, but got
> missed during last merge window. Resubmitting again, without
> code-change.
> 
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   17 ++++++++++++++++-
>  arch/arm/plat-omap/include/plat/serial.h       |    4 ++++
>  arch/arm/plat-omap/include/plat/uncompress.h   |    6 ++++++
>  3 files changed, 26 insertions(+), 1 deletions(-)
> 

Tony,

Can this be merged now???

Thanks,
Vaibhav
