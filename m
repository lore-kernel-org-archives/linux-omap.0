From: James <angweiyang@gmail.com>
Subject: Parallel CMOS Image Sensor with UART Control Interface
Date: Tue, 26 Jul 2011 09:24:49 +0800
Message-ID: <CAOy7-nNUrq_zFH5GaZ8r-0ozjkmhd7X1f12QbSfbOjm7GOr8AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34963 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab1GZBYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jul 2011 21:24:50 -0400
Received: by vxh35 with SMTP id 35so3292533vxh.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 18:24:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear all,

Does anyone came across a v4l2 Linux Device Driver for an Image Sensor
that uses Parallel CMOS H/V and can only be control by UART interface
instead of the common I2C or SPI interface?

A similar sensor is the STMicroelectronics VL5510 Image Sensor
although it support all 3 types of control interface.
(http://www.st.com/internet/automotive/product/178477.jsp)

Most or all the drivers found I found under drivers/media/video uses
the I2C or SPI interface instead

I'm new to writing driver and need a reference v4l2 driver for this
type of image sensor to work with OMAP3530 ISP port on Gumstix's Overo
board.

I just need a very simple v4l2 driver that can extract the image from
the sensor and control over it via the UART control interface.

Any help is very much appreciated.

Thanks in adv.

--
Regards,
James

-- 
Regards,
James
