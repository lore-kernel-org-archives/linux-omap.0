From: "Khasim, Syed" <x0khasim@ti.com>
Subject: RE: [PATCH] Alsa modularisations and support for tsc2101 6/7
Date: Wed, 1 Mar 2006 16:28:32 -0600
Message-ID: <2B486F5800B5A8428350207E391C3BEB021BDC29@dlee03.ent.ti.com>
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
To: "Menon, Nishanth" <x0nishan@ti.com>, lamikr@cc.jyu.fi
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

clk_get_rate("sys_ck") should return the sys clock.

Regards,
Khasim

-----Original Message-----
From: linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com]
On Behalf Of Menon, Nishanth
Sent: Wednesday, March 01, 2006 4:18 PM
To: lamikr@cc.jyu.fi
Cc: OMAP-Linux
Subject: RE: [PATCH] Alsa modularisations and support for tsc2101 6/7

Hi,

I thought there should be clk apis to do the job. Pls check
include/asm-arm/hardware/clock.h, clk_get_rate api

Regards,
Nishanth Menon

> -----Original Message-----
> From: lamikr [mailto:lamikr@cc.jyu.fi]
> Sent: Wednesday, March 01, 2006 4:10 PM
> To: Menon, Nishanth
> Cc: OMAP-Linux
> Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 6/7
>=20
> Menon, Nishanth wrote:
>=20
> >+#define CODEC_CLOCK 12000000
> >
> >+#define AUDIO_MCBSP OMAP_MCBSP1
> >
> >we should be quering the sysclk for figuring out the codec_clk. some
> boards such as sdp2430 have an interesting property of being able to
> provide 12/13mhz clk to the codec.. and hardcoding mcbsp1 wil have
> portability issues on omap2420 does this belong to platform structure?
> >
> >
> Hi Menon!
>=20
> Do you know how to do that easily dynamically? It seems that the value
> is often hardcoded in clock.c.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
