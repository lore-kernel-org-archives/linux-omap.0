From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: receiving data from mcbsp1 in master mode
Date: Tue, 21 Aug 2012 16:42:19 +0300
Message-ID: <5033903B.8000009@ti.com>
References: <20120821074205.0a36f648@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41132 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750987Ab2HUNmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 09:42:24 -0400
Received: by wgbdr1 with SMTP id dr1so5562140wgb.24
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 06:42:22 -0700 (PDT)
In-Reply-To: <20120821074205.0a36f648@kemnade.info>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux-omap@vger.kernel.org

On 08/21/2012 08:42 AM, Andreas Kemnade wrote:
> Hi,
>=20
> I tried a couple of times with different kernels to use mcbsp1 of dm3=
730
> in master mode (so that it sends out clocks).
> The result always is that I can send data out. but arecord gets no in=
put. It
> waits for input but does not get anything, although clocks are genera=
ted,
> checked that with a scope.=20
>=20
> I even took a driver which works in master mode on another mcbsp and =
just changed
> the mcbsp number.
> What needs to be done to receive data from mcbsp1?

You should check the PIN mux configuration of McBSP1 FSR/CLKR pins. McB=
SP1 on
dm3730 have 6 pin configuration. I think the capture should work fine i=
f you
select the FSX as FSR source, and CLKX as CLKR source.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
