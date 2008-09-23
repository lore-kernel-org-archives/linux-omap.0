From: "Arun KS" <getarunks@gmail.com>
Subject: NULL pointer dereference when using ALSA SOC
Date: Tue, 23 Sep 2008 11:56:00 +0530
Message-ID: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:34803 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbYIWG0B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 02:26:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2026100rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2008 23:26:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I am writing an ASOC driver for tlvaic23 on osk5912 platform.
When do an aplay, I m getting a  NULL pointer dereference. I added
some debug prints in the soc/core/pcm_native.c, also in codec and
platform drivers. The null pointer is comming in IOCTL SNDRV_PCM_IOCTL_SYNC_PTR.
Log is pasted below.


Advanced Linux Sound Architecture Driver Version 1.0.17.
ASoC version 0.13.2
AIC23 Audio Codec 0.1
omap_pcm_new
omap_pcm_preallocate_dma_buffer
omap_pcm_preallocate_dma_buffer
asoc: aic23 <-> omap-mcbsp-dai mapping ok
ALSA device list:
  #0: 5912OSK (aic23)
TCP cubic registered
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Disabling unused clock "usb_dc_ck"...  done
FIXME: Clock "tc2_ck" seems unused
Disabling unused clock "tc1_ck"...  done
Skipping reset check for DSP domain clock "dsptim_ck"
Skipping reset check for DSP domain clock "dspper_ck"
eth0: link up
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.13.162
IP-Config: Complete:
     device=eth0, addr=192.168.13.162, mask=255.255.255.0, gw=192.168.13.1,
     host=192.168.13.162, domain=, nis-domain=(none),
     bootserver=0.0.0.0, rootserver=192.168.13.65, rootpath=
Looking up port of RPC 100003/2 on 192.168.13.65
Looking up port of RPC 100005/1 on 192.168.13.65
VFS: Mounted root (nfs filesystem).
Freeing init memory: 128K
mount: Mounting none on /tmp failed: Invalid argument
mkdir: Cannot create directory `/var/log': File exists
mkdir: Cannot create directory `/var/lock': File exists

