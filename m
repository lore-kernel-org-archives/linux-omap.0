From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Problems when porting linux kernel 2.6.10  on OMAP2420H4
Date: Tue, 8 Aug 2006 07:47:45 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A507010C5D@dlee02.ent.ti.com>
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
To: Yan-Ming <kabbin26@yahoo.com.tw>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The point of the command is to put the 2nd partition into read array =
mode.

The below is a hand made example as I don't have a machine handy

<u-boot>  mm.l 04100000
041000000: 0068 : ffff
041000002: e102 : .
<u-boot>

Regards,
Richard W.

> Yan-Ming <kabbin26@yahoo.com.tw> =D5f=A3=BA
>  Sorry,but may I ask is the command " mw.w 04100000 ffff " instead =
"mm.w
> 04100000 ffff"?
>=20
> B.T.W.  I was using U-Boot1.1.3 download from
> http://linux.omap.com/pub/bootloader/h4/u-boot.bin.gz
> and renamed it to u-boot.bin.raw after gunzip.
> After that, I use TI OST_Host to burn u-boot to flash. It really work.
> But when I build u-boot-1.1.4 myself and burn to flash, it responds
> nothing on the  terminal. And I have no idea what's wrong  as I also =
got
> u-boot.bin.
>  So I afraid that I am unable to update u-boot myself.
>  Could anyone help me?
>  Best regards.
