From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/10] ARM: OMAP2+: SmartReflex: move the platform
 specific macros in plat-omap
Date: Thu, 15 Mar 2012 10:14:00 -0700
Message-ID: <20120315171359.GA7276@atomide.com>
References: <1331829845-9526-1-git-send-email-j-pihet@ti.com>
 <1331829845-9526-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1331829845-9526-3-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jean.pihet@newoldbits.com
Cc: Kevin Hilman <khilman@ti.com>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [120315 09:47]:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Move the platform specific macros from the smartreflex header file
> (arch/arm/mach-omap2/smartreflex.h) in a new header file in plat-omap
> (arch/arm/plat-omap/include/plat/smartreflex.h).
> 
> This change makes the SmartReflex implementation ready for the move
> to drivers/.

Glad to see this happening!

This would be better located in linux/power/smartreflex.h rather than
plat/smartreflex.h.

Regards,

Tony
