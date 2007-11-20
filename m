From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Question About __REG32 marco
Date: Tue, 20 Nov 2007 08:54:18 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290282BE82@dlee13.ent.ti.com>
References: <005c01c82b61$ac9f1cf0$16110a0a@LongCheer.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <005c01c82b61$ac9f1cf0$16110a0a@LongCheer.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: colorant <colorant@163.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>     1:
>     Why this macro need to be defined in this way ?  Why borther to =
use an
> array ?
>=20
>     Can't we just use something like :
>=20
>     *(volatile u32 *)(vaddr&~0x3) to get the value from vaddr with =
word
> align ?
>=20
>     2:
>     Why this offset array need to be 4096 in size ? shouldn't it be =
1024 ?
> since it already point to a u32 value. and the >>2 make the macro =
never
> got chance to reach a index great than 1024 !
>=20
>     I can only find this macro in omap arch, so I put up the question =
here

IIRC seems like David Brownell introduced this macro usage a couple =
years back.  I seem to recall the generated code was better using that =
scheme.

Regards,
Richard W.
