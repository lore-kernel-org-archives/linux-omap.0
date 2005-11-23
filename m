From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: DSP core access
Date: Wed, 23 Nov 2005 09:33:56 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF402A3A8B8@dlee02.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com, Louis Jung <lhsj81@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Louis=20

>=20
> Hi all,
>=20
> I am currently trying to obtain a real time data using DSP core on the

> omap platform via the I2C peripheral.  I was hoping to achieve this by

> controlling the DSP via linux kernel that's running on the Arm core.=20
> There is a DSP gateway through which I think i should be able to=20
> control. Does anyone know the specific ways of doing this?
>=20

You could also use the dsp/bios link software for controlling the DSP
and streaming data between the ARM and DSP. See the following link.
There are some simple example applications provided to get you started.=20
http://focus.ti.com/dsp/docs/dspsupportatn.tsp?sectionId=3D3&tabId=3D477&=
fam
ilyId=3D44&toolTypeId=3D5

In order to use the i2c peripheral from the DSP side you first need to
configure the static switch in the device because this is a
shared-peripheral and defaults as an ARM peripheral. For more details
please refer to section 2.5 of the following document:
http://focus.ti.com/docs/apps/catalog/resources/appnoteabstract.jhtml?ab
stractName=3Dspru758a

Regards,
Jon
