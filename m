From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Tue, 12 Jul 2011 06:07:55 +0000
Message-ID: <20110712060755.GA18622@localhost.ucw.cz>
References: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
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
Cc: khilman@ti.com, santosh.shilimkar@ti.com, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed 2011-06-29 18:40:23, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Most of the ASM sleep code (in arch/arm/mach-omap2/sleep34xx.S)
> is copied to internal SRAM at boot and after wake-up from CORE OFF mode.
> However only a small part of the code really needs to run from internal SRAM.
> 
> This fix lets most of the ASM idle code run from the DDR
> in order to minimize the SRAM usage and the overhead in the code copy.

So... what do you plan to use sram for? Because I don't think the
speedup is worth the complexity...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
