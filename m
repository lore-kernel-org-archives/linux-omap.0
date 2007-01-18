From: Tony Lindgren <tony@atomide.com>
Subject: Re: early printk
Date: Thu, 18 Jan 2007 09:07:21 -0800
Message-ID: <20070118170721.GB14425@atomide.com>
References: <20070118101336.18C6B80778@linux.omap.com>
	<0AB0CB5257FF3C43A27E201CC8AADA8602D085A0@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <0AB0CB5257FF3C43A27E201CC8AADA8602D085A0@dnce02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Saint-Etienne, Eric" <e-saint-etienne@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Saint-Etienne, Eric <e-saint-etienne@ti.com> [070118 03:00]:
>   Hi,
> 
> I'm looking fwd to use an early printk for omap2 like it exists on other
> architectures.
> 
> Did someone already released an early-printk patch?

Do you mean something other than low level printk?

Low level printk should work, see CONFIG_DEBUG_LL and
CONFIG_OMAP_LL_DEBUG_UART1 (or 2 or 3).

Tony
