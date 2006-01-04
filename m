From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Pending patches mostly pushed, please check
Date: Tue, 3 Jan 2006 23:12:49 -0800 (PST)
Message-ID: <20060104071249.3324.qmail@web32912.mail.mud.yahoo.com>
References: <20060103191356.GR6034@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060103191356.GR6034@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Dirk Behme <dirk.behme@de.bosch.com>, imre.deak@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Tony Lindgren <tony@atomide.com> wrote:

> > Experimental & test (do not apply yet):
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > 1) omap24xx vout and dispc library
> >
>
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/0059=
32.html

Imre,=20
Could you please reply on this? If needed I can re-work on integration
as per your suggestions.


> >=20
> > 3) keypad: platform_data and 24xx support -exp
> >
>
>http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005=
889.html

> >=20
> > 4) omap24xx IrDA update
> >
>
>http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005=
992.html

Please comment on keypad and irda patches. If acceptable then I can
regenerate them against latest git tree. Thanx.

IrDA patch is now working on H4 without crash.

Patches sitting under my ompt-git tree:

o h4 nand patch (not able to test...as got stuck with x-loader an d
u-boot flashing). If someone wants to experiment, I can release.

o OMAP2 spi master controller driver + tsc2101 protocol driver
as per david's framework. I have written good amount of the code for
this, but not yet working successfully. If someone wants to have fun
then I can submit to them.

---Komal Shah
http://komalshah.blogspot.com/


	=09
__________________________________________=20
Yahoo! DSL =96 Something to write home about.=20
Just $16.99/mo. or less.=20
dsl.yahoo.com=20
