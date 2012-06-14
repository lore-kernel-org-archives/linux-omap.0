From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix TFP410 powerdown GPIO init
Date: Wed, 13 Jun 2012 23:58:57 -0700
Message-ID: <CA+Bv8XZHOhD1sdJvEzwwup+igWpkCf8twxWzrf2zhSd4_aj9MQ@mail.gmail.com>
References: <1339579215-24098-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52595 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752734Ab2FNG66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 02:58:58 -0400
Received: by lahd3 with SMTP id d3so1010411lah.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 23:58:57 -0700 (PDT)
In-Reply-To: <1339579215-24098-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Jason Kridner <jkridner@beagleboard.org>

On Wed, Jun 13, 2012 at 2:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
> remove custom PD GPIO handling for DVI output") moved TFP410 chip's
> powerdown-gpio handling from the board files to the tfp410 driver. One
> gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
> the Beagle board file. This causes the tfp410 driver to fail to request
> the gpio on Beagle, causing the driver to fail and thus the DVI output
> doesn't work.

Can you take the one I sent earlier instead?

http://www.spinics.net/lists/linux-omap/msg69913.html
