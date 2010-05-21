From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] gpiolib: introduce set_debounce method
Date: Fri, 21 May 2010 06:23:12 -0700 (PDT)
Message-ID: <663067.14695.qm@web180316.mail.gq1.yahoo.com>
References: <20100521064925.GF925@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100521064925.GF925@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org


> > Not all GPIOs have hardware debounce though, so
> offering this
> > capability sort of begs the question of where/how to
> provide a software debounce mechanism too...
> 
> how about adding a flag for supported features and if that
> hardware doesn't support we simply return,

Presense of a debounce method would suffice when gpiolib is
in use (vs direct implementation of the API provided by gpiolib).


> or fallback to
> software emulation if chosen by the user. 

ISTR that if you look back to the original discussion about
GPIO debouncing, you will find such a software implementation;
and maybe such an integration ... 
