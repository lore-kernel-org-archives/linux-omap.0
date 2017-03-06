From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: PM: Drop useless checks for PM_SUSPEND_STANDBY
Date: Mon, 6 Mar 2017 10:38:57 -0800
Message-ID: <20170306183856.GM20572@atomide.com>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
 <20170217164018.GE21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170217164018.GE21809@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Dinh Nguyen <dinguyen@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170217 08:41]:
> * Geert Uytterhoeven <geert+renesas@glider.be> [170217 08:12]:
> > 	Hi all,
> > 
> > The system suspend implementations for DaVinci, OMAP, and SoCFPGA use
> > the standard suspend_valid_only_mem() for their
> > platform_suspend_ops.valid() callbacks.  Hence their
> > platform_suspend_ops.enter() callbacks will never be called with state
> > equal to PM_SUSPEND_STANDBY, and checks for this can thus be removed.
> > 
> > Thanks for your comments!
> 
> Seems safe to remove:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Sounds like you wanted me to pick this up so applying the
omap related patch into omap-for-v4.12/soc.

Thanks,

Tony
