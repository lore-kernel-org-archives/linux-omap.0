From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] shutdown machine when li-ion battery goes below 3V
Date: Mon, 24 Oct 2016 14:29:33 -0700
Message-ID: <20161024212932.uhjz752z2cy5hohl@atomide.com>
References: <20161024212250.GA31336@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161024212250.GA31336@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [161024 14:24]:
> Hi!
> 
> What about something like this? N900 will drain the battery down to
> system crash, which is quite uncool.

Can't we make that generic and configurable for the voltage somehow?

Also, the shutdown voltage can depend on external devices connected.
It could be for example 3.3V depending on eMMC on some devices while
devices with no eMMC could have it at 3.0V.

Regards,

Tony
