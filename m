From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/2] power: twl4030_charger: cleanup to handle various
 battery handling error conditions
Date: Wed, 28 May 2014 16:46:48 -0500
Message-ID: <1401313610-14252-1-git-send-email-nm@ti.com>
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
To: dbaryshkov@gmail.com, tony@atomide.com
Cc: Nishanth Menon <nm@ti.com>, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This issue was originally reported by Russell on OMAP3-LDP platform,
and original attempt to solve this by Felipe[1] did not quiet work,
follow on attempt[2] seems to be effective, but in this resend, I have
added an shutdown attempt in case things dont quiet look right.

Based on: v3.15-rc7

Tests:
ldp boot with battery: http://slexy.org/raw/s20StiV4xr
ldp boot with a/c charger, no battery: http://slexy.org/raw/s2UfjIkZKG
ldp boot with a/c charger+battery, remove battery: http://slexy.org/raw/s2yFTVlrWJ
	^^ <- this is not exactly a safe test to perform :)..

Nishanth Menon (2):
  power: twl4030_charger: detect battery presence prior to enabling    
    charger
  power: twl4030_charger: attempt to power off in case of critical
    events

 drivers/power/twl4030_charger.c |   70 +++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 6 deletions(-)

[1] https://patchwork.kernel.org/patch/4002371/
[2] https://patchwork.kernel.org/patch/4124751/
-- 
1.7.9.5
