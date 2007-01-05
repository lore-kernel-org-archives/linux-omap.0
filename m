From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: need help in finding the issue with open source kernel
Date: Fri, 5 Jan 2007 11:38:22 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50939BE02@dlee02.ent.ti.com>
References: <1c5b04b60701050931r1fd235f3rfebdf3a8f9fa1f45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1c5b04b60701050931r1fd235f3rfebdf3a8f9fa1f45@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Bhaskara Rao Kotla <bhaskar12@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Likely a clock setup mis-match.  Make sure kernel speed and u-boot speed
are in sync or at least have u-boot faster (PRCM #2) not 5A.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Bhaskara Rao Kotla
> Sent: Friday, January 05, 2007 11:31 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: need help in finding the issue with open source kernel
>=20
> Hi,
>     I am trying to use open source kernel and u-boot from the below
> location
> on OMAPSDP 2430 version 2.9 board.
>     http://linux.omap.com/pub/
>     I used gcc-3.4.0-1 version compiler to build kernel as well as
u-boot.
>     I could able to build kernel and u-boot successfully and flash the
> u-boot with NOR option on the board using CSST tool BOOTROM mode.
>=20
>     Now I am trying to load the kernel on the board, but it seems not
> going
> forward. it got stuckup like below
>=20
>=20
>=20
> Bytes transferred =3D 1415409 (1598f1 hex)
> OMAP243X SDP # bootm
> ## Booting image at 80300000 ...
>    Image Name:   Linux Kernel Image
>    Image Type:   ARM Linux Kernel Image (gzip compressed)
>    Data Size:    1415345 Bytes =3D  1.3 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>=20
> Starting kernel ..........
>=20
> I would appreciate if someone can help me in finding the issue?
>=20
> Thanks and Regards,
>=20
> Bhaskara
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
