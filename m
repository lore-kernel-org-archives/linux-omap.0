From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: [PATCH] Alsa modularisations and support for tsc2101 0/7
Date: Tue, 21 Feb 2006 07:22:26 -0600
Message-ID: <520AB2AD990DC04082102F77CA1726381036EA@dlee03.ent.ti.com>
References: <9268368b0602200933s41905c2bp254749b1e6eff9c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Daniel Petrini <d.pensator@gmail.com>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Daniel,
Glad to see a clean organization coming in for the code :).
>2) If it is acceptable to put the codecs under arch directory, would
>plat-omap be better location than arch-omap1, for mcbsp supported
>codecs? (Are there any omap2 boards with aic23 or tsc2101 codecs?)
Yes, There are omap2 boards with tsc2101, and omap2 boards which can =
have pluggable codecs. some interesting observations I have seen so far =
(it will be a small set compared to what others could add):
=20
Control paths:
McSPI, uWire, I2C
=20
Data transfer paths:
codecs with mcbsp/EAC on 2420
codecs with mcbsp/mcbsplp(on2430)
codecs on mcbsp1,2
=20
Data formats:
PCM,I2S,TDM
could have supported uLaw data formats too
=20
Codecs:
tsc2101, aic, others such as =
twl4030(http://focus.ti.com/general/docs/wtbu/wtbugencontent.tsp?template=
Id=3D6123&path=3Dtemplatedata/cm/general/data/wtbmiddl/twl4030&DCMP=3DWTB=
U&HQS=3DProductBulletin+OT+twl4030) =
<http://focus.ti.com/general/docs/wtbu/wtbugencontent.tsp?templateId=3D61=
23&path=3Dtemplatedata/cm/general/data/wtbmiddl/twl4030&DCMP=3DWTBU&HQS=3D=
ProductBulletin+OT+twl4030)other> codecs which are far more complex than =
these two, including data mixing, mono/stereo input/output capabilities.
=20
Regards,
Nishanth Menon
