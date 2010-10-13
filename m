From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 4/4] Input: ads7846 - modificatons of _stop()/_disable() conditions
Date: Thu, 14 Oct 2010 01:17:26 +0300
Message-ID: <AANLkTi=0b-q3LK3-4mgdpSP7pScVSF1ZWzD45bLoAmJO@mail.gmail.com>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com>
	<1284634286-8871-4-git-send-email-jason77.wang@gmail.com>
	<1284634286-8871-5-git-send-email-jason77.wang@gmail.com>
	<201009162339.06395.dmitry.torokhov@gmail.com>
	<4C9332CE.6040905@gmail.com>
	<20100917160709.GC14186@core.coreip.homeip.net>
	<4C9718E9.5040104@gmail.com>
	<4CB4314C.7050308@gmail.com>
	<20101012160055.GA6355@core.coreip.homeip.net>
	<4CB523B7.8010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <4CB523B7.8010209@gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, vapier@gentoo.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 13, 2010 at 6:12 AM, Jason Wang <jason77.wang@gmail.com> wrote:
> Hi Dmitry,
>
> I have validated the new patch based off the 2.6.36-rc7 on
> the ti_omap3530evm, it works fine.

Working here on pandora too, applied on top of linux-next (did not
test suspend though).

Not caused by this patch, but the old problem where lower measurement
bits get lost is back - when I draw diagonal line it looks like
stairs. I think it's caused by OMAP SPI driver, CCing linux-omap.
