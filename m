From: Paul Mundt <paul.mundt@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: OMAP_GPIO_SWITCH doesn't need OMAP_BOOT_TAG
Date: Wed, 17 May 2006 20:35:53 +0300
Message-ID: <20060517173553.GA4172@nokia.com>
References: <20060517172547.GA3778@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060517172547.GA3778@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, May 17, 2006 at 06:25:47PM +0100, Jonathan McDowell wrote:
> I can't see any reason why OMAP_GPIO_SWITCH depends on OMAP_BOOT_TAG;
> it compiles fine without it. This patch removes the Kconfig dependency.
> 
It doesn't depend on it specifically itself, no, so I suppose dropping
the dependency is fine.

> Also the description is wrong; it doesn't hook into the input layer at
> all from what I can tell. Are there patches around that add this? The
> Amstrad Delta has a phone hook on a GPIO that I plan to support with
> this driver and being able to produce a keypress would be nice.
> 
May as well just remove 'input layer' from the description, it was a
legacy thing..

> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> 
Acked-by: Paul Mundt <paul.mundt@nokia.com>
