From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv4 0/6] omap3: Various fixes and improvements for IGEP v2 board.
Date: Tue,  5 Oct 2010 16:15:16 +0200
Message-ID: <1286288122-16834-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57932 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab0JEOPc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 10:15:32 -0400
Received: by wyb28 with SMTP id 28so6055516wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 07:15:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hello,

This is the version 4 of patch series to fix and improve the IGEP v2 board support.

Thanks for all your comments.

CHANGES
 - since v3:
   - [3/6] fix igep2_get_revision function
   - [3/6] fix typo - Unknow
   - [5/6] check for return value omap_register_i2c_bus 
 - since v2:
   - [1/6] check the result value of gpio_request and gpio_direction_*
   - [2/6] align the igep2_gpio_leds with tabs.
   - cc linux-arm-kernel

Kind regards,

 Enric
