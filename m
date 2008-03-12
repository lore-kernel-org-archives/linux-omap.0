From: David Brownell <david-b@pacbell.net>
Subject: isp1301 build breakage
Date: Wed, 12 Mar 2008 03:28:44 -0800
Message-ID: <200803120428.45006.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:37882 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751167AbYCLL2s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2008 07:28:48 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

  CC      drivers/i2c/chips/isp1301_omap.o
drivers/i2c/chips/isp1301_omap.c: In function 'isp1301_set_peripheral':
drivers/i2c/chips/isp1301_omap.c:1360: error: implicit declaration of function 'machine_is_omap_h2'
drivers/i2c/chips/isp1301_omap.c:1360: error: implicit declaration of function 'machine_is_omap_h3'
make[3]: *** [drivers/i2c/chips/isp1301_omap.o] Error 1
make[2]: *** [drivers/i2c/chips] Error 2
make[1]: *** [drivers/i2c] Error 2

This is on an H4 config, if that matters at all.

