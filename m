From: "=?GB2312?B?1cK93A==?=" <zhj8407@gmail.com>
Subject: What is the purpose of function omap_get_config()
Date: Wed, 5 Nov 2008 20:30:53 +0800
Message-ID: <4bd972300811050430t151f582aq33a687e428a8355f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:42946 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYKEMay (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 07:30:54 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3920944rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 05 Nov 2008 04:30:53 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

   I am porting a lcd panel to OMAP2430. It didn't enter the probe
entry of the omapfb. I found that it did not register the device in
fb.c located in arch/arm/plat-omap. Because the function
 omap_get_config( OMAP_TAG_LCD, struct omap_lcd_config )
 which is invoked before platform_device_register returns NULL.

So I wonder the purpose of omap_get_config and where it gets the
configuration. Can anybody tell me in detail? Thanks very much!

Jerry
