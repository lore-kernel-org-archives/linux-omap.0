From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 net-next 0/4]  net: ethernet: ti: cpsw: Add XDP support
Date: Tue, 25 Jun 2019 20:59:44 +0300
Message-ID: <20190625175948.24771-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, hawk@kernel.org, brouer@redhat.com, saeedm@mellanox.com, leon@kernel.org
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

This patchset adds XDP support for TI cpsw driver and base it on
page_pool allocator. It was verified on af_xdp socket drop,
af_xdp l2f, ebpf XDP_DROP, XDP_REDIRECT, XDP_PASS, XDP_TX.

It was verified with following configs enabled:
CONFIG_JIT=y
CONFIG_BPFILTER=y
CONFIG_BPF_SYSCALL=y
CONFIG_XDP_SOCKETS=y
CONFIG_BPF_EVENTS=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_BPF_JIT=y
CONFIG_CGROUP_BPF=y

Link on previous v3:
https://lkml.org/lkml/2019/6/5/446

Also regular tests with iperf2 were done in order to verify impact on
regular netstack performance, compared with base commit:
https://pastebin.com/JSMT0iZ4

v3..v4:
- added page pool user counter
- use same pool for ndevs in dual mac
- restructured page pool create/destroy according to the last changes in API

v2..v3:
- each rxq and ndev has its own page pool

v1..v2:
- combined xdp_xmit functions
- used page allocation w/o refcnt juggle
- unmapped page for skb netstack
- moved rxq/page pool allocation to open/close pair
- added several preliminary patches:
  net: page_pool: add helper function to retrieve dma addresses
  net: page_pool: add helper function to unmap dma addresses
  net: ethernet: ti: cpsw: use cpsw as drv data
  net: ethernet: ti: cpsw_ethtool: simplify slave loops


Based on net-next/master

Ivan Khoronzhuk (4):
  net: core: page_pool: add user cnt preventing pool deletion
  net: ethernet: ti: davinci_cpdma: add dma mapped submit
  net: ethernet: ti: davinci_cpdma: return handler status
  net: ethernet: ti: cpsw: add XDP support

 .../net/ethernet/mellanox/mlx5/core/en_main.c |   8 +-
 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/cpsw.c                | 536 ++++++++++++++++--
 drivers/net/ethernet/ti/cpsw_ethtool.c        |  25 +-
 drivers/net/ethernet/ti/cpsw_priv.h           |   9 +-
 drivers/net/ethernet/ti/davinci_cpdma.c       | 123 +++-
 drivers/net/ethernet/ti/davinci_cpdma.h       |   8 +-
 drivers/net/ethernet/ti/davinci_emac.c        |  18 +-
 include/net/page_pool.h                       |   7 +
 net/core/page_pool.c                          |   7 +
 net/core/xdp.c                                |   3 +
 11 files changed, 640 insertions(+), 105 deletions(-)

-- 
2.17.1
