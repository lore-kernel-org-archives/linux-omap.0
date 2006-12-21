From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.19] omap camera builds again; Mistral hooks
Date: Thu, 21 Dec 2006 14:57:37 -0800
Message-ID: <20061221225737.GG10399@atomide.com>
References: <20061207034509.5BC701E771D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200612070558.19023.marek.vasut@gmail.com>
	<20061211222134.GG31722@atomide.com>
	<200612141239.39491.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200612141239.39491.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061214 12:40]:
> On Monday 11 December 2006 2:21 pm, tony@atomide.com wrote:
> > * Marek Va=C5=A1ut <marek.vasut@gmail.com> [061206 20:59]:
> > > Hi, just a small typo ...
> > > static char banner[] __initdata =3D KERN_INFO "OMAP Camera driver=20
> > > initialzing\n"; ... should be initializing ;-)
> >=20
> > Pushed in two parts, one for the core changes, and the other patch
> > for the driver. I had to manually apply some parts of the driver
> > patch. Dave, can you please check that your changes got applied?
>=20
> I can "patch -R" my version with only a reject on the last half of
> the camera_core.c changes ... and eyeballing that, I didn't see
> any obvious breakage, I think it's whitespace.  It still says it's
> getting its "initial zing" though.  ;)

Fixing today :)

Tony
