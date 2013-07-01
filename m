From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] N900: fix operation on emulator
Date: Mon, 1 Jul 2013 22:53:53 +0200
Message-ID: <20130701205353.GB22174@amd.pavel.ucw.cz>
References: <20130613142809.GA3775@amd.pavel.ucw.cz>
 <20130613145724.GH8164@atomide.com>
 <20130613155240.GB3775@amd.pavel.ucw.cz>
 <20130613161418.GJ8164@atomide.com>
 <20130613230808.GA14876@amd.pavel.ucw.cz>
 <20130614055629.GM8164@atomide.com>
 <20130614212816.GA31768@atrey.karlin.mff.cuni.cz>
 <20130617111031.GQ20992@atomide.com>
 <20130701140315.GA15318@amd.pavel.ucw.cz>
 <51D1C8DD.6040409@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51D1C8DD.6040409@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Hi!

> >Errata workarounds for N900 hardware actually break operation on
> >emulator. Fix it.
>=20
> >This approach was suggested by Pali Roh=E1r <pali.rohar@gmail.com>
> >(thanks!).
>=20
> >(Also explain what "sleep_ind" led actually does).
>=20
>    Looks like unrelated change and probably worth another patch?

Ok, more serious issue is that code this was modifying is not yet in
mainline. Sorry.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
