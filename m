From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 00/19] OMAP: DSS2 v5 intro
Date: Thu, 12 Nov 2009 07:03:42 +0200
Message-ID: <1258002222.21596.1129.camel@localhost>
References: <1257767126-12059-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1257856848.21596.753.camel@localhost>
	 <1257929140.20378.51.camel@tubuntu.research.nokia.com>
	 <1257932641.20378.77.camel@tubuntu.research.nokia.com>
	 <20091111184208.GC24837@atomide.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752206AbZKLFFt@vger.kernel.org>
In-Reply-To: <20091111184208.GC24837@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

On Wed, 2009-11-11 at 10:42 -0800, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [091111 01:43]:
> > On Wed, 2009-11-11 at 09:45 +0100, Valkeinen Tomi (Nokia-D/Helsinki=
)
> > wrote:
> > > On Tue, 2009-11-10 at 13:40 +0100, Artem Bityutskiy wrote:
> > > > Tomi,
> > > >=20
> > > > could you please kindly ask Stephen (CCed) to include the DSS2 =
tree into
> > > > linux-next, because you are going to merge it the next merge wi=
ndow, and
> > > > there does not seem to be any blocker for this.
> > > >=20
> > > > Being in linux-next for a while is really important.
> > >=20
> > > Stephen, would this be possible? DSS2 driver is rather big piece =
of
> > > code, even if it's quite isolated, so it would be nice to have it=
 in
> > > linux-next.
> > >=20
> > > What does it require from me? A git tree, obviously, but what sho=
uld it
> > > be based on?
> >=20
> > Ah, I just realized that DSS2 patches depend on patches from Tony's
> > tree. I guess I should base my tree on top of some Tony's tree that=
 is
> > going to linux-next?
>=20
> Or I can merge them into my for-next if that's OK with everybody. Thi=
s
> merge cycle is a pain for omap as we've moved all the common headers =
from
> include/mach to include/plat.

I thought everything stable which you are going to merge next merge
window should be in the next branch by default. Especially these massiv=
e
re-names which potentially may break many things, right?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
