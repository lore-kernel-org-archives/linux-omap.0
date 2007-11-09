From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Re-enable watchdog menuconfig
Date: Fri, 9 Nov 2007 09:32:21 +0000
Message-ID: <20071109093221.GA376@flint.arm.linux.org.uk>
References: <6E3DC4E6E09EF440B55B7AD683608D6D02540D07@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <6E3DC4E6E09EF440B55B7AD683608D6D02540D07@dlee13.ent.ti.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: "Kamat, Nishant" <nskamat@ti.com>
Cc: Linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 08, 2007 at 02:43:48PM -0600, Kamat, Nishant wrote:
> After the movement of drivers/char/watchdog directory to drivers/watchdog,
> the following patch is necessary to view the WATCHDOG option in 'make
> menuconfig'
> for ARM platforms.

Already merged a fix for this on the 7th.  For future reference, please
ensure that your mail client sensibly wraps lines.  This is especially
important for patch descriptions, lest you want Linus to moan at you.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
