From: kbuild test robot <lkp@intel.com>
Subject: [linux-next:master 13028/13492]
 drivers/net/ethernet/ti/davinci_cpdma.c:725:5: sparse: sparse: symbol
 'cpdma_chan_split_pool' was not declared. Should it be static?
Date: Wed, 10 Jul 2019 03:32:24 +0800
Message-ID: <201907100329.bQl3UgMB%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: kbuild-all@01.org, Grygorii Strashko <grygorii.strashko@ti.com>, Andrew Lunn <andrew@lunn.ch>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master
head:   4608a726c66807c27bc7d91bdf8a288254e29985
commit: 962fb618909ef64e0c89af5b79ba0fed910b78e3 [13028/13492] net: ethernet: ti: davinci_cpdma: allow desc split while down
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 962fb618909ef64e0c89af5b79ba0fed910b78e3
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/ti/davinci_cpdma.c:725:5: sparse: sparse: symbol 'cpdma_chan_split_pool' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
