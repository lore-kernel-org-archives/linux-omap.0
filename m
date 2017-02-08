From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Wed, 8 Feb 2017 13:32:34 -0800
Message-ID: <20170208213234.GC21809@atomide.com>
References: <20170203230950.24176-1-tony@atomide.com>
 <20170203230950.24176-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170203230950.24176-3-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170203 15:11]:
> We can get quite a few interrupts when the battery is trickle charging.
> Let's enable PM runtime autosuspend to avoid constantly toggling device
> driver PM runtime state.

This patch still has some funky runtime PM error handling as discussed
in the v3 patches, will post v4 later today.

Regards,

Tony
