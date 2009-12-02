From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] ARM: OMAP4: PM: Move DPLL control apis to dpll.c
Date: Wed, 2 Dec 2009 12:31:48 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BBF30E94@dbde02.ent.ti.com>
References: <1259670448-19840-1-git-send-email-rnayak@ti.com>
 <1259670448-19840-2-git-send-email-rnayak@ti.com>
 <1259670448-19840-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50532 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbZLBHBv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 02:01:51 -0500
In-Reply-To: <1259670448-19840-3-git-send-email-rnayak@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

<snip>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nayak, Rajendra
> Sent: Tuesday, December 01, 2009 5:57 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Nayak, Rajendra; Paul Walmsley; Cousson, Benoit
> Subject: [PATCH 3/5] ARM: OMAP4: PM: Move DPLL control apis to
> dpll.c
> 
> This patch moves all the dpll control api's to a
> common file dpll.c. This is in preperation of omap4
> support wherein most of these api's can be reused.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile    |    3 +-
>  arch/arm/mach-omap2/clock.h     |   13 +
>  arch/arm/mach-omap2/clock34xx.c |  511 ----------------------------
> ---------
>  arch/arm/mach-omap2/clock34xx.h |   11 -
>  arch/arm/mach-omap2/clock44xx.c |    8 +-
>  arch/arm/mach-omap2/clock44xx.h |    4 -
>  arch/arm/mach-omap2/dpll.c      |  539
> +++++++++++++++++++++++++++++++++++++++
>  7 files changed, 558 insertions(+), 531 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/dpll.c
> 

....

On OMAP4, we might need an additional API since different DPLL outputs 
Like M2, M3 , M4 etc have individual gating control ( Bit 8) apart form DPLL gating.

Regards,
Santosh
