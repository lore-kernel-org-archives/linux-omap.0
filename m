From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: ALSA and TWL4030 in full duplex mode
Date: Wed, 3 Oct 2007 06:43:51 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701E3976D@dlee13.ent.ti.com>
References: <1678610a0710011506o7d7a8effp61cad3c09e2d89d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1678610a0710011506o7d7a8effp61cad3c09e2d89d5@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Filipe Braz <ferlipaz@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

>It works fine in half-duplex mode but not in full duplex mode. I tried =
this
>with the following ti kernels:

Yes, the full duplex in ALSA on TWL4030 is tested / Validated.

Generally we do,
# arecord -f cd -d 10 filename_rec.wav | aplay filename.wav

>
>I also notice that the there is an additional driver: the OMAP2430DASF.
>This
>driver seems to use a message queue but its unclear on how it is =
supposed
>to
>work and if it supports full duplex mode. When attempting to play sound
>using it, it blocks the application and eventually fails with write =
error.
This was some kind of hacked approach that we used to play around with =
DSP side rendering of Audio of audio data. We don't have to use this.

Regards,
Khasim
