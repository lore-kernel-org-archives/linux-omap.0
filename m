From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: Strange work of OSK5912 audio driver
Date: Thu, 4 May 2006 12:03:38 +0400
Message-ID: <9713be7f0605040103ya1463a1mb00b15f1645426e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi everyone!
I'm using OSK5912 with linux 2.6.16 +patch-2.6.16-omap2
I follow http://oskfordummies.hp.infoseek.co.jp/howto/audio.html while
trying to configure audio driver.

It's written there that following commands should record 5 seconds
from mic and play it.
dd bs=3D48k count=3D5 <  /dev/dsp > sample.au
cp sample.au /dev/dsp

But when I try to execute this commands I get strange results -=20
speech is recorded, but only first ~2-2.5sec and played only ~1.5-
2sec

Also when I try to do "cp notify.wav /dev/dsp" the sound plays almost OK.
But when I do "cp ringin.wav /dev/dsp" I get about a second of noise
instead of sound. Both these files are standard Windows sounds, if you
want to check it yourself.

What's wrong? Did I miss some configuration? Please advise.
Thanks. Sergey,


--
Also available for instant messaging via Google Talk.
Need invite to Gmail? I have one for you! Just ask.
