From: Daniel Mack <daniel@zonque.org>
Subject: Re: AM335x USB DMA seems broken on ISOC URBs
Date: Mon, 20 Jan 2014 12:15:40 +0100
Message-ID: <52DD055C.1090806@zonque.org>
References: <20131222055945.GA7194@localhost> <20140117162723.GB3843@localhost> <52DA99D8.8010003@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:36359 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbaATLPn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jan 2014 06:15:43 -0500
In-Reply-To: <52DA99D8.8010003@zonque.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On 01/18/2014 04:12 PM, Daniel Mack wrote:
> On 01/17/2014 05:27 PM, Ezequiel Garcia wrote:
>> On Sun, Dec 22, 2013 at 02:59:45AM -0300, Ezequiel Garcia wrote:

>>> While doing some experiments with the stk1160 driver (for "Easycap" TV video
>>> capture devices), ran into problems using v3.13-rc4. The problem is that the
>>> stk1160 IRQ handler receives no URBs at all.

[...]

> Let me know if you find anything - I hope to find some time to do
> similar tests on AM33xx based hardware.

I tried using an USB headset connected to a AM33xx based board, using
kernel v3.13.

The good news is that aplay gives me sound, so there's nothing generally
wrong with isochronous streams on musb_dsps/cppi41.

I can also do some simple 'arecord | aplay' loopback, and I can hear the
microphone signal, but the stream breaks down after a couple of seconds,
showing the following error:

[  433.671757] ALSA sound/core/pcm_lib.c:1945 capture write error (DMA
or IRQ trouble?)

Also, when tearing down the aplay stream, the cppi41 driver spits a
number of the warnings below.

Sebastian, do you have any pending patches that might be worth testing?



Thanks,
Daniel



[  340.255651] ------------[ cut here ]------------
[  340.262828] WARNING: CPU: 0 PID: 112 at drivers/dma/cppi41.c:605
cppi41_dma_control+0x2a8/0x2d4()
[  340.272086] Modules linked in:
[  340.287140] CPU: 0 PID: 112 Comm: aplay Tainted: G        W
3.13.0-00051-gff62d1c #1661
[  340.295798] [<c00137b8>] (unwind_backtrace+0x0/0xf4) from
[<c001158c>] (show_stack+0x10/0x14)
[  340.304712] [<c001158c>] (show_stack+0x10/0x14) from [<c0037154>]
(warn_slowpath_common+0x6c/0x84)
[  340.314070] [<c0037154>] (warn_slowpath_common+0x6c/0x84) from
[<c0037208>] (warn_slowpath_null+0x1c/0x24)
[  340.324153] [<c0037208>] (warn_slowpath_null+0x1c/0x24) from
[<c02b50d8>] (cppi41_dma_control+0x2a8/0x2d4)
[  340.334255] [<c02b50d8>] (cppi41_dma_control+0x2a8/0x2d4) from
[<c0375f0c>] (cppi41_dma_channel_abort+0xcc/0)
[  340.344976] [<c0375f0c>] (cppi41_dma_channel_abort+0xcc/0x140) from
[<c037187c>] (musb_cleanup_urb.isra.16+0)
[  340.356147] [<c037187c>] (musb_cleanup_urb.isra.16+0x58/0x11c) from
[<c0371b80>] (musb_urb_dequeue+0xe8/0x12)
[  340.366595] [<c0371b80>] (musb_urb_dequeue+0xe8/0x128) from
[<c035aa74>] (unlink1+0x2c/0x110)
[  340.375497] [<c035aa74>] (unlink1+0x2c/0x110) from [<c035b2e0>]
(usb_hcd_unlink_urb+0x50/0xc4)
[  340.384496] [<c035b2e0>] (usb_hcd_unlink_urb+0x50/0xc4) from
[<c03db53c>] (deactivate_urbs+0xd8/0xf4)
[  340.394126] [<c03db53c>] (deactivate_urbs+0xd8/0xf4) from
[<c03dc614>] (snd_usb_endpoint_stop+0x30/0x70)
[  340.404032] [<c03dc614>] (snd_usb_endpoint_stop+0x30/0x70) from
[<c03e3d40>] (stop_endpoints+0x70/0x88)
[  340.413843] [<c03e3d40>] (stop_endpoints+0x70/0x88) from [<c03e3ea0>]
(snd_usb_substream_playback_trigger+0x)
[  340.424836] [<c03e3ea0>]
(snd_usb_substream_playback_trigger+0x9c/0xb8) from [<c03cdb40>]
(snd_pcm_do_stop+0)
[  340.435917] [<c03cdb40>] (snd_pcm_do_stop+0x54/0x58) from
[<c03cd768>] (snd_pcm_action_single+0x38/0x78)
[  340.445816] [<c03cd768>] (snd_pcm_action_single+0x38/0x78) from
[<c03cd970>] (snd_pcm_drop+0x6c/0xc4)
[  340.455443] [<c03cd970>] (snd_pcm_drop+0x6c/0xc4) from [<c03cf22c>]
(snd_pcm_common_ioctl1+0xc90/0x109c)
[  340.465344] [<c03cf22c>] (snd_pcm_common_ioctl1+0xc90/0x109c) from
[<c03cf7f0>] (snd_pcm_playback_ioctl1+0x1)
[  340.476434] [<c03cf7f0>] (snd_pcm_playback_ioctl1+0x1b8/0x4b0) from
[<c00e7a60>] (do_vfs_ioctl+0x3fc/0x5f0)
[  340.486607] [<c00e7a60>] (do_vfs_ioctl+0x3fc/0x5f0) from [<c00e7cc4>]
(SyS_ioctl+0x70/0x80)
[  340.495331] [<c00e7cc4>] (SyS_ioctl+0x70/0x80) from [<c000e340>]
(ret_fast_syscall+0x0/0x48)
[  340.504136] ---[ end trace 521a83c0d2567bbb ]---


