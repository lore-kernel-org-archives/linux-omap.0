From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: How to program flash of custom OMAP board?
Date: Fri, 5 May 2006 11:19:04 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5058CDD50@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Li Weichen <iaadoa@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

For many OMAP-u-boot ports, if you have a JTAG debugger, you can connect
to the board, initialize clocks & ddr via script, load u-boot into
memory and execute it.  Now you can download using either your JTAG or
ether the image you want to burn and use u-boot to burn that image.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Li Weichen
> Sent: Friday, May 05, 2006 11:08 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: How to program flash of custom OMAP board?
>=20
> Hi everyone,
>=20
> I have a custom OMAP 5912 board with Intel 28F256J3C NOR Flash.  But I
> don't
> know how to download the u-boot to it.  With OSK, the factory
> u-boot-1.1.1.out can be loaded in CCS and download itself while
running.
> But due to the different flash type, this factory u-boot cannot be
> programmed to the custom OMAP board.
>=20
> Does anyone have any idea to resolve this problem?
>=20
> Thank you in advance and best regards!
>=20
>=20
> Li Weichen
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
