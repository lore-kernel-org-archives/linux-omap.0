From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: pandora: switch clock back to internal on stop
Date: Mon, 20 Feb 2012 11:52:44 +0200
Message-ID: <4F4217EC.7080806@ti.com>
References: <1329604795-24509-1-git-send-email-notasas@gmail.com> <20120219063005.GA4517@opensource.wolfsonmicro.com> <CANOLnOO=UMKJ1CKXKzP5LC_rttxWYRo2yMe9M7PtSL7eV1+GxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:50754 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751301Ab2BTJwl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Feb 2012 04:52:41 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so8242076lah.37
        for <linux-omap@vger.kernel.org>; Mon, 20 Feb 2012 01:52:40 -0800 (PST)
In-Reply-To: <CANOLnOO=UMKJ1CKXKzP5LC_rttxWYRo2yMe9M7PtSL7eV1+GxA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org

On 02/19/2012 05:52 PM, Grazvydas Ignotas wrote:
>> Might be an idea to do this in the McBSP driver - have it do the swi=
tch
>> transparently, then flip back when the port is brought up again?
>=20
> Maybe, but I think pandora is the only one using external clock in
> mainline

I have patch on top of the mcbsp merge series which allows users
(developers) to switch between McBSP2 master/slave configuration on
Beagle. It will have two PCM:
0 is the current configuration (twl4030 master, mcbsp2 slave)
1 is the same as with pandora (twl4030 slave, mcbsp2 master - CLKS pin
is the source for the SRG).
With this I can help to track down the suspend issue you see on Pandora=
=2E
I hope.

> and mcbsp currently doesn't track this state, just does a
> register write.

I was also thinking that this should be handled by the mcbsp driver.
I'm really not sure why we need to do this - it might be clock/hwmod
issue at the end.
We could do this unconditionally when all streams has been stopped on
the mcbsp port IMHO.

> If you still prefer it on mcbsp side, I can do it
> after Peter's mcbsp merge work is finished I guess.

I'll wait for Janusz for OMAP1 results before I send the v2 series.
So far so good: now the Pandora like configuration also works.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
