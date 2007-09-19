From: "Sriram, Kannan" <ksriram@ti.com>
Subject: RE: Regarding the Boot Up Problem with OMAP2430
Date: Wed, 19 Sep 2007 17:35:34 +0530
Message-ID: <0A50DBE80DD6674E94F7269DC964A7B694E494@dbde01.ent.ti.com>
References: <19B9278CA74D6D4B889A1687EE63920207921A@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <19B9278CA74D6D4B889A1687EE63920207921A@BLR-SGM-MSG01.wipro.com>
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


u-boot console is available on UART1, not UART3.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of
> aravind.boinpally@wipro.com
> Sent: Wednesday, September 19, 2007 8:18 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Regarding the Boot Up Problem with OMAP2430
>=20
> Hi ALl,
>=20
> This is Aravind .I am working on OMAP2430(SDP2430-VG5.0.1) to bring up
> the board with Boot loader and Linux.I am facing some problem while
> downloading the Boot loader image.Please assist me for this problem.
>=20
> I have followed the below procedure for downloading u-boot image into
> NOR Flash at 0x04000000.
>=20
>  I Installed CSST_SDP2430_v1.7 in My Host PC.
>=20
> 1) First i downloaded the u-boot.bin image from "Linux.omap.com" and
> placed it on Windows Desktop.
>=20
> 2) Then i Changed the DIP Switch settings as per
> CSST_QuickStartGuide_SDP2430 Datasheet for USB Link.
>=20
> 3) Then I connected USB from host to OMAP Board(Triton2 HS/FS USB Mini
> AB connector) with MiniAB USB plug.Here when i Tried to Connect to
> ISP1504HS USB,but  it is not able to Programming with this port .It is
> giving error as Target is not Connected like.
>=20
> 4)After Successfully Programming u-boot into NoR Flash at address
> 0x04000000, i removed the USB connection and then Changed the DIP
> Settings.
>=20
> 5) Now I connected the RS232 Cable to UART3 Port and opened
> HyperTerminal with 115200,8,1,Flow Control None Configurations.
>=20
> 6) Then I Restted the Board and Observed for U-boot Prompt.But I am
not
> able to observe any output on the HyperTerminal.
>=20
> 7) Is there Anything went wrong in My Procedure.Or USB Programming
> Port(Triton2) is wrong ?
>=20
> 8) I am not able to debug it.Is there any Document or tool for finding
> out the Problem.
>=20
> 9)And also I am Programming with only Triton2 HF/Fs MINI AB  USB
> Connector not with ISP1504 HS USB Mini USB Connector. It is giving
error
> if i program with ISP1504.
>=20
> 10) Please give me some inputs so that I can Proceed Further .
>=20
> Awaiting For Your Reply......
>=20
>=20
> With Regards
> Aravind Kumar.B
> 9886391518
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
