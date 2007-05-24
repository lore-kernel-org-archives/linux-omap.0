From: "Sriram, Kannan" <ksriram@ti.com>
Subject: RE: FlashPrep / X-Loader NAND Booting
Date: Thu, 24 May 2007 11:17:23 +0530
Message-ID: <45F366B1BC4F7C4A895F0F34C41E61A5037B6C88@dbde01.ent.ti.com>
References: <OFA775805D.A7A2184E-ON652572E5.001DC8F2-652572E5.001E670C@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <OFA775805D.A7A2184E-ON652572E5.001DC8F2-652572E5.001E670C@lntinfotech.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Nagesh.Sonone@lntinfotech.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


If you have CSST, why don't you directly use CSST to flash the .ift file
to the NAND device on the board (through UART/USB)? In this case, there
is no need to convert to .out file (.out file is only required if you
are planning to download using CCS).


> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of
> Nagesh.Sonone@lntinfotech.com
> Sent: Thursday, May 24, 2007 2:37 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: FlashPrep / X-Loader NAND Booting
>=20
> Hi All,
>   I am working on bootloader (NAND) for OMAP2430.The X-loader(NAND)
> provided seems not working on the board.But after I read the Readme
> document i got to know th bin  file has to be converted into first ift
> and lateron in .out before flashing it to NAND. I have csst for
makeing it
> ift but where i can get the tool FlashPrep or /and FlashWriterNand to
> convert it to .out ? (as written in Readme document).
> (I dont know whether it is forum or not , I am sorry if I have placed
this
> e-mail @ wrong place, in that case please tell me where I can solve my
> query)
>=20
> Thanks & Regards
> Nagesh
>=20
>=20
>=20
> ______________________________________________________________________
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
