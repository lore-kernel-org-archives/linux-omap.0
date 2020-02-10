From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: N900: Remove mmc1 "safety feature"? (was: Re: mmc0 on Nokia N900
 on Linux 5.4.18)
Date: Mon, 10 Feb 2020 21:45:20 +0200
Message-ID: <20200210194520.GD14939@darkstar.musicnaut.iki.fi>
References: <5362c659-120f-5247-aaa5-7916229300bc@wizzup.org>
 <20200208190448.GA12984@amd>
 <270f27c9-afd6-171d-7dce-fe1d71dd8f9a@wizzup.org>
 <1eac0db3-17ce-8ebd-4997-8b1c282126e4@wizzup.org>
 <20200208220621.GA18161@amd>
 <d2d6d6ac-c964-ac48-1616-6f1826219385@wizzup.org>
 <op.0fpbjlbwhxa7s4@supervisor.net28>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fgw22-4.mail.saunalahti.fi ([62.142.5.109]:22703 "EHLO
        fgw22-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727690AbgBJTpY (ORCPT
        <rfc822;linux-omap@vger.kernel.org>);
        Mon, 10 Feb 2020 14:45:24 -0500
Content-Disposition: inline
In-Reply-To: <op.0fpbjlbwhxa7s4@supervisor.net28>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arthur D." <spinal.by@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Hi,

On Sun, Feb 09, 2020 at 06:48:47AM +0300, Arthur D. wrote:
> I suppose the real life scenario would be:
> 
> 0. The OS runs on eMMC.
> 1. The user opens his phone back cover and inserts MicroSD card.
> 2. Kernel doesn't try to access the card until the cover is closed.
> 
> It seems wise to me: we don't want to damage user's data or hardware.
> Accessing data on unstable medium can't be considered safe.
> While the cover is open and user just inserted the microsd card everything
> can happen - the phone can be dropped, may be unstable contact to microsd
> while the user interacting it, etc.

If the cover is open, you should also avoid writing to flash or eMMC,
as the battery may get removed easily, and the end result can be bad.

A.
