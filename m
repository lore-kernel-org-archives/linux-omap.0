From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: *** No rule to make target `omap_2430sdp_deconfig'.  Stop.
Date: Fri, 12 Oct 2007 13:02:06 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A088049D5AAC@dbde01.ent.ti.com>
References: <FBD03D6DFE9D7C4893187AAE6DD77F0C1079EA@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <FBD03D6DFE9D7C4893187AAE6DD77F0C1079EA@BLR-SGM-MSG01.wipro.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: aravind.boinpally@wipro.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Aravind,

   Please include the command exactly as you typed it so we can tell if =
something is wrong. Also check in the arch/arm/configs directory and see =
if the omap_2430sdp_defconfig file is present. (Type "ls =
arch/arm/configs | grep sdp")=20

Regards,
Anand

> -----Original Message-----
> From: aravind.boinpally@wipro.com=20
> [mailto:aravind.boinpally@wipro.com]=20
> Sent: Friday, October 12, 2007 1:00 PM
> To: Gadiyar, Anand
> Subject: RE: *** No rule to make target `omap_2430sdp_deconfig'. Stop.
>=20
>=20
> Hi..anand ..
>=20
> Thanks for the reply..
>=20
> Ya I typed command wrongly.
>=20
> I tried with the option ,but still it is giving error like
>   ""Can't find default configuration
> "arch/arm/configs/omap_2430sdp_defconfig"!""
>=20
> Can u give me some more inputs..
> Thanking you
>=20
> -----Original Message-----
> From: Gadiyar, Anand [mailto:gadiyar@ti.com]
> Sent: Friday, October 12, 2007 12:43 PM
> To: Aravind Kumar boinpally (WT01 - MCE-Mobile & Consumer Electronics)
> Subject: RE: *** No rule to make target `omap_2430sdp_deconfig'. Stop.
>=20
> Aravind,
>=20
> I think you have a typo. Use "make ARCH=3Darm
> CROSS_COMPILE=3D/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-
> omap_2430sdp_defconfig"
>=20
> Note the defconfig instead of deconfig.
>=20
> --Anand
>=20
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com
> > [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of=20
> > aravind.boinpally@wipro.com
> > Sent: Friday, October 12, 2007 12:38 PM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: *** No rule to make target `omap_2430sdp_deconfig'. Stop.
> >=20
> > Hi...
> > =20
> > I am trying to compile the 2.6 kernel.I followed the=20
> following steps=20
> > for compilation.
> > =20
> > First i have made clean by using
> > =20
> >  make ARCH=3Darm
> > =
CROSS_COMPILE=3D/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-
> > clean
> > =20
> > then i configured the board for OMAP2430 using
> > =20
> >  make ARCH=3Darm
> > =
CROSS_COMPILE=3D/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-
> > omap_2430sdp_deconfig
> > =20
> > But after doing this i am getting error like
> > =20
> > =20
> > make[1]: *** No rule to make target `omap_2430sdp_deconfig'.  Stop.
> > make: *** [omap_2430sdp_deconfig] Error 2
> > =20
> > =20
> > can u please suggest me what went wrong???
> > =20
> > Thanking you.
> > =20
> >=20
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >=20
>=20
>=20
> The information contained in this electronic message and any=20
> attachments to this message are intended for the exclusive=20
> use of the addressee(s) and may contain proprietary,=20
> confidential or privileged information. If you are not the=20
> intended recipient, you should not disseminate, distribute or=20
> copy this e-mail. Please notify the sender immediately and=20
> destroy all copies of this message and any attachments.=20
>=20
> WARNING: Computer viruses can be transmitted via email. The=20
> recipient should check this email and any attachments for the=20
> presence of viruses. The company accepts no liability for any=20
> damage caused by any virus transmitted by this email.
> =20
> www.wipro.com
>=20
