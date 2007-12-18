From: "Carl Benson" <Carl.Benson@combra.se>
Subject: RE: ALSA driver for audio codec on TWL4030
Date: Tue, 18 Dec 2007 16:40:22 +0100
Message-ID: <D0D7E940253EF8428A27241F8E3CABA3A88E11@zeus.Combra.se>
References: <376191c90712131052p359b9927ic31671ed8b4de0f8@mail.gmail.com><7EAD1AEEA7621C45899FE99123E124A001453D3B@dbde01.ent.ti.com>
	<D0D7E940253EF8428A27241F8E3CABA3A88E0E@zeus.Combra.se>
	<7EAD1AEEA7621C45899FE99123E124A0014BD43C@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks Khasim, it worked with native OSS support compiled. I was running =
ALSA with OSS emulation.
=20
best regards!
/carl

________________________________

From: Syed Mohammed, Khasim [mailto:khasim@ti.com]
Sent: Tue 12/18/2007 4:08 PM
To: Carl Benson; linux-omap-open-source@linux.omap.com
Subject: RE: ALSA driver for audio codec on TWL4030





> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Carl Benson
> Sent: Tuesday, December 18, 2007 7:24 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: RE: ALSA driver for audio codec on TWL4030
>
> Hi. I downloaded the newly available 2.6.22.1 kernel for OMAP3430 and
> testet on an 3430SDP ES1.0 board. No problem booting, however when I =
try
> to play audio, it sounds corrupted and as if only every half sample is
> played (without increased pitch, the whole audio sample is played back
> really fast and finished in half its real playing time). I am using
> madplay as an MP3 decoder together with OSS emulation. Anyone else who
> experienced any problems? Any suggestion on how I might debug it?
>
I actually tried OSS today and didn't find any issues on OMAP3430 ES2.0. =
Can you try the same? Disable ALSA and enable OSS.

#
# Open Sound System
#
CONFIG_SOUND_PRIME=3Dy
# CONFIG_OSS_OBSOLETE is not set
CONFIG_SOUND_OMAP=3Dy
CONFIG_SOUND_OMAP_TWL4030=3Dy
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set

Regards,
Khasim
