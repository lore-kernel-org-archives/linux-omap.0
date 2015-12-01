From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 3/7] ARM: davinci: make headers more local
Date: Tue, 1 Dec 2015 18:45:58 +0530
Message-ID: <565D9D8E.9090807@ti.com>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
 <1448924458-3279040-4-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448924458-3279040-4-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Wan ZongShun <mcuos.com@gmail.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Ungerer <gerg@uclinux.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 01 December 2015 04:30 AM, Arnd Bergmann wrote:
> Some header files are never included outside of a mach-davinci
> directory and do not need to be made visible in include/mach,
> so let's just move them all down one level.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Boot tested this on DM644x EVM too.

Thanks,
Sekhar
