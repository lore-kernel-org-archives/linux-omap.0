From: Oleg Kechin <okechin.omap@gmail.com>
Subject: OMAP5910 I2C problem
Date: Wed, 12 Mar 2008 17:12:17 +0200
Message-ID: <47D7F2D1.9040007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:55283 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYCLPML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 11:12:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so8339980mue.5
        for <linux-omap@vger.kernel.org>; Wed, 12 Mar 2008 08:12:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi!

I've experienced problem with OMAP5910 I2C driver in my custom board.
It freezes after some working time.
When it freezes, register I2C_STAT show that XUDF (or ROVR) bit is set 
and SCL pin
is in low state.
I2C_CNT register is not zero too, but buf_len counter is zero.
Attempt to use init() function do not help in this situation.
Only things I can do with it - set I2C to debug mode and make some SCL 
clocks by hand.
After this I2C state machine can work for some time.
When I2C clock is set to 100kHz it happens almost in every transfer - I 
try to read/write
EEPROM. In 20kHz it still can happen too (on heavy load much frequently).
It's look like internal I2C state machine is broken.
So, for now I replace i2c algorithm with i2c_algo_bit and everything 
works fine.

I'm curious - only I have such a problem with I2C bus in OMAP 5910 or 
someone else too?
May be there is better solution?


With regards
Oleg Kechin.

