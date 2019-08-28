From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/4] more ti-sysc driver changes for v5.4
Date: Wed, 28 Aug 2019 11:34:50 -0700
Message-ID: <pull-1567016893-318461@atomide.com-2>
References: <pull-1567016893-318461@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1567016893-318461@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit c8a738f4cfaeccce40b171aca6da5fc45433ce60:

  bus: ti-sysc: remove set but not used variable 'quirks' (2019-08-13 04:40:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.4/ti-sysc-part2-signed

for you to fetch changes up to 7edd00f71f4b91ca31dbfa08926495fe5e77aab4:

  bus: ti-sysc: Detect d2d when debug is enabled (2019-08-26 08:33:25 -0700)

----------------------------------------------------------------
more ti-sysc driver changes for omap variants for v5.4

Few changes mostly to deal with sgx SoC glue quirk for omap36xx that
is needed for the related sgx SoC glue dts branch. The other changes
are to simplify sysc_check_one_child() sysc_check_children() to be void
functions, and detect d2d module when debugging is enabled.

----------------------------------------------------------------
Nishka Dasgupta (1):
      bus: ti-sysc: Change return types of functions

Tony Lindgren (2):
      bus: ti-sysc: Add module enable quirk for SGX on omap36xx
      bus: ti-sysc: Detect d2d when debug is enabled

 drivers/bus/ti-sysc.c                 | 45 ++++++++++++++++++++++-------------
 include/linux/platform_data/ti-sysc.h |  1 +
 2 files changed, 30 insertions(+), 16 deletions(-)
