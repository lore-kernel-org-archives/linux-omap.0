From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG] PandaBoard hangs before starting init while booting v3.12
Date: Mon, 18 Nov 2013 10:57:23 -0800
Message-ID: <20131118185722.GS10317@atomide.com>
References: <87hab9agjr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17056 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751469Ab3KRS51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 13:57:27 -0500
Content-Disposition: inline
In-Reply-To: <87hab9agjr.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Ben Gamari <bgamari.foss@gmail.com> [131118 07:14]:
> I'm having difficulty getting a PandaBoard ES rev. B1 to boot v3.12 and
> linux-next (30121118). I'm booting with a brand new u-boot
> (c2e5e802ecb7ab668ce9911b210ed68c804b349f).
> 
> In both cases the device appears to hang shortly before one would expect
> init to start as seen in the boot output below. I'm booting with the
> omap4-panda-es devicetree. As far as I can tell, the machine is
> completely dead and will not respond to even sysrq. I have a PandaBoard
> A4 which apparently has no trouble with the same kernel image.

Do you have the same version of u-boot in both cases?

Regards,

Tony
