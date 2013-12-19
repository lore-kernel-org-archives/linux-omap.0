From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 00/49] ARM: TI SoC clock DT conversion
Date: Thu, 19 Dec 2013 13:23:31 +0200
Message-ID: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
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
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

So, once again new series. I guess I should have addressed all comments
for v10 except the extern sharing of __clk_of_table. Based on discussion
with Mike, this should be fine to fix later.

Main changes compared to v10:
- rebased on top of 3.13-rc4
- applied clk_desc support from Mike, did some cleanups and additions to that
  * needed for below item, clk_ll_ops
- added support for clk_ll_ops, and removed SoC wide clock ops
  * used for wrapping the IP block specific register access routines now
- removed need for separate init function types because of above two points,
  TI clocks also use the standard prototype now, no return value needed
- cleaned up the init retry logic for TI clocks a bit (DPLL/APLL)
- added clocks {} and clockdomains {} nodes under the master clock IP nodes,
  which are used to group clocks and domains accordingly
- changed compatible strings for clock master IPs from ti,clock-master to
  something of form ti,omap4-prm etc.

omap3 legacy clock data is not removed with this series, this can be done
later (basically I want someone to test all the possible omap3 boards out
there with DT boot before attempting this.)

Testing done:
- omap3-beagle: boot, suspend-resume (ret), suspend-resume (off)
- omap4-panda-es: boot, suspend-resume (ret)
- omap5-uevm: boot
- dra7-evm: boot
- am335x-bone: boot

Branches again available here:
https://github.com/t-kristo/linux-pm.git

branch: 3.13-rc4-dt-clks-v11 : contains everything, shall me merged last
branch: 3.13-rc4-dt-clks-v11-for-mike : drivers/clk changes
branch: 3.13-rc4-dt-clks-v11-for-benoit : DT data only

-Tero
