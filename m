From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 7/7] OMAP2+: devices: Remove all omap_device_pm_latency
	structures
Date: Wed, 31 Aug 2011 15:31:12 -0700
Message-ID: <87sjoh6wnj.fsf@ti.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
	<1314026347-21623-8-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314026347-21623-8-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 22 Aug 2011 17:19:07 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Benoit Cousson <b-cousson@ti.com> writes:

> Remove all these duplicated structures since a default one is now
> available.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c    |   46 +++----------------------------------
>  arch/arm/mach-omap2/display.c    |   11 +--------
>  arch/arm/mach-omap2/dma.c        |   11 +--------
>  arch/arm/mach-omap2/gpio.c       |   12 +---------
>  arch/arm/mach-omap2/hsmmc.c      |   18 +--------------
>  arch/arm/mach-omap2/hwspinlock.c |   12 +---------
>  arch/arm/mach-omap2/mcbsp.c      |   11 +--------
>  arch/arm/mach-omap2/serial.c     |   25 +-------------------
>  arch/arm/mach-omap2/sr_device.c  |   11 +--------
>  arch/arm/mach-omap2/usb-musb.c   |   11 +--------
>  arch/arm/plat-omap/i2c.c         |   10 +-------
>  11 files changed, 14 insertions(+), 164 deletions(-)

Nice!  queuing this for v3.2 (branch: for_3.2/omap_device)

Kevin
