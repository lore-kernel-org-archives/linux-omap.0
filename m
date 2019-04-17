From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH 0/3] net: ethernet: ti: cpsw: Add XDP support
Date: Wed, 17 Apr 2019 20:49:39 +0300
Message-ID: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ilias.apalodimas@linaro.org, hawk@kernel.org, xdp-newbies@vger.kernel.org, ast@kernel.org, aniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

This patchset is RFC adding XDP support for TI cpsw driver that is
based on page_pool allocator. It was verified with af_xdp sockets
and on xdp drop. For XDP redirect to another interface it's under
verification, still not sure about all cases that should be verified.
Also regular tests with iperf2 were done in order to verify impact on
regular netstack performance, compared with base commit from
net-next/master: 432bc230700f86801cffa5e159e05dea6229f722

It was verified with following configs enabled:
CONFIG_JIT=y
CONFIG_BPFILTER=y
CONFIG_BPF_SYSCALL=y
CONFIG_XDP_SOCKETS=y
CONFIG_BPF_EVENTS=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_BPF_JIT=y
CONFIG_CGROUP_BPF=y

iperf2 UDP RX summary (packet size / Mbps):
+--------------------------------------------------------------+
| pkt_size/rate | 1024 | 1500 | 1470 |  64  | 128  | 512 | 256 |
|---------------+------+------+------+------+------+-----+-----|
| base commit   | 561  | 470  | 796  |  35  | 70.1 | 281 | 140 |
|---------------+------+------+------+------+------+-----+-----|
| XDP patched   | 563  | 455  | 808  |  35  | 70.2 | 282 | 141 |
+--------------------------------------------------------------+

iperf2 UDP TX summary (packet size / Mbps):
+--------------------------------------------------------------+
| pkt_size/rate | 1024 | 1500 | 1470 |  64  | 128  | 512 | 256 |
|---------------+------+------+------+------+------+-----+-----|
| base commit   | 555  | 666  | 736  | 34.5 | 70.3 | 281 | 140 |
|---------------+------+------+------+------+------+-----+-----|
| XDP patched   | 558  | 696  | 759  | 35.2 | 69.2 | 279 | 140 |
+--------------------------------------------------------------+

iperf2 TCP summary (window size / Mbps):
+------------------------------------------------------------+
| window size/rate |  16  |  32  |  64  |  128 |  8   | 256  |
|------------------+------+------+------+------+------+------|
| base commit      | 753  | 887  | 931  | 932  | 676  | 932  |
|------------------+------+------+------+------+------+------|
| XDP patched      | 823  | 888  | 932  | 933  | 669  | 933  |
+------------------------------------------------------------+

For af_xdp socket type verification several generic changes should be added
that can be seen here (rough fixes, for samples related seems like last version
of samples is more integrated with libbpf api, so should be rebased,
witch I will send as RFC separately):
https://github.com/ikhorn/af_xdp_stuff/tree/af_xdp_armv7

Ivan Khoronzhuk (3):
  net: ethernet: ti: davinci_cpdma: add dma mapped submit
  net: ethernet: ti: davinci_cpdma: return handler status
  net: ethernet: ti: cpsw: add XDP support

 drivers/net/ethernet/ti/Kconfig         |   1 +
 drivers/net/ethernet/ti/cpsw.c          | 552 +++++++++++++++++++++---
 drivers/net/ethernet/ti/davinci_cpdma.c | 117 +++--
 drivers/net/ethernet/ti/davinci_cpdma.h |   6 +-
 drivers/net/ethernet/ti/davinci_emac.c  |  18 +-
 5 files changed, 591 insertions(+), 103 deletions(-)

-- 
2.17.1
