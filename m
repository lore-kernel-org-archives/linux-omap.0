From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] omap: 3630: update is_chip variable
Date: Mon, 19 Oct 2009 17:17:54 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B318E7E@dlee02.ent.ti.com>
References: <1255989491-27088-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33154 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756265AbZJSWRt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 18:17:49 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9JMHrdW010622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2009 17:17:53 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9JMHrI2025847
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2009 17:17:53 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9JMHrZl024643
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2009 17:17:53 -0500 (CDT)
In-Reply-To: <1255989491-27088-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Monday, October 19, 2009 4:58 PM

> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-
> omap/include/mach/cpu.h
> index 7cb0556..05a0a33 100644
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -454,6 +454,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define CHIP_IS_OMAP3430ES2          (1 << 4)
>  #define CHIP_IS_OMAP3430ES3_0                (1 << 5)
>  #define CHIP_IS_OMAP3430ES3_1                (1 << 6)

Should we add a little space for 3430 to grow? Current TRM already defines a 3.1.2. For this version changes are transparent to software.  IIRC mostly internal cell tweaks to allow for expanded operating range.

The CONTROL.CONTROL_IDCODE value is 0x0B6D 602F for OMAP34xx ES1.0.
The CONTROL.CONTROL_IDCODE value is 0x1B7A E02F for OMAP34xx ES2.0.
The CONTROL.CONTROL_IDCODE value is 0x2B7A E02F for OMAP34xx ES2.1.
The CONTROL.CONTROL_IDCODE value is 0x3B7A E02F for OMAP34xx ES3.0.
The CONTROL.CONTROL_IDCODE value is 0x4B7A E02F for OMAP34xx ES3.1.
The CONTROL.CONTROL_IDCODE value is 0x7B7A E02F for OMAP34xx ES3.1.2.

> +#define CHIP_IS_OMAP3630ES1          (1 << 7)

Its hard to guess how many more will come.  Ideally it will be 3630 which is growing from this point on.  It is faster/smaller/cheaper along with some bug fixes.

Regards,
Richard W.

