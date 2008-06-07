From: Ram <vshrirama@gmail.com>
Subject: I2c issues with omap3430
Date: Sat, 7 Jun 2008 18:48:33 +0530
Message-ID: <8bf247760806070618u206abd52w9fc37b2f97b1c295@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:11594 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500AbYFGNSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Jun 2008 09:18:34 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1112915waf.23
        for <linux-omap@vger.kernel.org>; Sat, 07 Jun 2008 06:18:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

 Hi,
    I am facing some i2c issues on omap3 evm with linux 2.6.22 kernel.

    My device is sitting on I2C2.

    I am observing the following,
     1) Sometimes i get "i2c_omap.2: controller timed out" when i try
to do write or read.

     2) Sometimes the i2c write and read succeeds but data recieved is 0's/junk.

     3) On probing the i2c-2 signals i observed that only 2 clock
pulses on the clock line
         and only start condition on the data line is observed when i
try to do my first
         i2c write to the device.

     4) During read i am observing streams of clock pulses, But the
data read is junk or only 0's.

     5) I have also obseved that  i2c write returns success even when
the device is
         removed. i2c read returns success with data received being zero's.

      I am not sure what could be the problem. The mux settings seems okay and
      i2c-2 iclk and i2c-2 fclk is enabled. my clock speed is 400khz,
i tried running
      at lower speeds (100khz) i get "i2c_omap.2: XRDY IRQ while nodata to send"
      messages.

     Am i missing something?

     Please advice,

Regards,
sriram
