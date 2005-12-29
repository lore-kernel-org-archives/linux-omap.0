From: Paul Mundt <paul.mundt@nokia.com>
Subject: Re: gpio interrupt support
Date: Thu, 29 Dec 2005 23:41:02 +0200
Message-ID: <20051229214102.GA9174@nokia.com>
References: <20051229212506.GA30537@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051229212506.GA30537@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Brian Swetland <swetland@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 29, 2005 at 01:25:06PM -0800, Brian Swetland wrote:
> I need to handle interrupts from omap gpios... it looks like there's
> code for (most of?) this in plat-omap/gpio.c, but the interrupt related
> functions are static and not exported.  Is this functionality incomplete
> or is there some other way to register gpio interrupt handlers that I'm
> overlooking?
> 
Sounds like OMAP_GPIO_IRQ() is probably what you are after. Look at
plat-omap/gpio-switch.c as an example.
