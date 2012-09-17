From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] drivers: bus: Move the OMAP interconnect driver to
 drivers/bus/
Date: Mon, 17 Sep 2012 14:51:28 -0700
Message-ID: <20120917215128.GF11762@atomide.com>
References: <1347614434-15938-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1347614434-15938-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120914 02:21]:
> OMAP interconnect drivers are used for the interconnect error handling.
> Since they are bus driver, lets move it to newly created drivers/bus.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Patch just moves OMAP interconnect drivers as is to the newly created
> driver/bus/* directory. Patch is generated against "arm-soc/drivers/ocp2scp"
> tree and test on all OMAP boards.

Great, looks like this should not conflict with other
omap patches queued, so Arnd should probably take this into
the bus branch:

Acked-by: Tony Lindgren <tony@atomide.com>
