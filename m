From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [REPOST][PATCH 0/3] ARM: OMAP: Add command line option for I2C bus speed
Date: Sun,  8 Feb 2009 19:32:46 +0200
Message-ID: <1234114369-11399-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:5284 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbZBHRak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2009 12:30:40 -0500
Received: by nf-out-0910.google.com with SMTP id d3so238261nfc.21
        for <linux-omap@vger.kernel.org>; Sun, 08 Feb 2009 09:30:38 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi

I'm reposting this patch[set] adding command line option for I2C bus speed.
First version was

http://marc.info/?l=linux-omap&m=123289314421984&w=2

With this set, the option name is now i2c_bus instead of i2c_rate and this
version allow to register busses from command line as well. Idea of the set
is mostly for EVM boards where bus speed may depend on use case and extra
components connected into it.

With this it should be possible to revert one Dirk Behme's patch 

commit bae4b6a716ccf3247a1991d3c20b5e58ddd52890
Author: Dirk Behme <dirk.behme@gmail.com>
Date:   Tue Aug 5 14:09:15 2008 +0300

    ARM: OMAP3: Make I2C bus 2 configurable for BeagleBoard
 

This is tested only with unmodified Beagle so I'm interested to hear if one
has e.g. a Beagle with extra I2C devices connected into second I2C bus and
those starts working just by adding "i2c_bus=2,100" on the kernel command line.


-- 
Jarkko
