From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH 5/7] ARM: w90x900: make headers more local
Date: Thu, 3 Dec 2015 16:23:20 +0800
Message-ID: <CAKT61h-_rpT0O06ruUbtUPj2FPf57gLpWhyUKE-zFdVpCDg-yA@mail.gmail.com>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
 <1448924458-3279040-6-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448924458-3279040-6-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Ungerer <gerg@uclinux.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

2015-12-01 7:00 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> Some header files are never included outside of a mach-w90x900
> directory and do not need to be made visible in include/mach,
> so let's just move them all down one level.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Wan Zongshun <mcuos.com@gmail.com>

Thanks!

> ---
>  arch/arm/mach-w90x900/cpu.c                           | 4 ++--
>  arch/arm/mach-w90x900/{include/mach => }/regs-ebi.h   | 0
>  arch/arm/mach-w90x900/{include/mach => }/regs-gcr.h   | 0
>  arch/arm/mach-w90x900/{include/mach => }/regs-timer.h | 0
