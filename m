From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: Problem with ALSA in 2.6.14-omap2 on OSK
Date: Wed, 23 Nov 2005 10:36:06 -0600
Message-ID: <520AB2AD990DC04082102F77CA17263801D40597@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: Dirk Behme <dirk.behme@de.bosch.com>, linux-omap-open-source@linux.omap.com
Cc: Yves Godin <Yves.Godin@lyrtech.com>
List-Id: linux-omap@vger.kernel.org

Couple of things regarding the usage of dma as far as audio goes:
If the system is loaded(such as using codecs such as madplay - still not
too loaded compared to running with a video decoder (arm side)+ a couple
of other high load apps) and only one single dma channel is used to
transmit/receive, the overhead incurred in re-filling the channel can
cause glitches in high sampling rate. This is one of the reasons why I
moved across to double dma channel ping pong styled handling in oss.

There is further the fix to L/R sync issue as reported by Ajaya Babu in
a previous mail in this list for the OSS - it might hit the ALSA too if
the condition is not met properly.=20

Regards,
Nishanth Menon
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Dirk Behme
> Sent: Wednesday, November 23, 2005 10:10 AM
> To: linux-omap-open-source@linux.omap.com
> Cc: Yves Godin
> Subject: Re: Problem with ALSA in 2.6.14-omap2 on OSK
>=20
> Yves Godin wrote:
> > 	It seems that something has change in the driver for the DMA in
> > 2.6.14-omap2.
> >
> > When I play a pure tone (ALSA driver), I ear some glitches in the
audio
> > every 5-10 secconds. Everithing was correct with 2.6.14-rc1.
> >
> > From what I can see with a scope on the serial data sent to the
codec,
> > it seems that some samples (a complete buffer??) are repeated from
time
> > to time. It's easier to ear it when playing a pure tone (ex 1Khz).
> >
> > Note that my alsa driver is slightly modified to play 24 bits audio
> > samples instead of 16 bits (DMA is configured in 32 bits).
> >
> > The files from the alsa driver have not changed between 2.6.14-rc1
and
> > 2.6.14-omap2. So I supposed the changes have been made to the OMAP
dma
> > drivers.
>=20
> On 2.6.15-rc2-omap1 on OSK I can reproduce this using madplay and mp3.
> All 5-10 seconds a short part is repeated.
>=20
> Any news or ideas about this?
>=20
> Thanks
>=20
> Dirk
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
