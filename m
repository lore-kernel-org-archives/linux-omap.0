From: "Li Weichen" <iaadoa@gmail.com>
Subject: RE: OSK5912 USB Port Problem
Date: Tue, 22 Nov 2005 21:40:40 +0800
Message-ID: <43831ff9.42d4ae2b.279a.7ed0@mx.gmail.com>
References: <42848A5C5A0D1E47B026E644DD49B08E683DA7@mail>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <42848A5C5A0D1E47B026E644DD49B08E683DA7@mail>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Yves Godin' <Yves.Godin@lyrtech.com>, 'xuxian' <lsfdxuxian@gmail.com>, 'Tony Lindgren' <tony@atomide.com>, 'Jose Manuel Cano Garcia' <jcgarcia@uma.es>
Cc: 'Linux OMAP Open Source' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Doesn't the OSK support OTG? =20

> -----Original Message-----
> From: Yves Godin [mailto:Yves.Godin@lyrtech.com]
> Sent: Tuesday, November 22, 2005 9:31 PM
> To: Li Weichen; xuxian; Tony Lindgren; Jose Manuel Cano Garcia
> Cc: Linux OMAP Open Source
> Subject: RE: OSK5912 USB Port Problem
>=20
> Hi,
> 	I did not follow all the thread but if I'm correct, when you enable
the
> Gadget support in the Kernel for the OSK, the USB can no longer be =
used as
a
> Master.
>=20
> Regards,
>=20
> -Yves
>=20
> -----Message d'origine-----
> De=A0: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-open-source-bounces@linux.omap.com] De la part de =
Li
> Weichen
> Envoy=E9=A0: Tuesday, November 22, 2005 3:15 AM
> =C0=A0: 'xuxian'; 'Tony Lindgren'; 'Jose Manuel Cano Garcia'
> Cc=A0: 'Linux OMAP Open Source'
> Objet=A0: RE: OSK5912 USB Port Problem
>=20
> Well I encounter another problem.  If I only enable the usb host =
support,
> the usb Flash disk works well with OSK.  But after I add the USB =
Gadget
> support, and enables the OTG, the Flash disk doesn't work.
>=20
> Is there anything wrong with OTG?
>=20
> > -----Original Message-----
> > From: =
linux-omap-open-source-bounces+iaadoa=3Dgmail.com@linux.omap.com
> > =
[mailto:linux-omap-open-source-bounces+iaadoa=3Dgmail.com@linux.omap.com]=

> On
> > Behalf Of xuxian
> > Sent: Tuesday, November 22, 2005 11:22 AM
> > To: 'Tony Lindgren'; 'Jose Manuel Cano Garcia'
> > Cc: 'Linux OMAP Open Source'
> > Subject: RE: OSK5912 USB Port Problem
> >
> > Hi Tony,
> >
> > The patch work. Now the OSK can detect the USB key automatically.
> > Thanks much.
> >
> > xuxian
> >
> > -----Original Message-----
> > From: =
linux-omap-open-source-bounces+lsfdxuxian=3Dgmail.com@linux.omap.com
> >
> =
[mailto:linux-omap-open-source-bounces+lsfdxuxian=3Dgmail.com@linux.omap.=
com
> > ]
> > On Behalf Of Tony Lindgren
> > Sent: Tuesday, November 22, 2005 1:49 AM
> > To: Jose Manuel Cano Garcia
> > Cc: Linux OMAP Open Source
> > Subject: Re: OSK5912 USB Port Problem
> >
> > * Jose Manuel Cano Garcia <jcgarcia@uma.es> [051121 02:14]:
> > > Hi,
> > >
> > > I had problems with an USB flash memory, too. I tried several
solutions
> > > and kernels which did not work until I recently read a post on the
Linux
> > > Omap mailing list regarding USB clock malfunction on kernels
> > > 2.6.12-2.6.14 (which were the ones I have tried). Then, I tried =
kernel
> > > 2.6.11 an it worked.
> >
> > I've noticed that having CONFIG_OMAP_RESET_CLOCKS on kills OHCI at =
least
> > on OSK. Juha's patch from few months ago probably helps with that as =
it
> > turns on dc_clk:
> >
> >
> =
http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004818=
.
> > ht
> > ml
> >
> > Can you please check if it's caused by this combination? We should =
get
> > Juha's patch integrated...
> >
> > Tony
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
