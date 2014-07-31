From: Jeremy Vial <jvial@adeneo-embedded.com>
Subject: [PATCH 0/2] Manage OMAP34xx ES3.1.2 rev to resume from suspend
Date: Thu, 31 Jul 2014 15:10:32 +0200
Message-ID: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
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
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

My kernel crashed when my OMAP34xx ES3.1.2 leave suspend mode. The first
patch seems to solve the issue, and the second one corrects Linux kernel
coding style problems.

Jeremy Vial (2):
  ARM: OMAP3: Fix choice of omap3_restore_es function in OMAP34XX
    rev3.1.2 case.
  ARM: OMAP3: Fix coding style problems in
    arch/arm/mach-omap2/control.c

 arch/arm/mach-omap2/control.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.9.5