Please press Enter to activate this console.
sh-3.00#
sh-3.00#
sh-3.00# aplay root/song_48000.wav
omap_mcbsp_dai_startup
omap_pcm_open
SNDRV_PCM_IOCTL_INFO snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_PVERSION snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_SYNC_PTR snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_INFO snd_pcm_common_ioctl1 substream c1cf5000
Playing WAVE 'root/song_48000.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Stereo
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_REFINE snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_HW_PARAMS snd_pcm_common_ioctl1 substream c1cf5000
omap_mcbsp_dai_set_dai_fmt
SETTINMG SAMPLE RATE 48000
omap_mcbsp_dai_hw_params
omap_pcm_hw_params
SNDRV_PCM_IOCTL_SYNC_PTR snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_SW_PARAMS snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_SYNC_PTR snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_PREPARE snd_pcm_common_ioctl1 substream c1cf5000
omap_pcm_prepare
SNDRV_PCM_IOCTL_SYNC_PTR snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_SW_PARAMS snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_SYNC_PTR snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_SYNC_PTR snd_pcm_common_ioctl1 substream c1cf5000
SNDRV_PCM_IOCTL_SYNC_PTR snd_pcm_common_ioctl1 substream c1cf5000
omap_pcm_trigger
omap_mcbsp_dai_trigger 1
SNDRV_PCM_IOCTL_SYNC_PTR snd_pcm_common_ioctl1 substream 00000000
Unable to handle kernel NULL pointer dereference at virtual address 00000070
pgd = c1df0000
[00000070] *pgd=11e04031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.27-rc6-omap1-04956-g0c096db-dirty #118)
PC is at snd_pcm_sync_ptr+0x24/0x158
LR is at snd_pcm_common_ioctl1+0xc08/0x1084
pc : [<c01a3618>]    lr : [<c01a4d6c>]    psr: 60000013
sp : c1de5d40  ip : c1de5df0  fp : c1de5dec
r10: c1de5d40  r9 : c1de4000  r8 : 00000000
r7 : 00000004  r6 : c1dea000  r5 : 00029e88  r4 : 00029e88
r3 : 00000000  r2 : 60000013  r1 : 00000084  r0 : c1de5d40
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 11df0000  DAC: 00000015
Process aplay (pid: 850, stack limit = 0xc1de4260)
Stack: (0xc1de5d40 to 0xc1de6000)
5d40: c1de5d54 c02c0ac0 c0043710 60000013 ffffffff 60000013 00000006 c1de5df0
5d60: c02c0ac0 c1de5d78 c02c0ac0 c0043710 60000013 ffffffff a0000013 00000004
5d80: 00000000 c1de5da4 c1de5d94 c00475a8 c003f76c c02c2840 c1de5dc4 c1de5da8
5da0: c002804c 00029e88 00000000 c1dea000 00000004 00000000 c1de4000 400dc3c8
5dc0: c1de5ddc 00029e88 00000000 c1dea000 00000004 00000000 c1de4000 400dc3c8
5de0: c1de5ef4 c1de5df0 c01a4d6c c01a3604 c005af04 c00325c0 21a73310 00000000
5e00: c1de5e3c c1de5e10 c019e6e8 c01a914c c1de6804 00000003 c1cf5000 c1de6800
5e20: 00000000 00004650 00001770 00000000 c1de5e58 c1de5e40 c01a1c50 c019e694
5e40: c02d0cb4 c1cf5000 00000003 c1de5e78 c1de5e5c c01a19fc c01a1c04 00000000
5e60: c1de6800 00001770 c1cf5000 c1de5e88 c1de5e7c c01a1a4c c01a19b4 c1de5e98
5e80: c1de5e8c c01a1c70 c01a1a30 c1de5ed8 c1de5e9c c01a8868 c01a1c64 00001770
5ea0: 00001770 00000000 0002a060 00001770 c1de6800 ffffffb3 bebed448 00000004
5ec0: c1cf5000 c1de4000 400dc3c8 c1dea000 ffffffe7 00029e88 00000004 00000000
5ee0: c1de4000 400dc3c8 c1de5f30 c1de5ef8 c01a5a78 c01a4174 c007aec8 0a05edaa
5f00: 00000006 c02d7c04 c1c67454 c1de5f3c c1dea000 ffffffe7 c0844123 00000004
5f20: c0028da4 c1de5f40 c1de5f34 c01a5ac0 c01a5654 c1de5f5c c1de5f44 c009a4b0
5f40: c01a5a9c c1dea000 00029e88 00000000 c1de5f84 c1de5f60 c009a77c c009a484
5f60: c005a198 00000000 c1dea000 fffffff7 c0844123 00000036 c1de5fa4 c1de5f88
5f80: c009a7dc c009a508 00000000 00029d28 00029d78 0002a060 00000000 c1de5fa8
5fa0: c0028c00 c009a7ac 00029d28 00029d78 00000004 c0844123 00029e88 00000000
5fc0: 00029d28 00029d78 0002a060 00011940 00000000 0001c824 400dc3c8 0001c834
5fe0: 400dc868 bebed434 4006b7a0 40285314 20000010 00000004 00000000 00000000
Backtrace:
[<c01a35f4>] (snd_pcm_sync_ptr+0x0/0x158) from [<c01a4d6c>]
(snd_pcm_common_ioctl1+0xc08/0x1084)
[<c01a4164>] (snd_pcm_common_ioctl1+0x0/0x1084) from [<c01a5a78>]
(snd_pcm_playback_ioctl1+0x434/0x448)
[<c01a5644>] (snd_pcm_playback_ioctl1+0x0/0x448) from [<c01a5ac0>]
(snd_pcm_playback_ioctl+0x34/0x40)
 r8:c0028da4 r7:00000004 r6:c0844123 r5:ffffffe7 r4:c1dea000
[<c01a5a8c>] (snd_pcm_playback_ioctl+0x0/0x40) from [<c009a4b0>]
(vfs_ioctl+0x3c/0x84)
[<c009a474>] (vfs_ioctl+0x0/0x84) from [<c009a77c>] (do_vfs_ioctl+0x284/0x2a4)
 r6:00000000 r5:00029e88 r4:c1dea000
[<c009a4f8>] (do_vfs_ioctl+0x0/0x2a4) from [<c009a7dc>] (sys_ioctl+0x40/0x5c)
 r7:00000036 r6:c0844123 r5:fffffff7 r4:c1dea000
[<c009a79c>] (sys_ioctl+0x0/0x5c) from [<c0028c00>] (ret_fast_syscall+0x0/0x2c)
 r6:0002a060 r5:00029d78 r4:00029d28
