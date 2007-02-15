From: "Eyal Shani" <Eyal.Shani@SanDisk.Com>
Subject: RE: Embedded Benchmark for storage performance
Date: Thu, 15 Feb 2007 15:00:02 +0200
Message-ID: <13ECC251745F8F4BA0076A980813C7C2BF1F02@msl-ex02.corp.m-sys.com>
References: <200702151156.54065.openembedded@hrw.one.pl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200702151156.54065.openembedded@hrw.one.pl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi=20Marcin,

I=20am=20able=20now=20to=20build=20the=20binary,=20however=20it=20is=20not=
=20built=20for=20arm.
When=20I=20check,=20by=20'file=20iozone',=20I=20get=20the=20following:

=09=09[root@localhost=20current]#=20file=20iozone
=09=09iozone:=20ELF=2032-bit=20LSB=20executable,=20Intel=2080386,=20versio=
n=201=20(SYSV),=20for=20
=09=09GNU/Linux=202.2.5,=20dynamically=20linked=20(uses=20shared=20libs),=20=
not=20stripped

Which=20means=20it=20did=20not=20really=20built=20it=20using=20any=20relev=
ant=20ARM=20compiler.

Ok,=20so=20next=20I=20tried=20to=20use=20the=20compiler=20I=20am=20using=20=
for=20any=20other=20means=20for=20my=20omap2430=20platform=20(arm_v6_vfp_l=
e_uclibc-gcc),=20and=20I=20get=20various=20errors.

Any=20idea=20what=20is=20wrong?!

Eyal=20Shani



-----Original=20Message-----
From:=20linux-omap-open-source-bounces@linux.omap.com=20[mailto:linux-omap=
-open-source-bounces@linux.omap.com]=20On=20Behalf=20Of=20Marcin=20Juszkie=
wicz
Sent:=20Thursday,=20February=2015,=202007=2012:57=20PM
To:=20linux-omap-open-source@linux.omap.com
Subject:=20Re:=20Embedded=20Benchmark=20for=20storage=20performance

Dnia=20czwartek,=2015=20lutego=202007,=20Eyal=20Shani=20napisa=B3:

>=20I=20am=20trying=20to=20use=20an=20industry=20known=20Benchmark=20for=20=
performance,=20on=20my
>=20OMAP=20platforms.
>
>=20I=20have=20heard=20of=20various=20ones,=20but=20could=20not=20execute=20=
them=20from=20the
>=20platform,=20meaning=20in=20arm/linux=20mode.

>=20Could=20not=20find=20iozone3=20linux-arm=20src=20I=20could=20compile=20=
for=20arm.=20Missing
>=20file...

With=20OpenEmbedded=20I=20built=20iozone3=20for=20ARM=20without=20problems=
.

--=20
JID:=20hrw-jabber.org
OpenEmbedded=20developer/consultant

=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20Don't=20personalize=20compute=
rs.=20They=20hate=20that.


_______________________________________________
Linux-omap-open-source=20mailing=20list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

______________________________________________________________________
This=20email=20has=20been=20scanned=20by=20the=20MessageLabs=20Email=20Sec=
urity=20System.
For=20more=20information=20please=20visit=20http://www.messagelabs.com/ema=
il=20
______________________________________________________________________
