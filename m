From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: enabling D cache
Date: Mon, 13 Feb 2006 10:41:56 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF4038CD1F6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Ram <vshrirama@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Sriram,

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Ram
> Sent: Thursday, February 09, 2006 6:30 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: enabling D cache
>=20
> Hi,
>    I am using OMAP 5912 OSK.
>=20
>    I am implementing a command in u-boot (boot loader) which has lots
> writes to and
>    reads from memory.
>=20
>    I want to enable the D cache in u-boot. i went through the data
> sheets of osk and could not find the registers i need to set inorder
> to enable d-cache.
>=20

The registers that you need to set are the ARM926 CP15 registers.
Details of these registers can be found in the ARM926 User Guide from
ARM Ltd. See:
http://arm.com/pdfs/DDI0198D_926_TRM.pdf

Please note that enabling the d-cache is not a straight forward as
enabling the i-cache. Before you enable the d-cache you need to
configure an ARM MMU translation table and then enable the MMU itself.
All d-cache transactions use the MMU to make sure that you have the
appropriate permissions to access the address range you are caching.
Another potential pitfall of enabling the d-cache is to make sure that
device register address ranges are setup as non-cacheable in the MMU as
you do not want to cache these. Hence, this is not a simple thing to do
and you could run into other problems. This is probably why uboot does
not enable the d-cache by default. Therefore, I would avoid doing this
unless it is absolutely vital.=20

Regards,
Jon
