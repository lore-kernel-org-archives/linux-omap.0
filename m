From: =?gb2312?B?TmluZ3pob25nIE1pYW8gLSDD58T+1tI=?= <Ningzhong.Miao@access-company.com>
Subject: Re: A problem about tsc2101 omap audio alsa driver on H3 board
Date: Fri, 27 Oct 2006 09:51:27 +0800
Message-ID: <A091501C5752EE42A2FD8880B8EF192F3F89B6@njgex02.njg.access-company.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: lamikr@cc.jyu.fi
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear lamikr:

	It's same. The below is printed messages. The program stopped and no =
sound in STEREO HEADSET.

[root@Linux /root]#alsa-lib/bin/amixer scontents
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Mono:
  Front Left: Playback 90 [90%] [on]
  Front Right: Playback 90 [90%] [on]
Simple mixer control 'Playback',0
  Capabilities: enum
  Items: 'Loudspeaker' 'Headphone'
  Item0: 'Headphone'
Simple mixer control 'Handset',2
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 21 [21%] [on]
Simple mixer control 'Headset',1
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 69 [69%] [on]
[root@Linux /root]#
[root@Linux /root]#
[root@Linux /root]#alsa-lib/bin/aplay microsoft.wav=20
MCLK already in use at 12000000 Hz. We change it to 12000000 Hz
omap_alsa_tsc2101_clock_on(), no need to change rate, no need to change =
clock rate, rate already 12000000 Hz.
Playing WAVE 'microsoft.wav' : Unsigned 8 bit, Rate 22050 Hz, Mono



-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: lamikr [mailto:lamikr@cc.jyu.fi]=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2006=C4=EA10=D4=C226=C8=D5 7:30
=CA=D5=BC=FE=C8=CB: Ningzhong Miao - =C3=E7=C4=FE=D6=D2
=B3=AD=CB=CD: linux-omap-open-source@linux.omap.com
=D6=F7=CC=E2: Re: A problem about tsc2101 omap audio alsa driver on H3 =
board


> The program died here, and earphone don=A1=AFt have any sound.
>
> I have tried oss audio driver and 2.6.17 kernel. They are same.
>  =20
Hmm, aplayer has newer crashed for me.
Could you first try to change the playback target from speaker (default)
to headphone by using alsa-mixer to check whether you can then hear
something? If crash still happens, could you try to remove debug,
change again the target to headphone with alsa-mixer and try again with
aplay.

Mika
