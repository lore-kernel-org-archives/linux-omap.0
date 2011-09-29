From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: msub: error running host mode on 3.1.0rc4
Date: Thu, 29 Sep 2011 13:21:38 +0200
Message-ID: <4E8454C2.8060002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53002 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab1I2LVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Sep 2011 07:21:41 -0400
Received: by eya28 with SMTP id 28so295685eya.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Sep 2011 04:21:40 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

We have a board similar to the beagleboard C3, but we have forced musb 
to host-mode and added an "smsc95xx" and an RJ45 connector instead. In 
2.6.39 I configured the musb driver to operate in host-mode, and that 
was all that was needed to make it work.

In 3.1.0rc4 that option has been removed from the Kconfig, and the 
default configuration of the musb driver is otg-mode. In my boardfile I 
changed the musb_board_data to:

static struct omap_musb_board_data musb_board_data = {
         .interface_type     = MUSB_INTERFACE_ULPI,
         .mode           = MUSB_HOST,
         .power          = 100,
}

That gives me the following output in dmesg:

[    0.120544] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[    0.120697] omap_device: musb-omap2430.-1: new worst case activate 
latency 0: 30517
[    0.120727] musb-hdrc musb-hdrc: musb_init_controller failed with 
status -19
[    0.120758] (NULL device *): gadget not registered.

Reading drivers/usb/musb/omap2430.c, it seems the problem is that no 
transceiver is configured, but I'm not sure if its a configuration 
problem or a bug.

Tasslehoff
