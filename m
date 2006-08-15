From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: quick test OMAP ALSA driver on H2
Date: Tue, 15 Aug 2006 14:39:42 -0500
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA6041C311A@dlee05.ent.ti.com>
References: <44E21266.2090901@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <44E21266.2090901@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Anderson Briglia <anderson.briglia@indt.org.br>, David Cohen <david.cohen@indt.org.br>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Anderson and David,

I did successfully cross built alsa library first. The lib already
exists.=20

I just googled alsa user mailing list archive. The same question was
asked and no answer was provided. Then googling alsa dev mailing list
gave me the solution. I have aplay crossed compiled by the following
command:

CC=3Darm_v5t_le-gcc ./configure --target=3Darm-linux =
--host=3Di686-pc-linux
--with-alsa-prefix=3D~/alsa/alsa-lib-1.0.11/src/.libs/
--with-alsa-inc-prefix=3D~/alsa/alsa-lib-1.0.11/include/ =20

But "aplay -l" gives the following error:
root@128.247.79.144:/# ./aplay -l
**** List of PLAYBACK Hardware Devices ****
ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
aplay: device_list:231: control open (0): No such file or directory
root@128.247.79.144:/# cat /proc/asound/devices
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer=20

The kernel boot log does show H2 TSC2101 is initialized:
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
13:55:50
2006 UTC).
audio support initialized
ALSA device list:
  #0: H2 TSC2101

Do I miss something? (BTW, I have the exact same device nodes as yours).
I noticed GIT has alsa 1.0.12rc2 while my user library is 1.0.11. Can
this be the problem? (I don't think it is)

Would you please send me your working libasound.so and aplay in a direct
email?

Regards,
Jian

-----Original Message-----
From: Anderson Briglia [mailto:anderson.briglia@indt.org.br]=20
Sent: Tuesday, August 15, 2006 1:29 PM
To: Zhang, Jian
Cc: ext Daniel Petrini; OMAP-Linux
Subject: Re: quick test OMAP ALSA driver on H2

Hi Jian,

ext Zhang, Jian wrote:
> Anderson and Daniel,
>=20
> First of all, I appreciate your info. I completely ignored ALSA utils.
> The ALSA web site did talk about directly cating a file to a PCM
device
> node. I thought that would be a quick & dirty check. Can you tell me
the
> devices under /dev/snd/?

Yes, sure:

root@arm:~# ls -la /dev/snd
crw-rw----   1 root audio 116,  0 Dec 31  1969 controlC0
crw-rw----   1 root audio 116, 24 Dec 31  1969 pcmC0D0c
crw-rw----   1 root audio 116, 16 Dec 31  1969 pcmC0D0p
crw-rw----   1 root audio 116, 33 Dec 31  1969 timer

>=20
> Just downloaded alsa 1.0.11 utils and tried to cross compile it. The
> following command doesn't seem to pass the right lib location. Any
idea
> what's going wrong?
>=20
> $ CC=3Darm_v5t_le-gcc ./configure --target=3Darm-linux
--host=3Di686-pc-linux
> --prefix=3D~/alsa/alsa-lib-1.0.11/
>=20
> ....
> checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
> checking for libasound headers version >=3D 1.0.9... not present.
> configure: error: Sufficiently new version of libasound not found.  =20
>=20

I did not cross-compile the alsa-utils, I just donwloaded the package
from the default
Debian arm repository and installed into my root filesystem. But I
believe the packages
for ARM platform are not available anymore, I don't know why.
This configuring problem seems that you have to download the libasound
headers. Maybe you
can find it at ALSA official project's page.

Regards,

Anderson Briglia
