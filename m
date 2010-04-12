From: Viral Mehta <Viral.Mehta@lntinfotech.com>
Subject: RE: [PATCH] omap: Add I2C bus 1 initialisation
Date: Mon, 12 Apr 2010 11:20:56 +0530
Message-ID: <70376CA23424B34D86F1C7DE6B9973430254343A6B@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <1271046704-10444-1-git-send-email-viral.mehta@lntinfotech.com>,<20100412045512.GA27459@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail96.messagelabs.com ([216.82.254.19]:22408 "EHLO
	mail96.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab0DLFxx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 01:53:53 -0400
In-Reply-To: <20100412045512.GA27459@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

>On Mon, Apr 12, 2010 at 06:31:44AM +0200, ext viral.mehta@lntinfotech.com wrote:
>> static int __init omap2430_i2c_init(void)
>> {
>>-       omap_register_i2c_bus(1, 400, NULL, 0);
>>+       omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
>>+                       ARRAY_SIZE(sdp2430_i2c1_boardinfo));

>why do you decrease bus frequency ?

1. This works for me.
2. I took refernce from http://linux.omap.com/pub/kernel/2430sdp/source/linux-2.6.14-omap2-v3.tgz
It uses same clock rate, this kernel is again fully working on OMAP2430 sdp board.
3. setting bus0 speed to 100 is Standard Mode and 400 is Fast Mode, may be working on fast mode is requiring some another changes which I am not aware of.
4. Sorry, dont have access to all HW manuals so that I can clearly point out about clk rate/bus speed data and settings.

--
Viral

______________________________________________________________________

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