Code: e1a08000 e1a05001 e1a0000a e3a01084 (e5986070)
---[ end trace 28844c0db8440770 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 17 [#2]
Modules linked in:
CPU: 0    Tainted: G      D    (2.6.27-rc6-omap1-04956-g0c096db-dirty #118)
PC is at snd_pcm_release+0x1c/0x88
LR is at __fput+0xb0/0x158
pc : [<c01a3500>]    lr : [<c008fa74>]    psr: a0000013
sp : c1de5b10  ip : c1de5b34  fp : c1de5b30
r10: c181dd90  r9 : c1d06e80  r8 : 00000001
r7 : c1d5b0d0  r6 : c1c74000  r5 : 00000008  r4 : 00000000
r3 : c01a34e4  r2 : 00000000  r1 : c1dea000  r0 : ffffffff
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 11df0000  DAC: 00000015
Process aplay (pid: 850, stack limit = 0xc1de4260)
Stack: (0xc1de5b10 to 0xc1de6000)
5b00:                                     c181beb8 00000008 c1c74000 c1dea000
5b20: 00000001 c1de5b60 c1de5b34 c008fa74 c01a34f4 00000000 c1dea000 00000000
5b40: c1c74000 c1c74008 00000001 c1de5cf8 00000070 c1de5b70 c1de5b64 c008fb50
5b60: c008f9d4 c1de5b8c c1de5b74 c008dfd4 c008fb2c 00000001 c1c74000 00000004
5b80: c1de5bb0 c1de5b90 c0044500 c008df6c c1de4000 c1c58b80 0000000b c01a3618
5ba0: c1de5cf8 c1de5bc0 c1de5bb4 c0044570 c0044484 c1de5be0 c1de5bc4 c0044b18
5bc0: c0044558 c1de4000 00000001 c00427c8 c0042798 c1de5bf0 c1de5be4 c002cc14
5be0: c0044994 c1de5c10 c1de5bf4 c002e1fc c002c9d4 00010000 c1c58b80 c1df7444
5c00: c1dfac34 c1de5c4c c1de5c14 c002e4e0 c002e1a0 c1c71400 00000008 00000001
5c20: 00000017 ffffffff c02bc838 00000017 c1de5cf8 00000070 60000013 c1de5d40
5c40: c1de5cf4 c1de5c50 c00281a8 c002e2f0 c1de5c5c c01bcfd4 c01bcc3c c02e80b8
5c60: c02dc940 00000040 00000000 c02e80ac c02c0af4 c1de5cb4 c1de5c84 c01bd0a8
5c80: c01bcee4 00000128 ffff72c9 00000001 c02dc940 0000000a c02dc900 00000000
5ca0: c02dc944 0000000a c1de5cd4 c1de5cb8 c0047330 c00471e0 c1de4000 0000000e
5cc0: c02e0d8c 00000000 c1de5ce8 c1de5cd8 c00475a8 ffffffff c1de5d2c c1dea000
5ce0: 00000004 00000000 c1de5dec c1de5cf8 c00287e0 c002817c c1de5d40 00000084
5d00: 60000013 00000000 00029e88 00029e88 c1dea000 00000004 00000000 c1de4000
5d20: c1de5d40 c1de5dec c1de5df0 c1de5d40 c01a4d6c c01a3618 60000013 ffffffff
5d40: c1de5d54 c02c0ac0 c0043710 60000013 ffffffff 60000013 00000006 c1de5df0
5d60: c02c0ac0 c1de5d78 c02c0ac0 c0043710 60000013 ffffffff a0000013 00000004
5d80: 00000000 c1de5da4 c1de5d94 c00475a8 c003f76c c02c2840 c1de5dc4 c1de5da8
5da0: c002804c 00029e88 00000000 c1dea000 00000004 00000000 c1de4000 400dc3c8
5dc0: c1de5ddc 00029e88 00000000 c1dea000 00000004 00000000 c1de4000 400dc3c8
5de0: c1de5ef4 c1de5df0 c01a4d6c c01a3604 c005af04 c00325c0 21a73310 00000000
5e00: c1de5e3c c1de5e10 c019e6e8 c01a914c c1de6804 00000003 c1cf5000 c1de6800
5e20: 00000000 00004650 00001770 00000000 c1de5e58 c1de5e40 c01a1c50 c019e694
5e40: c02d0cb4 c1cf5000 00000003 c1de5e78 c1de5e5c c01a19fc c01a1c04 00000000
5e60: c1de6800 00001770 c1cf5000 c1de5e88 c1de5e7c c01a1a4c c01a19b4 c1de5e98
5e80: c1de5e8c c01a1c70 c01a1a30 c1de5ed8 c1de5e9c c01a8868 c01a1c64 00001770
5ea0: 00001770 00000000 0002a060 00001770 c1de6800 ffffffb3 bebed448 00000004
5ec0: c1cf5000 c1de4000 400dc3c8 c1dea000 ffffffe7 00029e88 00000004 00000000
5ee0: c1de4000 400dc3c8 c1de5f30 c1de5ef8 c01a5a78 c01a4174 c007aec8 0a05edaa
5f00: 00000006 c02d7c04 c1c67454 c1de5f3c c1dea000 ffffffe7 c0844123 00000004
5f20: c0028da4 c1de5f40 c1de5f34 c01a5ac0 c01a5654 c1de5f5c c1de5f44 c009a4b0
5f40: c01a5a9c c1dea000 00029e88 00000000 c1de5f84 c1de5f60 c009a77c c009a484
5f60: c005a198 00000000 c1dea000 fffffff7 c0844123 00000036 c1de5fa4 c1de5f88
5f80: c009a7dc c009a508 00000000 00029d28 00029d78 0002a060 00000000 c1de5fa8
5fa0: c0028c00 c009a7ac 00029d28 00029d78 00000004 c0844123 00029e88 00000000
5fc0: 00029d28 00029d78 0002a060 00011940 00000000 0001c824 400dc3c8 0001c834
5fe0: 400dc868 bebed434 4006b7a0 40285314 20000010 00000004 00000000 00000000
Backtrace:
[<c01a34e4>] (snd_pcm_release+0x0/0x88) from [<c008fa74>] (__fput+0xb0/0x158)
 r8:00000001 r7:c1dea000 r6:c1c74000 r5:00000008 r4:c181beb8
[<c008f9c4>] (__fput+0x0/0x158) from [<c008fb50>] (fput+0x34/0x38)
[<c008fb1c>] (fput+0x0/0x38) from [<c008dfd4>] (filp_close+0x78/0x84)
[<c008df5c>] (filp_close+0x0/0x84) from [<c0044500>]
(put_files_struct+0x8c/0xd4)
 r6:00000004 r5:c1c74000 r4:00000001
[<c0044474>] (put_files_struct+0x0/0xd4) from [<c0044570>]
(exit_files+0x28/0x2c)
 r8:c1de5cf8 r7:c01a3618 r6:0000000b r5:c1c58b80 r4:c1de4000
[<c0044548>] (exit_files+0x0/0x2c) from [<c0044b18>] (do_exit+0x194/0x6d8)
[<c0044984>] (do_exit+0x0/0x6d8) from [<c002cc14>] (die+0x250/0x298)
[<c002c9c4>] (die+0x0/0x298) from [<c002e1fc>] (__do_kernel_fault+0x6c/0x7c)
[<c002e190>] (__do_kernel_fault+0x0/0x7c) from [<c002e4e0>]
(do_page_fault+0x200/0x220)
 r7:c1dfac34 r6:c1df7444 r5:c1c58b80 r4:00010000
[<c002e2e0>] (do_page_fault+0x0/0x220) from [<c00281a8>]
(do_DataAbort+0x3c/0xa0)
[<c002816c>] (do_DataAbort+0x0/0xa0) from [<c00287e0>] (__dabt_svc+0x40/0x60)
Exception stack(0xc1de5cf8 to 0xc1de5d40)
5ce0:                                                       c1de5d40 00000084
5d00: 60000013 00000000 00029e88 00029e88 c1dea000 00000004 00000000 c1de4000
5d20: c1de5d40 c1de5dec c1de5df0 c1de5d40 c01a4d6c c01a3618 60000013 ffffffff
 r8:00000000 r7:00000004 r6:c1dea000 r5:c1de5d2c r4:ffffffff
[<c01a35f4>] (snd_pcm_sync_ptr+0x0/0x158) from [<c01a4d6c>]
(snd_pcm_common_ioctl1+0xc08/0x1084)
[<c01a4164>] (snd_pcm_common_ioctl1+0x0/0x1084) from [<c01a5a78>]
(snd_pcm_playback_ioctl1+0x434/0x448)
[<c01a5644>] (snd_pcm_playback_ioctl1+0x0/0x448) from [<c01a5ac0>]
(snd_pcm_playback_ioctl+0x34/0x40)
 r8:c0028da4 r7:00000004 r6:c0844123 r5:ffffffe7 r4:c1dea000
[<c01a5a8c>] (snd_pcm_playback_ioctl+0x0/0x40) from [<c009a4b0>]
(vfs_ioctl+0x3c/0x84)
[<c009a474>] (vfs_ioctl+0x0/0x84) from [<c009a77c>] (do_vfs_ioctl+0x284/0x2a4)
 r6:00000000 r5:00029e88 r4:c1dea000
[<c009a4f8>] (do_vfs_ioctl+0x0/0x2a4) from [<c009a7dc>] (sys_ioctl+0x40/0x5c)
 r7:00000036 r6:c0844123 r5:fffffff7 r4:c1dea000
[<c009a79c>] (sys_ioctl+0x0/0x5c) from [<c0028c00>] (ret_fast_syscall+0x0/0x2c)
 r6:0002a060 r5:00029d78 r4:00029d28
Code: e5917068 e3a02000 e5974000 e3e00000 (e5945000)
---[ end trace 28844c0db8440770 ]---
Fixing recursive fault but reboot is needed!

Regards,
Arun
