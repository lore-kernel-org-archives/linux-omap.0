From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
Date: Mon, 30 Jul 2012 15:35:50 +0100
Message-ID: <20120730143550.GF7405@n2100.arm.linux.org.uk>
References: <CAAwP0s2jTPM_ErDOFKXoe95_Xd=xjkuTAsDbLctQ08_QVNkakQ@mail.gmail.com> <5012CC98.60206@ti.com> <20120727204447.GA10024@mudshark.cambridge.arm.com> <20120727210637.GA16377@n2100.arm.linux.org.uk> <20120727214024.GA10249@mudshark.cambridge.arm.com> <20120728100831.GC7405@n2100.arm.linux.org.uk> <20120728121103.GA11370@mudshark.cambridge.arm.com> <CABxcv=mVKt8+gYK6kHydmG3SnDZgjMbJuEcUBx_z5sumNY_SQw@mail.gmail.com> <20120729213125.GD7405@n2100.arm.linux.org.uk> <CABxcv=mSEEUbvMWS+JzjuPOWq9J7kNzvSyQRZibUXzNXstuV3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51840 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516Ab2G3OgD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 10:36:03 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=mSEEUbvMWS+JzjuPOWq9J7kNzvSyQRZibUXzNXstuV3A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Will Deacon <will.deacon@arm.com>, Jon Hunter <jon-hunter@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jul 30, 2012 at 11:22:51AM +0200, Javier Martinez Canillas wrote:
> Yes, I forgot it, sorry for that.
> 
> Please let me know if I need to resubmit the patch cc'ing stable.

I can just add it to the commit.
