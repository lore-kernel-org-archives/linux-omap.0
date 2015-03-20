From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Fri, 20 Mar 2015 15:10:04 +0200
Message-ID: <550C1C2C.5080204@ti.com>
References: <1426741501.10003.6.camel@midgaarde> <550AC256.4070509@ti.com> <CAAQQ3un3k-0nY8xaOXKbmCznOk69ZEhbWLd5ZZV1_=rQLOyspg@mail.gmail.com> <550AF7F6.7080200@ti.com> <1426786080.13824.23.camel@symus-gk-mint> <20150319185129.GZ2869@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43916 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbbCTNKM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 09:10:12 -0400
In-Reply-To: <20150319185129.GZ2869@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Greg Knight <g.knight@symetrica.com>
Cc: linux-spi@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 03/19/2015 08:51 PM, Mark Brown wrote:
> On Thu, Mar 19, 2015 at 01:28:00PM -0400, Greg Knight wrote:
>=20
>> Changing DMA_MIN_BYTES to, say, "dma_min_time_ms" sounds reasonable =
to
>> me. I don't know how to compute it completely accurately as some SPI
>=20
> You probably need both - there's often a hard limit where the FIFO si=
ze
> in the hardware becomes a limit for DMA as well as a soft limit on to=
p
> of that for performance reasons.

The FIFO is only going to be enabled when the DMA is used for transfer =
so we
should have some lower limit for the PIO/DMA threshold. The FIFO in McS=
PI is a
tricky one anyways, since it has only one FIFO but several channels and=
 the
=46IFO can be enabled for only one channel, if it is enabled for more c=
hannels
it is not going to be used by either channel.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
