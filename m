From: Yan-Ming <kabbin26@yahoo.com.tw>
Subject: Problems when porting linux kernel 2.6.10  on OMAP2420H4
Date: Tue, 8 Aug 2006 12:08:11 +0800 (CST)
Message-ID: <20060808040811.81570.qmail@web17804.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



Yan-Ming <kabbin26@yahoo.com.tw> =BB=A1=A1G
 Sorry,but may I ask is the command " mw.w 04100000 ffff " instead "mm.w =
04100000 ffff"?

B.T.W.  I was using U-Boot1.1.3 download from http://linux.omap.com/pub/b=
ootloader/h4/u-boot.bin.gz
and renamed it to u-boot.bin.raw after gunzip.
After that, I use TI OST_Host to burn u-boot to flash. It really work.
But when I build u-boot-1.1.4 myself and burn to flash, it responds nothi=
ng on the  terminal. And I have no idea what's wrong  as I also got u-boo=
t.bin.=20
 So I afraid that I am unable to update u-boot myself.=20
 Could anyone help me?=20
 Best regards.

"Woodruff, Richard" <r-woodruff2@ti.com> =BB=A1=A1G This just says your k=
ernel image in flash is corrupt for some reason.=20

It is possible you didn't erase the full size of your kernel before burni=
ng it (rounded to sector  size).

Also, it is possible your u-boot version needs updating.  This looks like=
 an old u-boot bug where the 2nd partition of the flash port is left in s=
tatus mode.  Issue the command "mm.w 04100000 ffff" then try your bootm c=
ommand. If that fixes the issue, update the u-boot.

Generally, I'd recommend you build the u-boot & kernel for H4 from the ne=
wer 2430SDP path.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of kabbin26@yahoo.com.tw
> Sent: Monday, August 07, 2006 9:34 PM
> To: Linux-omap-open-source@linux.omap.com
> Subject: Problems when porting linux kernel 2.6.10 on OMAP2420H4
>=20
> Hello  dear all
>      I have some problems when porting linux2.6.10 on OMAP2420H4.
> I downloaded the kernel image (uImage.gz) from
>  http://linux.omap.com/pub/kernel/h4/
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
>  =D7=EE=D0=C2=B0=E6 Yahoo!=C6=E6=C4=A6=BC=B4=95r=CD=A8&#65533; 7.0=A3=AC=
=C3=E2=D9M=BEW=C2=B7&#65533;&#65533;=C8=CE=C4=E3=B4=F2=A3=A1
>  http://messenger.yahoo.com.tw/
> _______________________________________________
> Linux-omap-open-source mailing list
>  Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

 ___________________________________________________=20
 =B3=CC=B7s=AA=A9 Yahoo!=A9_=BC=AF=A7Y=AE=C9=B3q=B0T 7.0=A1A=A7K=B6O=BA=F4=
=B8=F4=B9q=B8=DC=A5=F4=A7A=A5=B4=A1I=20
 http://messenger.yahoo.com.tw/


 ___________________________________________________=20
 =B3=CC=B7s=AA=A9 Yahoo!=A9_=BC=AF=A7Y=AE=C9=B3q=B0T 7.0=A1A=A7K=B6O=BA=F4=
=B8=F4=B9q=B8=DC=A5=F4=A7A=A5=B4=A1I=20
 http://messenger.yahoo.com.tw/
