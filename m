From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: critical DRA7xx fix for v4.5-rc
Date: Mon, 7 Mar 2016 09:38:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603070933530.3437@utopia.booyaka.com>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tony,

These changes should go upstream immediately.

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.5-rc/omap-critical-fixes-a

for you to fetch changes up to 0f514e690740e54815441a87708c3326f8aa8709:

  ARM: dts: dra7: do not gate cpsw clock due to errata i877 (2016-03-07 01:41:22 -0700)

- ----------------------------------------------------------------
ARM: OMAP2+: critical DRA7xx fix for v4.5-rc

Force the DRA7xx Ethernet internal clock source to stay enabled
per TI erratum i877:

http://www.ti.com/lit/er/sprz429h/sprz429h.pdf

Otherwise, if the Ethernet internal clock source is disabled, the
chip will age prematurely, and the RGMII I/O timing will soon
fail to meet the delay time and skew specifications for 1000Mbps
Ethernet.

This fix should go in as soon as possible.

Basic build, boot, and PM test results are available here:

http://www.pwsan.com/omap/testlogs/omap-critical-fixes-for-v4.5-rc/20160307014209/

- ----------------------------------------------------------------
Lokesh Vutla (1):
      ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property

Mugunthan V N (1):
      ARM: dts: dra7: do not gate cpsw clock due to errata i877

 Documentation/devicetree/bindings/arm/omap/omap.txt |  1 +
 arch/arm/boot/dts/dra7.dtsi                         | 10 ++++++++++
 arch/arm/mach-omap2/omap_hwmod.c                    |  9 ++++++++-
 arch/arm/mach-omap2/omap_hwmod.h                    |  3 +++
 4 files changed, 22 insertions(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3UviAAoJEMePsQ0LvSpLo3oP/1nTp6CbW4EHPkzHrsp4jvIR
971ajUKhWOvitk3iHD30WBLI71XsXKe8D73tMy8saTIH+T8wvhT50yAVLN+uY/6w
c76xQAoTb8f20YYGfhE1x/cFWwXffnxfUj3/ablCVOrGCx6umhhQ84Q4IgnD5pG+
bvh+wfMkvewn1ua47x0/YjS9N1e2sojRmKLny4iTEweuMy7CBTwMjS5V8EgbRNFz
sDbnmh3i/9ynRDE+vqdwmjz5QFl+avOd+DJf3asP5Tqzhj57y1t65Vc3E7g8xkDJ
qH4eQZz4hZilCNC0mdEn1BQ4PNcOKVRDJuozoLS+m+6TMgFIIJlmJHiyKgZQI/ca
YgYzfjlbL76nZylQL1+vSAq/e6XM9VimSTQx1oNT7fXwyuzNETj5Ez6KxroYky3o
+RJIsjCqeW4XF+J289dDPDH41r+D3MhsGw6o4Jhl0BXfM7YN/IvTlhuxmK3IjrHq
AHoH9R9EK7G5kKQAE5Qpk9cxCSgYCRcPcagmfnIBEfzKsGxH4D8HDYDJC+QkqEkE
UV5ia/VWuwINmOYpDxqxP1sv++KIctO0S9Is1P8hTfrb9o/gnn+Zivr/Q3g/WQOZ
wgJ1olcAERjKGg/djTWbcOtcFSeyVb3YIgcWZjze8yCPuaSzrddeLpnsXSf1Xm5P
kK4C6wqZu8tCDYCEXOel
=bwpu
-----END PGP SIGNATURE-----
