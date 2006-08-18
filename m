From: Hingkwan Huen <hkh@cypress.com>
Subject: Re: Memory Expansion on OMAP2420 H4
Date: Fri, 18 Aug 2006 09:15:30 -0700
Message-ID: <1155917730.2949.17.camel@localhost.localdomain>
References: <20060818012824.4896.qmail@web17809.mail.tpe.yahoo.com>
Reply-To: hkh@cypress.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060818012824.4896.qmail@web17809.mail.tpe.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: kabbin <kabbin26@yahoo.com.tw>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Yanming,

The u-boot binary from Ti's website works fine with me. All I did was
just changing the environment variables.
http://linux.omap.com/pub/bootloader/h4/u-boot.bin.gz

For "cp.b", assuming you have issues accessing the flash, just do a
"protect off all" before you do "cp.b". Be careful not to override your
u-boot image which resides at address 04000000.

I have 2 H4's experiencing same problem of copying from/to the NOR
flash. I just use "protect off all" as a temporary fix. Maybe Richard W.
from Ti on this forum can explain this.

Cheers,
kwan


On Fri, 2006-08-18 at 09:28 +0800, kabbin wrote:
> Dear Kwan :
>    Sorry to bother you. But I think maybe you can give
> me a  hand,please? I also have OMAP2420H4, but I have
> some problems when using the Uboot on it. It seems I
> got the "broken" source code and download broken
> binary file either. The u-boot sometimes works fail
> especially when using "cp.b" command.
>   So, may I ask if you have the right binary file and
> could you email it to me please? I'll be deeply
> appreciate your kindness. Thanks you.
> Have a nice day.  :-)  =20
>                                  yanming 2006/08/18
>=20
> ___________________________________________________=20
>  =E6=9C=80=E6=96=B0=E7=89=88 Yahoo!=E5=A5=87=E6=91=A9=E5=8D=B3=E6=99=82=
=E9=80=9A=E8=A8=8A 7.0=EF=BC=8C=E5=85=8D=E8=B2=BB=E7=B6=B2=E8=B7=AF=E9=9B=
=BB=E8=A9=B1=E4=BB=BB=E4=BD=A0=E6=89=93=EF=BC=81=20
>  http://messenger.yahoo.com.tw/
>=20
