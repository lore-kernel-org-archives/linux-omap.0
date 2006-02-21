From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: [PATCH] Alsa modularisations and support for tsc2101 4/7
Date: Tue, 21 Feb 2006 07:37:58 -0600
Message-ID: <520AB2AD990DC04082102F77CA1726381036EC@dlee03.ent.ti.com>
References: <9268368b0602200953q181b7a4em1944ece745d5acd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Daniel Petrini <d.pensator@gmail.com>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

+#define DEFAULT_BITPERSAMPLE 16

+static struct omap_mcbsp_reg_cfg mcbsp_regs =3D {=20

+ .spcr2 =3D FREE | FRST | GRST | XRST | XINTM(3),

+ .spcr1 =3D RINTM(3) | RRST,

the default bitspersample might vary for codecs - some codecs have =
support for 24 bit too(and mcbsp as 32bit wordlen if bitspersample is =
24bit). this was not supported in oss, but with alsa.. we have scope.

One interesting observations about the new platform device support. on =
SDP2430, we can plug in the codec we'd desire. the combination of codec =
and mcbsp settings are useful, not mcbsp settings remaining remaining =
constant.

i can see we can do it here and a lot cleaner :)

Regards,

Nishanth Menon


________________________________

From: linux-omap-open-source-bounces@linux.omap.com on behalf of Daniel =
Petrini
Sent: Mon 2/20/2006 11:53 AM
To: OMAP-Linux
Subject: [PATCH] Alsa modularisations and support for tsc2101 4/7



ALSA Omap Patch

This patch includes the platform device support for the new proposed
approach. For OSK and H2.

signed-off by Daniel Petrini <d.pensator@gmail.com>
signed-off by Mika Laitio <lamikr@cc.jyu.fi>


Daniel Petrini
--
INdT - Manaus - Brazil
