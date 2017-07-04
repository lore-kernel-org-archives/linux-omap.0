From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] ARM: add missing includes to header files
Date: Tue,  4 Jul 2017 15:25:40 +0200
Message-ID: <20170704132542.27644-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add two missing include directives to two header files to avoid
compile breakage when the required symbols have not already been
defined.

The missing SCU include broke compilation of the (not-yet-merged)
suspend support for am335x when !CONFIG_HAVE_ARM_SCU for example:

	https://lkml.kernel.org/r/20170704131441.GH27842@localhost

Johan


Johan Hovold (2):
  ARM: scu: add missing errno include
  ARM: pm: add missing types include

 arch/arm/include/asm/smp_scu.h | 1 +
 arch/arm/include/asm/suspend.h | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.13.2
