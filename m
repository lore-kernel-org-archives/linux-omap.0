From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 0/1] ARM: OMAP3: Revert "Make I2C bus 2 configurable for BeagleBoard"
Date: Sun, 22 Feb 2009 18:42:46 +0200
Message-ID: <1235320967-5614-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:58787 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbZBVQjq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 11:39:46 -0500
Received: by nf-out-0910.google.com with SMTP id d21so353385nfb.21
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2009 08:39:45 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi

This Dirk's patch is not needed anymore since Tony pushed my RFC patches
for command line option "i2c_bus=bus_id,clkrate" in.

Note this revert removes also worth OMAP I2C help text change so would
you Dirk like to bring it back by sending it to linux-i2c list?

I tested this by hooking older I2C eeprom X24C16P into second I2C bus of
Beagle, adding platform data and i2c_register_board_info for it and by
defining "i2c_bus=2,100" command line option. Surprisingly I was able
to read that EEPROM even it is rated for 2.7-5.5 V while Beagle I2C2
is in 1.8 V IO (and from what domain I powered the X24C16P) :-)


-- 
Jarkko 
