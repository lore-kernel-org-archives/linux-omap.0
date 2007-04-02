From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: X-loader and Micron Nand
Date: Mon, 2 Apr 2007 10:39:42 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429ABCE3A@dlee13.ent.ti.com>
References: <8bf247760704020833p73b0b709pa45e2ae61639d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <8bf247760704020833p73b0b709pa45e2ae61639d2e@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ram <vshrirama@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>    Im using a custom board of OMAP 2430 which has a micron nand flash
> (large page size - 2K)
>=20
>    I trying to boot out of nand. Im running u-boot from RAM and trying
> to write X-loader and u-boot from u-boot.

For raw NAND you can not write the x-loader using u-boot and get a boot.
You must burn using the CSST tool.

The OOB format as expected by the mask ROM is different they what u-boot
writes.

Regards,
Richard W.
