From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] ASoC: pandora: switch clock back to internal on stop
Date: Sun, 19 Feb 2012 17:52:57 +0200
Message-ID: <CANOLnOO=UMKJ1CKXKzP5LC_rttxWYRo2yMe9M7PtSL7eV1+GxA@mail.gmail.com>
References: <1329604795-24509-1-git-send-email-notasas@gmail.com>
	<20120219063005.GA4517@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54447 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab2BSPw6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Feb 2012 10:52:58 -0500
Received: by iacb35 with SMTP id b35so6466161iac.19
        for <linux-omap@vger.kernel.org>; Sun, 19 Feb 2012 07:52:58 -0800 (PST)
In-Reply-To: <20120219063005.GA4517@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org

On Sun, Feb 19, 2012 at 8:30 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Feb 19, 2012 at 12:39:55AM +0200, Grazvydas Ignotas wrote:
>> For some reason, OMAP doesn't enter lower power states with function=
al
>> clock (CLKS) source set to external, so switch it back to internal w=
hen
>> done playing.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>
> Might be an idea to do this in the McBSP driver - have it do the swit=
ch
> transparently, then flip back when the port is brought up again?

Maybe, but I think pandora is the only one using external clock in
mainline and mcbsp currently doesn't track this state, just does a
register write. If you still prefer it on mcbsp side, I can do it
after Peter's mcbsp merge work is finished I guess.

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
