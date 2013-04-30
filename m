From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Latest build results - errors/warnings - lots of them
Date: Tue, 30 Apr 2013 09:17:39 +0100
Message-ID: <20130430081739.GP14496@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Latest nightly build of 3.9+my for-next+arm-soc's for-next results in a
great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the biggest
source of errors.

OMAP stuff needs a serious look at too - much Kconfig madness there
caused by over-use of select, which then goes on to cause build errors
because it assumes some stuff is always enabled.

There's also warnings about of_device_id from include/linux/of_platform.h
via from arch/arm/kernel/setup.c which feature in all the non-OF builds
too which need addressing.

See todays http://www.arm.linux.org.uk/developer/build/ results for all
the details and configs.  Not pushing my tree until some of this stuff
gets fixed.
