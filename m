From: "Yuri Jaeger Monti" <yurijm@gmail.com>
Subject: OMAP5912 OSK AIC23 Module Problem
Date: Wed, 16 Jul 2008 16:37:25 -0300
Message-ID: <65e025470807161237t74dc6bd0h1b659640e52485c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:2633 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbYGPTh1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 15:37:27 -0400
Received: by qw-out-2122.google.com with SMTP id 3so373420qwe.37
        for <linux-omap@vger.kernel.org>; Wed, 16 Jul 2008 12:37:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello

I'm currently working with OSK OMAP5912 platform and I'm trying to
load the AIC23 module like this:
  root@OSK $ modprobe snd-omap-alsa-aic23

But the system hangs and I can't load the module.
lsmod gives me:

Module                  Size  Used by
snd                    53940  0
soundcore               6724  1 snd

And I'm working with 2.6.26-rc8-omap Kernel version.

I'm trying to setup ALSA correctly to decode and play a MP3 file, but
I can't get the audio system to work.

When trying mpg123 I got this:

root@OSK $ mpg123 01-Test.mp3
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layers 1, 2 and 3
	version 0.66; written and copyright by Michael Hipp and others
	free software (LGPL/GPL) without any warranty but with best wishes
ALSA lib confmisc.c:768:(parse_card) cannot find card '0'
ALSA lib conf.c:3510:(_snd_config_evaluate) function
snd_func_card_driver returned error: No such device
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3510:(_snd_config_evaluate) function snd_func_concat
returned error: No such device
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:3510:(_snd_config_evaluate) function snd_func_refer
returned error: No such device
ALSA lib conf.c:3982:(snd_config_expand) Evaluate error: No such device
ALSA lib pcm.c:2145:(snd_pcm_open_noupdate) Unknown PCM default
audio_open(): cannot open device default
audio: No such file or directory

Playing MPEG stream 1 of 1: 01-test.mp3 ...
Title:   Test Artist: None
Comment:                                 Album: None
Year:    None                            Genre:  None
MPEG 1.0 layer III, 192 kbits/s, 44100 Hz stereo
[audio.c:269] error: Unable to set up output device! Constraints:
44100, 22050 or 11025Hz.

Audio device: <none>
Audio capabilities:
(matrix of [S]tereo or [M]ono support for sample format and rate in Hz)
        |  s16  |  u16  |  u8   |  s8   | ulaw  | alaw  |
 --------------------------------------------------------
  8000  |       |       |       |       |       |       |
 11025  |       |       |       |       |       |       |
 12000  |       |       |       |       |       |       |
 16000  |       |       |       |       |       |       |
 22050  |       |       |       |       |       |       |
 24000  |       |       |       |       |       |       |
 32000  |       |       |       |       |       |       |
 44100  |       |       |       |       |       |       |
 48000  |       |       |       |       |       |       |


Anyone know what I could do? Or have any info about the problem?

Thanks for the attention.

-- 
Yuri Jaeger Monti

The Catholic University at Porto Alegre - PUCRS
(51) 3320.3500 Ramal #7696
