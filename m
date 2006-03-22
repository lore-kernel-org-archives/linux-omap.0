From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: ALSA with OSK
Date: Wed, 22 Mar 2006 01:01:37 -0600
Message-ID: <3D54759CE5A8F64BB2078090E91D50A208ADC0@dlee08.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

 During the OSS days, I think I had similar error on certain=20
sampling rate, while other rates were just OK. =20

 It might be interesting to try other sampling rates if you=20
have the MP3 encoder handy.

 Regards,
 Ishigami

-----Original Message-----
From: Behalf Of Dirk Behme
Sent: Wednesday, March 22, 2006 3:53 PM
To: lamikr@cc.jyu.fi; linux-omap-open-source@linux.omap.com
Subject: Re: ALSA with OSK

lamikr wrote:
>>output: ioctl(SNDCTL_DSP_SYNC): Invalid argument
>
> How about if you try to play wav with aplay? Or by applying 3 alsa
> patches send to list 2 weeks ago?

Thanks! Does aplay play mp3? I applied the patches, but no=20
difference:

# madplay /mnt/nfs/foo.mp3
MPEG Audio Decoder 0.15.2 (beta) - Copyright (C) 2000-2004=20
Robert Leslie et al.
          Title: Foo
          Artist: Foo
           Album: Various - New Project
           Track: 1
           Genre: Blues
output: ioctl(SNDCTL_DSP_SYNC): Invalid argument
# lsmod | grep snd
snd_pcm_oss 47136 0 - Live 0xbf0ba000
snd_mixer_oss 14752 1 snd_pcm_oss, Live 0xbf0b5000
snd_omap_alsa_aic23 15804 0 - Live 0xbf0b0000
snd_pcm 79240 2 snd_pcm_oss,snd_omap_alsa_aic23, Live 0xbf09b000
snd_timer 21796 1 snd_pcm, Live 0xbf094000
snd_page_alloc 6312 1 snd_pcm, Live 0xbf091000
snd 45592 5=20
snd_pcm_oss,snd_mixer_oss,snd_omap_alsa_aic23,snd_pcm,snd_timer,=20
Live 0xbf084000
soundcore 8196 1 snd, Live 0xbf080000
#

Any other working mp3 player?

Best regards

Dirk

BTW: Any plans to apply the pending patches?
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
