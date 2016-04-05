From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] clk: ti: dflt: remove redundant unlikely
Date: Tue, 05 Apr 2016 14:30:15 -0700
Message-ID: <1459891815.6715.15.camel@perches.com>
References: <1459880937-22349-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459880937-22349-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2016-04-05 at 13:28 -0500, Suman Anna wrote:
> Commit 7aba4f5201d1 ("clk: ti: dflt: fix enable_reg validity check")
> fixed a validation check by using an IS_ERR() macro within the
> existing unlikely expression, but IS_ERR() macro already has an
> unlikely inside it, so get rid of the redundant unlikely macro
> from the validation check.
[]
> diff --git a/drivers/clk/ti/clkt_dflt.c b/drivers/clk/ti/clkt_dflt.c
[]
> @@ -222,7 +222,7 @@ int omap2_dflt_clk_enable(struct clk_hw *hw)
> =A0		}
> =A0	}
> =A0
> -	if (unlikely(IS_ERR(clk->enable_reg))) {
> +	if (IS_ERR(clk->enable_reg)) {
> =A0		pr_err("%s: %s missing enable_reg\n", __func__,
> =A0		=A0=A0=A0=A0=A0=A0=A0clk_hw_get_name(hw));
> =A0		ret =3D -EINVAL;

There are several of these:

$ git grep -n -E "likely.*\bIS_ERR\s*\(" *
drivers/clk/ti/clkt_dflt.c:225: if (unlikely(IS_ERR(clk->enable_reg))) =
{
drivers/md/dm-verity-fec.c:76:=A0=A0if (unlikely(IS_ERR(res))) {
drivers/md/dm-verity-fec.c:168:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0if (unlikely(IS_ERR(par)))
drivers/md/dm-verity-fec.c:253:=A0=A0=A0=A0=A0=A0=A0=A0=A0if (unlikely(=
IS_ERR(bbuf))) {
drivers/net/ethernet/broadcom/bnxt/bnxt.c:1109:=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (unlikely(IS_ERR(skb)))
drivers/net/ethernet/hisilicon/hns/hns_enet.c:1010:=A0=A0=A0=A0=A0if (u=
nlikely(!phy_dev) || IS_ERR(phy_dev))
drivers/net/ethernet/sun/ldmvsw.c:302:=A0=A0if (unlikely(IS_ERR(vp))) {
drivers/scsi/bnx2fc/bnx2fc_fcoe.c:2547: if (likely(!IS_ERR(thread))) {
drivers/scsi/bnx2i/bnx2i_init.c:431:=A0=A0=A0=A0if (likely(!IS_ERR(thre=
ad))) {
drivers/scsi/fcoe/fcoe.c:1263:=A0=A0if (likely(!IS_ERR(thread))) {
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c:1500:=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (likely(!IS_ERR(pfmr))) {
drivers/thermal/intel_powerclamp.c:541:=A0=A0=A0=A0=A0=A0=A0=A0=A0if (l=
ikely(!IS_ERR(thread))) {
drivers/thermal/intel_powerclamp.c:591:=A0=A0=A0=A0=A0=A0=A0=A0=A0if (l=
ikely(!IS_ERR(thread))) {
drivers/tty/serial/serial_core.c:2682:=A0=A0if (likely(!IS_ERR(tty_dev)=
)) {
fs/gfs2/dir.c:854:=A0=A0=A0=A0=A0=A0if (unlikely(dent =3D=3D NULL || IS=
_ERR(dent))) {
fs/ntfs/inode.c:2724:=A0=A0=A0if (unlikely(err || IS_ERR(m))) {
fs/ntfs/lcnalloc.c:744: if (likely(page && !IS_ERR(page))) {
fs/ntfs/mft.c:85:=A0=A0=A0=A0=A0=A0=A0if (likely(!IS_ERR(page))) {
fs/ntfs/mft.c:168:=A0=A0=A0=A0=A0=A0if (likely(!IS_ERR(m)))
fs/ntfs/mft.c:285:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (likely(=
!IS_ERR(m))) {
fs/ntfs/mft.c:1311:=A0=A0=A0=A0=A0if (unlikely(IS_ERR(rl) || !rl->lengt=
h || rl->lcn < 0)) {
fs/ntfs/mft.c:1742:=A0=A0=A0=A0=A0if (unlikely(IS_ERR(rl) || !rl->lengt=
h || rl->lcn < 0)) {
fs/ntfs/mft.c:1784:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (likely(!I=
S_ERR(rl2)))
fs/ntfs/namei.c:132:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (likely(!IS_=
ERR(dent_inode))) {
fs/ntfs/runlist.c:968:=A0=A0if (likely(!IS_ERR(old_rl)))
fs/ntfs/super.c:1492:=A0=A0=A0if (unlikely(IS_ERR(tmp_ino) || is_bad_in=
ode(tmp_ino))) {
net/ipv6/addrconf.c:3212:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i=
f (unlikely(IS_ERR(rt)))
net/kcm/kcmsock.c:1969: if (unlikely(IS_ERR(newfile))) {
net/openvswitch/datapath.c:1315:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0if (likely(!IS_ERR(reply))) {
net/socket.c:399:=A0=A0=A0=A0=A0=A0=A0if (likely(!IS_ERR(newfile))) {

Maybe a new checkpatch test like:
---
=A0scripts/checkpatch.pl | 7 +++++++
=A01 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e3d9c34..25e81b9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5734,6 +5734,13 @@ sub process {
=A0			}
=A0		}
=A0
+# check for IS_ERR with likely
+
+		if ($line =3D~ /\b((?:un)?likely)\s*\(\s*\!?\s*IS_ERR\s*\(/) {
+			WARN("IS_ERR_IS_UNLIKELY",
+			=A0=A0=A0=A0=A0"Using $1 isn't recommended as IS_ERR already uses u=
nlikely\n" . $herecurr);
+		}
+
=A0# check for semaphores initialized locked
=A0		if ($line =3D~ /^.\s*sema_init.+,\W?0\W?\)/) {
=A0			WARN("CONSIDER_COMPLETION",
