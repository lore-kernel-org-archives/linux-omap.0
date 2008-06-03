From: "mohammed shareef" <mdshareef@gmail.com>
Subject: audio on omap5912 osk
Date: Tue, 3 Jun 2008 15:40:13 +0530
Message-ID: <a1d91fa0806030310m4ae72de4qe2a66d3fd75486eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:31561 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbYFCKKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 06:10:15 -0400
Received: by ti-out-0910.google.com with SMTP id b6so495017tic.23
        for <linux-omap@vger.kernel.org>; Tue, 03 Jun 2008 03:10:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

Hi,

Am trying to run audio on my osk.

i followed the instructions given in the below link..

http://oskfordummies.hp.infoseek.co.jp/howto/audio.html

my .config file of the kernel looks like this (regarding audio..)

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set

#
# ALSA ARM devices
#
CONFIG_SND_OMAP_AIC23=m
# CONFIG_SND_OMAP_TSC2101 is not set
# CONFIG_SND_OMAP_TSC2102 is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_OSS_OBSOLETE_DRIVER is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set


i configured it fot aic23 codec on the osk..
thn i created the nodes..

# mknod /dev/mixer c 14 0
# mknod /dev/dsp c 14 3

but when i run the audio configuration file, the system doesnt respond at all..

i dont get back the prompt after i run this file..

could someone tell me whats wrong..

thank you,
regards,
Shareef
