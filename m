From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Playing mp3 on OMAP5912 OSK
Date: Sat, 27 May 2006 08:56:28 +0200
Message-ID: <4477F81C.2000308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

okay, I give up fighting with my madplay playing mp3 on OSK ;(

After months I tried again my madplay on recent git and 
again get

output: ioctl(SNDCTL_DSP_SYNC): Invalid argument

Can anybody give me a link to a nice, little, prebuild, easy 
to use mp3 player for ALSA on OSK? Something like my 
madplay, but working ;)

Many thanks

Dirk

For reference, my configuration:

# madplay -V
MPEG Audio Decoder 0.15.1 (beta)
   Copyright (C) 2000-2004 Underbit Technologies, Inc.
   Build options: NDEBUG FPM_ARM ASO_IMDCT ASO_INTERLEAVE1 
OPT_SPEED OPT_SSO

ID3 Tag Library 0.15.1 (beta)
   Copyright (C) 2000-2004 Underbit Technologies, Inc.
   Build options: NDEBUG

madplay 0.15.2 (beta)
   Copyright (C) 2000-2004 Robert Leslie
   Build options: NDEBUG AUDIO_DEFAULT=audio_oss ENABLE_NLS

`madplay --license' for license and warranty information.

# file test.mp3
test.mp3: MPEG ADTS, layer III, v1, 192 kBits, 44.1 kHz, Stereo
# lsmod | grep aic
snd_omap_alsa_aic23 15900 0 - Live 0xbf0b4000
snd_pcm 77576 2 snd_pcm_oss,snd_omap_alsa_aic23, Live 0xbf0a0000
snd 45012 4 
snd_pcm_oss,snd_omap_alsa_aic23,snd_pcm,snd_timer, Live 
0xbf08a000
# madplay test.mp3
MPEG Audio Decoder 0.15.2 (beta) - Copyright (C) 2000-2004 
Robert Leslie et al.
           Title: test
          Artist: test
           Album: test
           Track: 8
           Genre: Blues
output: ioctl(SNDCTL_DSP_SYNC): Invalid argument
#
