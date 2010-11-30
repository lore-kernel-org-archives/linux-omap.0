From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Tue, 30 Nov 2010 14:20:21 -0800
Message-ID: <AANLkTi=73VQeBj_M_PJO5OzJJDgWOXHkw31tN4z-nqMu@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
 <1290526740-27624-2-git-send-email-ohad@wizery.com> <20101130190058.GX17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101130190058.GX17222@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 11:00 AM, Tony Lindgren <tony@atomide.com> wrote:
> Do we even need the hwspin_lock variants,

I personally don't have any specific use case in mind.

It's just a simple wrapper over the _timeout variants, provided for
API completeness, but -

> why can't we always use the hwspin_lock_timeout variants?

We can. I can just remove the _lock variants.
