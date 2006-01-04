From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: how to test the sound drive in Omap1510
Date: Wed, 4 Jan 2006 09:11:26 -0600
Message-ID: <520AB2AD990DC04082102F77CA172638022A1798@dlee03.ent.ti.com>
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
To: prem chand yasodhar <premchand.yasodhar@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> please give the information  from basics onwords..
>=20
> how to test the sound drive in omap1510

There are two set of sound infrastructure in Linux - OSS and ALSA. These
are standards as to how the drivers should interact with the userspace
applications- the device to expose, the ioctls to take etc... OSS is old
and despite numerous attempts to eradicate it, it still survives.. and
ALSA is the new standard in the town (well.. not *exactly* new.. but
then..)

You can go to http://www.opensound.com/ and read about the OSS API set
and to http://www.alsa-project.org/ for ALSA.=20

Now, interestingly testing of the driver depends a lot on capability of
the hardware and driver (esp in an embedded scenario). U could test if a
simple open/close works, setting of sample rates work etc.. then u could
go thru all the ioctls relevant for ur driver. Once this is done, check
if the driver can transmit in all sampling rates and if all these tests
work for receive path too and the full duplex path.. send a data stream
with only left channel with sound and another data stream with right
channel with sound.. I guess this gives a fairly small test cases for ur
audio driver..=20

Regards,
Nishanth Menon
