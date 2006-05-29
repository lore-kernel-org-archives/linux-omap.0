From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: Playing mp3 on OMAP5912 OSK
Date: Sun, 28 May 2006 20:04:15 -0500
Message-ID: <772F5D89C5E0734B8A86D85DFC6A202403743F45@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

 It's still the madplay, but has worked so far for me.
Try the script there,

 http://oskfordummies.hp.infoseek.co.jp/howto/madplay.html=20

 If they doesn't work, try the following file system (which I *think*=20
includes the madplay) AFAIK, it worked with the 2.6.11 OSS driver.

 http://oskfordummies.hp.infoseek.co.jp/download.html

> # file test.mp3
> test.mp3: MPEG ADTS, layer III, v1, 192 kBits, 44.1 kHz, Stereo

 Unlike desktop PCs, the OSK's Audio driver does not necessary=20
support all the sampling frequencies. Please try 48kHz mp3, instead.

 Regards,
 Ishigami

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Dirk
Behme
Sent: Saturday, May 27, 2006 3:56 PM
To: Linux-omap-open-source@linux.omap.com
Subject: Playing mp3 on OMAP5912 OSK

Hi,

okay, I give up fighting with my madplay playing mp3 on OSK ;(

After months I tried again my madplay on recent git and=20
again get

output: ioctl(SNDCTL_DSP_SYNC): Invalid argument

Can anybody give me a link to a nice, little, prebuild, easy=20
to use mp3 player for ALSA on OSK? Something like my=20
madplay, but working ;)

Many thanks

Dirk

For reference, my configuration:

# madplay -V
MPEG Audio Decoder 0.15.1 (beta)
   Copyright (C) 2000-2004 Underbit Technologies, Inc.
   Build options: NDEBUG FPM_ARM ASO_IMDCT ASO_INTERLEAVE1=20
OPT_SPEED OPT_SSO

ID3 Tag Library 0.15.1 (beta)
   Copyright (C) 2000-2004 Underbit Technologies, Inc.
   Build options: NDEBUG

madplay 0.15.2 (beta)
   Copyright (C) 2000-2004 Robert Leslie
   Build options: NDEBUG AUDIO_DEFAULT=3Daudio_oss ENABLE_NLS

`madplay --license' for license and warranty information.

# file test.mp3
test.mp3: MPEG ADTS, layer III, v1, 192 kBits, 44.1 kHz, Stereo
# lsmod | grep aic
snd_omap_alsa_aic23 15900 0 - Live 0xbf0b4000
snd_pcm 77576 2 snd_pcm_oss,snd_omap_alsa_aic23, Live 0xbf0a0000
snd 45012 4=20
snd_pcm_oss,snd_omap_alsa_aic23,snd_pcm,snd_timer, Live=20
0xbf08a000
# madplay test.mp3
MPEG Audio Decoder 0.15.2 (beta) - Copyright (C) 2000-2004=20
Robert Leslie et al.
           Title: test
          Artist: test
           Album: test
           Track: 8
           Genre: Blues
output: ioctl(SNDCTL_DSP_SYNC): Invalid argument
#




_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
