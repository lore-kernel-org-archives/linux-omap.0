From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: [Zoom3] smsc911x_soft_reset: Failed to complete reset (sometimes...)
Date: Mon, 9 Aug 2010 15:36:11 -0500
Message-ID: <A24693684029E5489D1D202277BE894456EA309A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34695 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755604Ab0HIUgO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 16:36:14 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o79KaDB3002405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 Aug 2010 15:36:13 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o79KaD4X004919
	for <linux-omap@vger.kernel.org>; Mon, 9 Aug 2010 15:36:13 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o79KaD3U015838
	for <linux-omap@vger.kernel.org>; Mon, 9 Aug 2010 15:36:13 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

Seems that, with current master branch
(commit ID: 842849896627701e4c07441f2c7519aeec771058),
and doing this change:

> diff --git a/drivers/net/smsc911x.h b/drivers/net/smsc911x.h
> index 016360c..2cd4f5a 100644
> --- a/drivers/net/smsc911x.h
> +++ b/drivers/net/smsc911x.h
> @@ -23,7 +23,7 @@
>  
>  #define TX_FIFO_LOW_THRESHOLD  ((u32)1600)
>  #define SMSC911X_EEPROM_SIZE   ((u32)7)
> -#define USE_DEBUG              0
> +#define USE_DEBUG              1
>  
>  /* This is the maximum number of packets to be received every
>   * NAPI poll */

I see in the console sometimes (not always) these error messages:

[    2.682342] eth0: smsc911x_soft_reset: Failed to complete reset
[    2.688385] eth0: smsc911x_open: soft reset failed
[    2.693176] IP-Config: Failed to open eth0
[    2.697326] IP-Config: No network devices available.

Is somebody also experiencing this?

NOTE: It doesn't seem consistent. I had to reboot several times the board,
To reproduce it. Sometimes it comes at the first try.

Regards,
Sergio
