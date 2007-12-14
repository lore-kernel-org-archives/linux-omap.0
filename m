From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: ALSA driver for audio codec on TWL4030
Date: Fri, 14 Dec 2007 18:34:35 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A001453D3B@dbde01.ent.ti.com>
References: <376191c90712131052p359b9927ic31671ed8b4de0f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <376191c90712131052p359b9927ic31671ed8b4de0f8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Shobhit Kumar <shos.arora@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-open-source-bounces+khasim=3Dti.com@linux.omap.com
> [mailto:linux-omap-open-source-bounces+khasim=3Dti.com@linux.omap.com] =
On
> Behalf Of Shobhit Kumar
> Sent: Friday, December 14, 2007 12:22 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: ALSA driver for audio codec on TWL4030
>=20
> Hi,I was planning to use the 2.6.21 kernel from the omap git tree, but
> found
> that the ALSA driver for audio codec on TWL4030 is not included. I =
checked
> the 2.6.14 release from TI which has the driver for the same. But this
> same
> driver cannot probably used as is on 2.6.21 kernel due to various ALSA
> framework changes.
>=20
> Is there a port available on 2.6.21 kernel or would I have to port =
it..
>=20

We have uploaded new source for 3430 on linux.omap.com, it is 2.6.22 =
based. This should also be working for 2430. I think you can use the =
ALSA framework here for 2430 or switch your complete work to 2.6.22.

Regards,
Khasim
