From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Reg X-loader  compilation Problem
Date: Sat, 22 Sep 2007 20:11:14 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901FD3352@dlee13.ent.ti.com>
References: <19B9278CA74D6D4B889A1687EE639202079559@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <19B9278CA74D6D4B889A1687EE639202079559@BLR-SGM-MSG01.wipro.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: aravind.boinpally@wipro.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Remove that option from cpu/arm1136/config.mk its removed in that =
version of gcc.  Its not needed for that.

Regards,
Richard W.

> -----Original Message-----
> From: =
linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.com
> =
[mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.co=
m]
> On Behalf Of aravind.boinpally@wipro.com
> Sent: Friday, September 21, 2007 6:45 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Reg X-loader compilation Problem
>=20
> Hi all,
>=20
> I am facing compilation problem with X-loader.
>=20
> I have downloaded the X-loader from Linux.omap.com =
""x-load_11SEP.tgz"".
>=20
> Then I have untarred it and changed the ""include/configs/om  file for
> ONENAND support.
>=20
> After this I tried to compile this using cross tool chain
> "arm-none-Linux-gnueabi-" ,but after doing this i am getting
>=20
> error like
>=20
> ""error: unrecognized command line option "-mapcs-32""".
>=20
> can some one suggest me what could be the problem.
>=20
> is it problem with tool chain.???
>=20
> I compiled this code using make3.80 tool.
>=20
> but when i compiled with make 3.81 also same problem ..
>=20
> and also version of gcc is 4.1.1
>=20
> Please give me some inputs
> thanking you.
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
