From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Problems when porting linux kernel 2.6.10  on OMAP2420H4
Date: Mon, 7 Aug 2006 22:10:41 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A507010BA9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: ?? <kabbin26@yahoo.com.tw>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This just says your kernel image in flash is corrupt for some reason.=20

It is possible you didn't erase the full size of your kernel before =
burning it (rounded to sector size).

Also, it is possible your u-boot version needs updating.  This looks =
like an old u-boot bug where the 2nd partition of the flash port is left =
in status mode.  Issue the command "mm.w 04100000 ffff" then try your =
bootm command. If that fixes the issue, update the u-boot.

Generally, I'd recommend you build the u-boot & kernel for H4 from the =
newer 2430SDP path.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of kabbin26@yahoo.com.tw
> Sent: Monday, August 07, 2006 9:34 PM
> To: Linux-omap-open-source@linux.omap.com
> Subject: Problems when porting linux kernel 2.6.10 on OMAP2420H4
>=20
> Hello  dear all
>      I have some problems when porting linux2.6.10 on OMAP2420H4.
> I downloaded the kernel image (uImage.gz) from
> http://linux.omap.com/pub/kernel/h4/
> , and dowonload to OMAP2420H4 via tftp.
> But I  got  the  fowllowing messages:
>=20
> OMAP242x H4 # bootm 04060000
> ## Booting image at 04060000 ...
>    Image Name:   Linux-2.6.10-omap
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1209412 Bytes =3D  1.2 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>  Verifying Checksum ... Bad Data CRC
>=20
> Could anybody tell me what it is about? How can I deal with it ?
> Thanks.
>                              Yan-Ming 20060808.
>=20
>=20
>=20
>  ___________________________________________________
>  =D7=EE=D0=C2=B0=E6 Yahoo!=C6=E6=C4=A6=BC=B4=95r=CD=A8=D3=8D =
7.0=A3=AC=C3=E2=D9M=BEW=C2=B7=EB=8A=D4=92=C8=CE=C4=E3=B4=F2=A3=A1
>  http://messenger.yahoo.com.tw/
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
