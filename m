From: "Zhang, Jian" <jzhang@ti.com>
Subject: status of OMAP ALSA support
Date: Wed, 9 Aug 2006 17:58:18 -0500
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA6040A2BB9@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Does OMAP ALSA driver work? Neither H4 nor H3 has it in default
configuration. =20

I see the following in tsc2101 codec driver:

codec_cfg =3D pdev->dev.platform_data;
if (codec_cfg !=3D NULL) {
 ...
}
else
ret =3D -ENODEV;

I don't see any code to set up dev.platform_data. As a result, codec_cfg
is always NULL and OMAP ALSA should not work at all.=20

I might miss something here. Please comment.

Other than that, it seems to have the following limitations by looking
at the code statically.
- omap-alsa.c knows the codec connectivity detail (hard-coded to
MCBSP1). This file should be independent of board specifics.
- Dead lock as s->dma_lock is double locked in multiple locations.
- Don't support duplex as codec lock is shut off when either input
stream or output stream is closed.
- Memory strategy is very rudimental: Hard-coded to allocate 128KB
consistent memory in init time.  =20

Regards,
Jian
