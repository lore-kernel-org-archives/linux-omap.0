From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] clk: ti: Fix up error checks in set_rate (and div 0 error)
Date: Mon, 18 Aug 2014 11:56:53 -0500
Message-ID: <1408381015-16042-1-git-send-email-nm@ti.com>
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
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,
The following patches are based on v3.17-rc1
Prior to this series: http://slexy.org/view/s20QH6PW4x (notice the /0 div error spam at initial boot log)
After this series: http://slexy.org/view/s20tPNXPf4

Nishanth Menon (2):
  clk: ti: divider: Provide error check for incoming parameters in
    set_rate
  clk: ti: dra7-atl: Provide error check for incoming parameters in
    set_rate

 drivers/clk/ti/clk-dra7-atl.c |    6 +++++-
 drivers/clk/ti/divider.c      |    7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
1.7.9.5
