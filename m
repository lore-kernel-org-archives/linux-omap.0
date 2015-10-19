From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [BISECTED] Nokia 770 framebuffer breakage
Date: Mon, 19 Oct 2015 22:37:59 +0300
Message-ID: <20151019193759.GE31069@blackmetal.musicnaut.iki.fi>
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
To: Russell King <rmk+kernel@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Somewhere between 4.1 .. 4.3-rc6 framebuffer on Nokia 770 stopped working.

Bisection points to:

commit 2568999835d7797afce3dcc3a3f368051ffcaf1f
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Mon Mar 2 15:40:29 2015 +0000

    clkdev: add clkdev_create() helper

The commit cannot be reverted cleanly from current trees, but I re-tested
that commit 2568999835d7797afce3dcc3a3f368051ffcaf1f does not work and
commit 2568999835d7797afce3dcc3a3f368051ffcaf1f^1 indeed works.

A.
