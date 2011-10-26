From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: Re: msub: error running host mode on 3.1.0rc4
Date: Wed, 26 Oct 2011 20:18:27 +0200
Message-ID: <9F0AF703-F647-43E0-90EB-3711D9396458@gmail.com>
References: <4E8454C2.8060002@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49312 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932818Ab1JZSSe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Oct 2011 14:18:34 -0400
Received: by bkbzt19 with SMTP id zt19so1862254bkb.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Oct 2011 11:18:32 -0700 (PDT)
In-Reply-To: <4E8454C2.8060002@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


On Sep 29, 2011, at 1:21 PM, Tasslehoff Kjappfot wrote:

> We have a board similar to the beagleboard C3, but we have forced musb to host-mode and added an "smsc95xx" and an RJ45 connector instead. In 2.6.39 I configured the musb driver to operate in host-mode, and that was all that was needed to make it work.
> 
> In 3.1.0rc4 that option has been removed from the Kconfig, and the default configuration of the musb driver is otg-mode. In my boardfile I changed the musb_board_data to:
> 
> static struct omap_musb_board_data musb_board_data = {
>        .interface_type     = MUSB_INTERFACE_ULPI,
>        .mode           = MUSB_HOST,
>        .power          = 100,
> }
> 
> That gives me the following output in dmesg:
> 
> [    0.120544] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> [    0.120697] omap_device: musb-omap2430.-1: new worst case activate latency 0: 30517
> [    0.120727] musb-hdrc musb-hdrc: musb_init_controller failed with status -19
> [    0.120758] (NULL device *): gadget not registered.
> 
> Reading drivers/usb/musb/omap2430.c, it seems the problem is that no transceiver is configured, but I'm not sure if its a configuration problem or a bug.
> 
> Tasslehoff

Finally got around to looking at this a bit more. The issue is that no musb->isr is configured. omap2430.c doesn't set up an isr, so it should use the generic one. That one is, however, enclosed in the following #ifdef's:

#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430) ||                                                                                                    
defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500) ||
defined(CONFIG_ARCH_U5500)

None of these are set in my defconfig, but I see that CONFIG_SOC_OMAP3430 was set in the old one. Should this one be set for my 3530-board, or is there a missing condition here?

- Tasslehoff