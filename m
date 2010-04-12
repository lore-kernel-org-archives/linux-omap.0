From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] omap: Add I2C bus 1 initialisation
Date: Mon, 12 Apr 2010 07:55:12 +0300
Message-ID: <20100412045512.GA27459@nokia.com>
References: <1271046704-10444-1-git-send-email-viral.mehta@lntinfotech.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32551 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab0DLEzq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 00:55:46 -0400
Content-Disposition: inline
In-Reply-To: <1271046704-10444-1-git-send-email-viral.mehta@lntinfotech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext viral.mehta@lntinfotech.com" <viral.mehta@lntinfotech.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Mon, Apr 12, 2010 at 06:31:44AM +0200, ext viral.mehta@lntinfotech.com wrote:
> static int __init omap2430_i2c_init(void)
> {
>-       omap_register_i2c_bus(1, 400, NULL, 0);
>+       omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
>+                       ARRAY_SIZE(sdp2430_i2c1_boardinfo));

why do you decrease bus frequency ?

-- 
balbi
