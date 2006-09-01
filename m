From: kabbin <kabbin26@yahoo.com.tw>
Subject: Re: IP-Config: Failed to open eth0
Date: Fri, 1 Sep 2006 10:17:05 +0800 (CST)
Message-ID: <20060901021705.61046.qmail@web17805.mail.tpe.yahoo.com>
References: <20060831112057.GA11784@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060831112057.GA11784@orphique>
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


Thanks for your help.=20
I have read the post, as Wolfgang Denk said, It's a bug in the Linux ethe=
rnet driver.=20

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-July/023579=
.html

But Could somebody tell me how to fix to bug? I cannot find a answer in t=
he mail list.

By the way, as my board is omap2420h4, and I could not find the file:
//uboot/board/omap2420h4/eeprom.c=20

Best regards.

--- Ladislav Michl <ladis@linux-mips.org> =BB=A1=A1G

> On Thu, Aug 31, 2006 at 05:06:34PM +0800, kabbin wrote:
> > Dear all:=20
> >   I cannot boot from NFS. Could anyone help me please?  My board is o=
map2420h4,  kernel 2.6.10
> =20
> >=20
> >=20
> > Does following means that the network driver configuration is wrong?
> > Why Invalid ethernet MAC address ?  I have setenv ethaddr already.
> >=20
> > I got :
> >=20
> > Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
> > smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
> > eth0: SMC91C94 (rev 9) at 0xc4858300 IRQ 188 [nowait]
> > eth0: Invalid ethernet MAC address.  Please set using ifconfig
>=20
> Did you read that hint? ifconfig (8) lives on your NFS root you so you
> have serious problem ;-) You can either use initrd as workaround=20
> or preferably set MAC address corectly. Assuming you are using U-boot:
> http://www.denx.de/wiki/bin/view/DULG/EthernetDoesNotWorkInLinux
> You can also look at U-Boot source code:
> board/voiceblue/eeprom.c
>=20
> Best regards,
> 	ladis
>=20


___________________________________________________=20
 =B1z=AA=BA=A5=CD=AC=A1=A7Y=AE=C9=B3q =A1=D0 =B7=BE=B3q=A1B=AET=BC=D6=A1B=
=A5=CD=AC=A1=A1B=A4u=A7@=A4@=A6=B8=B7d=A9w=A1I=20
 http://messenger.yahoo.com.tw/
