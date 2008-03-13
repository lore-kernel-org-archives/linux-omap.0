From: "Oleg Kechin" <okechin.omap@gmail.com>
Subject: OMAP5910 I2C problem
Date: Thu, 13 Mar 2008 20:17:48 +0200
Message-ID: <cb3afdb90803131117s3974e622n6a4f07d3ced132b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:15991 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbYCMSRx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 14:17:53 -0400
Received: by wr-out-0506.google.com with SMTP id 50so2608024wra.13
        for <linux-omap@vger.kernel.org>; Thu, 13 Mar 2008 11:17:50 -0700 (PDT)
Content-Disposition: inline
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
