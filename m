From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/3] EDAC: TI: add support for DRA7 and keystone EDAC
Date: Tue, 7 Nov 2017 22:38:56 +0200
Message-ID: <1510087139-21885-1-git-send-email-t-kristo@ti.com>
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
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-edac@vger.kernel.org, bp@alien8.de, mchehab@kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

The EMIF controller on certain TI SoCs has ECC support capability.
This series adds support for this on dra7xx and keystone2 variants
of the SoCs. DTS nodes are only added for keystone2 devices, as these
can be tested with upstream right now. DRA7xx support will be added
once the specific boards that actually support ECC are posted upstream.

Tested the ECC support on keystone-k2g-evm against 4.14-rc1, injecting
1 and 2 bit errors from u-boot. Below log with 2 bit error injected at
the beginning of the SDRAM.

<snip>
root@k2g-evm:~# insmod /lib/modules/4.14.0-rc1-00003-gf5201bf/kernel/drivers/eda
c/ti_edac.ko
[   32.559025] EDAC MC0: Giving out device to module ti_edac controller ti,emif-
keystone: DEV 21010000.emif (INTERRUPT)
[   32.599088] EDAC MC0: 1 UE ti,emif-keystone on mc#0memory#0 (memory:0 page:0x
0 offset:0x0 grain:4 - 2B)
<snip>

Boot tested on keystone-k2e/l/hk also just to make sure there are no
issues (the driver is not enabled in keystone config by default either.)

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
