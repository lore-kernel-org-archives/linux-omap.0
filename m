From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OneNAND Booting
Date: Thu, 12 Apr 2007 23:35:12 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429C2E9D8@dlee13.ent.ti.com>
References: <42E999AD7A0E4647BF159F467EE4FBCB0155E1EB@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <42E999AD7A0E4647BF159F467EE4FBCB0155E1EB@BLR-SGM-MSG01.wipro.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sathish.madhava@wipro.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Here is what I've done in the past:

Are you sure your u-boot made it into flash?

--------------
Sign the Image with CSST and set its TOC offset to be 0x200 for NAND

If xloader re-copies to SRAM match config.mk addr with start address
(0x40200800), if relocation to DDR the default can be used.

OneNAND flash programing using u-boot				=09
dhcp 80300000 xload.bin				=09
OMAP343X SDP # onenand unlock 0 0				=09
start =3D 0x00000000, ofs =3D 0x00020000				=09
OMAP343X SDP # onenand unlock 1 0				=09
start =3D 0x00020000, ofs =3D 0x00020000				=09
OMAP243X SDP # onenand unlock 2 0				=09
start =3D 0x00040000, ofs =3D 0x00020000				=09
OMAP343X SDP # onenand unlock 3 0				=09
start =3D 0x00060000, ofs =3D 0x00020000				=09
OMAP343X SDP # onenand erase block 0-3
Erase block from 0 to 3
OMAP343X SDP # onenand write 80300000 0 2000
onenadwrite: addr =3D 0x80300000, ofs =3D 0x0, len =3D 0x2000
Done. ret =3D 0
dhcp 80300000 u-boot.bin
OMAP343X SDP # onenand unlock 4 0
start =3D 0x00080000, ofs =3D 0x00020000
OMAP343X SDP # onenand unlock 5 0
start =3D 0x000a0000, ofs =3D 0x00020000
OMAP343X SDP # onenand erase block 4-5
Erase block from 4 to 5
OMAP343X SDP # onenand write 80300000 80000 40000
onenadwrite: addr =3D 0x80300000, ofs =3D 0x80000, len =3D 0x40000
Done. ret =3D 0

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of
sathish.madhava@wipro.com
> Sent: Thursday, April 12, 2007 11:00 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: OneNAND Booting
>=20
> Dear All,
>=20
> I have some questions on OneNAND booting on OMAP2430SDP board.
>=20
>=20
>=20
> I am using X-loader 1.40 version with UBoot 1.1.3 version.
>=20
>=20
>=20
> I have created X-load.bin and converted it to X-load.raw.
>=20
> Using CSST Tool I signed it to generated X-load.raw.ift.
>=20
> I am burning X-load.raw.ift  to ONENAND on OMAP2430SDP board at
address
> 0x20000000 and
>=20
> I used UBoot to write UBoot.bin at Offset 0x0080000 using onenand
write
> command. ( I have verified the content using onenand read, it is OK )
>=20
>=20
>=20
> Now I change the switch settings to enable OneNand Booting, but all I
am
> getting on the console is only the following message.
>=20
>=20
>=20
> ------------------------------------
>=20
> Texas Instruments X-Loader 1.40
>=20
> Detected Samsung MuxOneNAND1G Flash
>=20
> Starting OS Bootloader...
>=20
> ------------------------------------
>=20
>=20
>=20
> But UBoot is not loading after this stage., I donot know whats wrong
at
> this stage.
>=20
>=20
>=20
> I read that for OneNAND booting, I need to create a X-loader image of
> less than 1kb size and then merge this with UBoot image then burn the
> merged file to OneNAND.
>=20
> How do I create x-loader image of size only 1Kb ( it is currectly
around
> 6Kb, does anybody have any links for that 1kb source file ).
>=20
> What kind of merging has to be used to merge X-load image and U-Boot
> image. After merging the files can I use CSST to burn it to OneNAND?
>=20
>=20
>=20
> Can somebody suggest me.
>=20
>=20
>=20
> Thanks and Regards
>=20
> -Sathish
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
