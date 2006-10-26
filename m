From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] PalmZ71 - palmz71 specific
Date: Fri, 27 Oct 2006 01:00:15 +0300
Message-ID: <20061026220013.GG7609@atomide.com>
References: <200610241724.50323.marek.vasut@gmail.com>
	<20061025180333.GH4852@atomide.com>
	<200610260150.45911.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610260150.45911.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Marek Va=C5=A1ut <marek.vasut@gmail.com> [061026 02:51]:
> Dne st=C5=99eda 25 =C5=99=C3=ADjen 2006 20:03 jste napsal(a):
> > Hi,
> >
> > * Marek Va=C5=A1ut <marek.vasut@gmail.com> [061024 18:27]:
> > > Hi,
> > > this is the rest of the code - palmz71 specific things - board file=
, lcd
> > > etc.
> >
> > Thanks for splitting the patches. Can you please split this patch one
> > more time to separate the video stuff into a separate patch?
> >
> > The reason being that the arch/arm/*omap*/* and include/asm-arm/arch-=
omap/*
> > patches go to the mainline pretty much as they are. (And omap video i=
s
> > not yet in the mainline)
> >
> > Please also reply with your Signed-off-by: line to your other patches=
.
> >
> > Regards,
> >
> > Tony
>=20
> Hi,
> this is it - separate video and arch for z71.
>=20
> BR
> Marek
>=20
> Signed-off-by: Marek Va=C5=A1ut <marek.vasut@gmail.com>

Pushing these today. I tabified the board file and left out the fpga.h
from the video.

Tony
