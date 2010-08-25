From: "Henk Geraads" <linux@hf-electronics.com>
Subject: gpmc_cs_request behaviour
Date: Wed, 25 Aug 2010 09:05:52 +0200
Message-ID: <NGBBLNEOGLJIIJKLFLPFOEPHFCAA.linux@hf-electronics.com>
References: <NGBBLNEOGLJIIJKLFLPFOEECFCAA.linux@hf-electronics.com>
Reply-To: <linux@hf-electronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay56.tele2.vuurwerk.nl ([62.250.3.56]:51555 "EHLO
	relay.versatel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752129Ab0HYHGB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 03:06:01 -0400
Received: from [87.213.192.4] (helo=hf-electronics.com)
	by relay.versatel.net with smtp (Exim 4.69)
	(envelope-from <linux@hf-electronics.com>)
	id 1OoA3a-0006n9-0W
	for linux-omap@vger.kernel.org; Wed, 25 Aug 2010 09:05:58 +0200
In-Reply-To: <NGBBLNEOGLJIIJKLFLPFOEECFCAA.linux@hf-electronics.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jos Aerts <jos.aerts@hf-electronics.com>

Hi,

I am new on kernel module programming for a OMAP2. I want to access a external device through nCS3 of an OMAP3530. I expect that the function "gpmc_cs_request" enables you the access to that memoryregion and that the variable "cs_mem_base" is set to the memory starting point of the requested nCSx.

But in my case the variable has the value of the requested memory size (SZ_16M).

What do I wrong?

Henk 


snipped of the code:

  if (register_chrdev(MYDEV_MAJOR,"Device",&mydev_fops))
  {
    printk("\rFiFo: Failed to get major %d\n\r", MYDEV_MAJOR);
    return -EIO;
  }

  if (gpmc_cs_request(3, SZ_16M, &cs_mem_base) < 0) {
	printk("CM-T35: Failed request CS3 for GPMC mem for Device\n");
	return -ENODEV;
  }
  printk("\rMemory Address: %lx\n\r",cs_mem_base);

