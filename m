From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix TFP410 powerdown GPIO init
Date: Thu, 14 Jun 2012 00:59:22 -0700
Message-ID: <CA+Bv8XbwWbdTFFo9KHoOk7Tq8XBWDOWhkEqq7Pz6by_8sE_ngA@mail.gmail.com>
References: <1339579215-24098-1-git-send-email-tomi.valkeinen@ti.com>
	<CA+Bv8XZHOhD1sdJvEzwwup+igWpkCf8twxWzrf2zhSd4_aj9MQ@mail.gmail.com>
	<1339658290.2236.5.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63502 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab2FNH7X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 03:59:23 -0400
Received: by lbbgm6 with SMTP id gm6so1831569lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 00:59:22 -0700 (PDT)
In-Reply-To: <1339658290.2236.5.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Jason Kridner <jkridner@beagleboard.org>

On Thu, Jun 14, 2012 at 12:18 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Wed, 2012-06-13 at 23:58 -0700, Russ Dill wrote:
>> On Wed, Jun 13, 2012 at 2:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> > Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
>> > remove custom PD GPIO handling for DVI output") moved TFP410 chip's
>> > powerdown-gpio handling from the board files to the tfp410 driver. One
>> > gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
>> > the Beagle board file. This causes the tfp410 driver to fail to request
>> > the gpio on Beagle, causing the driver to fail and thus the DVI output
>> > doesn't work.
>>
>> Can you take the one I sent earlier instead?
>>
>> http://www.spinics.net/lists/linux-omap/msg69913.html
>
> Hmm, that probably doesn't apply. The power-down GPIO is now handled in
> the tfp410 driver, not in the board files.

Give me a branch to rebase it onto and I will.

> Looking more closely at the board file, what are these nDVI_PWR_EN,
> DVI_LDO_EN and DVI_PU gpios? There's no "enable line" on tfp410. Only
> the power-down gpio, which is none of the above...

On my schematic, DVI_LDO_EN is labeled more sanely, DVI_PU. I'm not
sure of the history of that. My patch does remove any reference to
DVI_LDO_EN.

nDVI_PWR_EN is labeled AUX_3V3_DIS on my schematic. AUX_3V3_DIS is
connected to the disable pin of an LDO that provides power for the DVI
transceiver.
