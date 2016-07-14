From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap2plus_defconfig fix for v4.8 merge window
Date: Thu, 14 Jul 2016 15:17:02 +0200
Message-ID: <6564922.rj3i88MBX8@wuerfel>
References: <20160711161112.GA28563@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160711161112.GA28563@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday, July 11, 2016 9:11:12 AM CEST Tony Lindgren wrote:
> A defconfig update for omap2plus_defconfig to fix changed USB
> Kconfig dependencies for v4.8 merge window. Otherwise things
> like USB Ethernet on omap3 beagle, omap4 panda and omap5-uevm
> won't work without manual configuration.
> 

Pulled into next/defconfig, thanks!

	Arnd
