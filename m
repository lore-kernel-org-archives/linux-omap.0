From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH] ARM OMAP2 GPMC undefines DEBUG
Date: Thu, 12 Feb 2015 18:13:29 +0100
Message-ID: <1423761210-24452-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
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
To: linux-kernel@vger.kernel.org
Cc: linux@arm.linux.org.uk, tony@atomide.com, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The GPMC driver in OMAP2 undef's DEBUG, which makes it unnecessarily hard to turn DEBUG on,
because that's not expected behavior.
My proposed patch gets rid of the line undef'ing DEBUG.

Robert ABEL (1):
  ARM OMAP2 GPMC: don't undef DEBUG

 arch/arm/mach-omap2/gpmc.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.3.0
