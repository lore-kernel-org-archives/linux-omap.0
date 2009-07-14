From: Zach LeRoy <zleroy@rii.ricoh.com>
Subject: Problems configuring OMAP35x ISP driver
Date: Tue, 14 Jul 2009 09:49:18 -0700 (PDT)
Message-ID: <15157053.23861247590158808.JavaMail.root@mailx.crc.ricoh.com>
References: <17937063.23811247589353235.JavaMail.root@mailx.crc.ricoh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <17937063.23811247589353235.JavaMail.root@mailx.crc.ricoh.com>
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre Rodriguez, Sergio" <saaguirre@ti.com>
Cc: linux-media <linux-media@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Sergio,

I spoke with you earlier about using the ISP and omap34xxcam drivers with a micron mt9d111 SOC sensor.  I have since been able to take pictures, but the sensor data is not making it through the ISP data-path correctly.  I know the problem is in the ISP data-path because I am configuring the sensor the exact same way as I have been on my working PXA system.  I am expecting 4:2:2 packed YUV data, but all of the U and V data is no more than 2 bits where it should be 8.  I know the ISP has a lot of capabilities, but all I want to use it for is grabbing 8-bit data from my sensor and putting it in a buffer untouched using the CCDC interface (and of course clocking and timing).  What are the key steps to take to get this type of configuration?  

Other Questions:

Is there any processing done on YUV data in the ISP driver by default that I am missing?
Has any one else experienced similar problems while adding new sensor support?

Any help here would be greatly appreciated.

Thank you,

Zach LeRoy
