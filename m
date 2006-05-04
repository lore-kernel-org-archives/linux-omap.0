From: "Minjie Lin" <MLin@EmpowerTechnologies.com>
Subject: RE: Strange work of OSK5912 audio driver
Date: Thu, 4 May 2006 11:29:33 -0600
Message-ID: <1A1CA1A4CD7D304485214EBCCAEE0A0105BFED@BBSC-EX01.bbsconnect.ca>
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
To: Sergey Vointsev <vointsev@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Sergey,

The method is used for basic test sound driver whether it works and
cannot be used for test this play speed problem. It is correct only
recording for 2.5 second with dd bs=3D48k count=3D5 <  /dev/dsp > =
sample.au
at sample rate 48khz and stereo mode. If you want to testing sound
correctly, please use a wave player or write a wavw play program. As to
ringin.wav, it is a wav file of sample rate 11khz which the sound driver
and aic23 codec doesn't support.

Regards,

Minjie Lin

 =20

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Sergey Vointsev
Sent: May 4, 2006 1:04 AM
To: Linux-omap-open-source@linux.omap.com
Subject: Strange work of OSK5912 audio driver

Hi everyone!
I'm using OSK5912 with linux 2.6.16 +patch-2.6.16-omap2 I follow
http://oskfordummies.hp.infoseek.co.jp/howto/audio.html while trying to
configure audio driver.

It's written there that following commands should record 5 seconds from
mic and play it.
dd bs=3D48k count=3D5 <  /dev/dsp > sample.au cp sample.au /dev/dsp

But when I try to execute this commands I get strange results - speech
is recorded, but only first ~2-2.5sec and played only ~1.5- 2sec

Also when I try to do "cp notify.wav /dev/dsp" the sound plays almost
OK.
But when I do "cp ringin.wav /dev/dsp" I get about a second of noise
instead of sound. Both these files are standard Windows sounds, if you
want to check it yourself.

What's wrong? Did I miss some configuration? Please advise.
Thanks. Sergey,


--
Also available for instant messaging via Google Talk.
Need invite to Gmail? I have one for you! Just ask.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
