From: Romeo Enrico Alessio <romeo@korg.it>
Subject: I2C Driver support for I2C_M_RECV_LEN
Date: Tue, 16 Feb 2010 11:07:19 +0100
Message-ID: <4B7A6E57.4010307@korg.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhost3.fastnet.it ([195.96.193.34]:34275 "EHLO
	linuxhost3.fastnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520Ab0BPKOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 05:14:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
To implement the communication between a Omap3530 configured as master 
and a custom device configured as slave, I need to be able to configure 
the size of readings dynamically according to the first byte sent by the 
slave.
Checking kernel I found that in include/linux/i2c.h is declared the 
I2C_M_RECV_LEN flag for the "struct i2c_msg" which should be what I'm 
looking for. But I have not found an implementation of this 
functionality in the Omap I2c driver.
Can anyone confirm that?

Best Regards
Enrico
