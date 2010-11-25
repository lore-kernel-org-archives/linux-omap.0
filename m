From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Wed, 24 Nov 2010 19:59:37 -0800 (PST)
Message-ID: <536589.12568.qm@web180310.mail.gq1.yahoo.com>
References: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: MugdhaKamoolkar <mugdha@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, BenoitCousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, HariKanigeri <h-kanigeri2@ti.com>, SumanAnna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

My rule of thumb is that nothing is "generic"
until at least three whatever-it-is instances
plug in to it.  Sometimes this is called
the "Rule of Three".

Other than OMAP, what's providing hardware
spinlocks that plug into this framework?

- Dave
