From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: AMx3xx: Allow low level debugging on all UARTs
Date: Wed, 22 Jun 2016 03:04:46 -0700
Message-ID: <20160622100444.GH22406@atomide.com>
References: <20160621120758.28732-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160621120758.28732-1-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, nm@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [160621 05:10]:
> AM33xx/AM43xx Soc has 6 UART interfaces. Any of these 6 UARTs can be used as
> serial console as defined by the specific board design and passing a proper
> console bootarg. Given this, we should be able to use any UART(that is
> used as serial console) for low level debugging. Currently only UART1 can
> be used for low level debugging. So, adding support for all other UARTs
> instead of waiting for new board with a different UART console.

Well we should just switch over to the standard 8250 debug code
instead. With multiarch the port detection for debug_ll port is
no longer needed. And we can still keep the Kconfig options for
various ports.

Regards,

Tony
