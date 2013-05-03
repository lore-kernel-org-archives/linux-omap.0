From: Jason Zhu <jzhu@acuti.com>
Subject: Questions on Slimbus on OMAP4460 PandaboardES
Date: Fri, 03 May 2013 18:22:25 +0800
Message-ID: <51838FE1.5080407@acuti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:48014 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761957Ab3ECK0v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 May 2013 06:26:51 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so146825pad.36
        for <linux-omap@vger.kernel.org>; Fri, 03 May 2013 03:26:50 -0700 (PDT)
Received: from [192.168.1.101] ([210.76.108.115])
        by mx.google.com with ESMTPSA id zo4sm9501894pbc.21.2013.05.03.03.26.48
        for <linux-omap@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 03:26:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Guys,

I am interesting on Slimbus interface on my pandaboardES, which has 
OMAP4460 processor. I followed resource from web to boot up my board and 
I connect two fly wires to connect to slimbus1 interface. (Disconnect 
R7/R6 on WiLink modules). It is slimbus1 clk and data.

I modified my u-boot pin mux, MCBSP1_CLKX and MCBSP1_DR. That gives 
slimbus function on power up.
And I put u-boot, x-loader and 3.9.0 kernel (www.kernel.org) on it. I 
noted lots of hwmod and clock patch on include in 3.9-rc6 version. (Tony 
Lindgren made this tag)

As I am new guy to run this linux driver. I have some questions on 
slimbus integration.

1. 'omap44xx_slimbus1_hwmod' can be a initialize function for slimbus? I 
compare 4460 TRM on slimbus programming guide, Page 5176. It is almost 
same, but I just confused on PRCM initialization. How to enable 
ABE_24M_FCLK?

2. I find slimbus driver on http://lwn.net/Articles/454945/ . This 
driver seems for Qualcomm BB processor. How do I make entry from this 
driver to hwmod? I find init and slimbus_dev struct. But I could not 
make connection between hwmod and this driver.

3. From all information, I saw TI was not intend customer to use SLIMBUS 
on OMAP. So is it a deep hole for me to run slimbus on pandaboard. Or is 
it someone successful connect slimbus to external peripherals?

Thanks

Jason



