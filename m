From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/4] i2c: omap: patch series related to multimaster mode
Date: Sat, 22 Nov 2014 23:47:10 +0400
Message-ID: <1416685634-5864-1-git-send-email-al.kochet@gmail.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416518925-20679-1-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Here is the patch series intended to improve stability of
i2c-omap driver in the i2c multimaster environments.

Tested on Beagleboard XM C.
For now all fine. No controller timeouts, no data corruptions.

Also impelemented i2c bus fault detection during startup and
after reset.

So, instead of the message "controller timeout" blaming IP,
you get "timeout waiting for bus ready".

Rebased against i2c/for-next (eb61694b43dea0d43ea2574e7d48f476a6bdffb0)

Tested on the kernel from angstrom-v2013.06-yocto1.4
Kernel recepie linux-mainline_3.2.bb
git://github.com/Angstrom-distribution/meta-ti.git; branch angstrom-staging-yocto1.4
With all i2-omap.c patches backported from upstream linux/master

Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Alexander Kochetkov (4):
  i2c: omap: cleanup register definitions
  i2c: omap: implement workaround for handling invalid BB-bit values
  i2c: omap: don't reset controller if Arbitration Lost detected
  i2c: omap: add notes related to i2c multimaster mode

 drivers/i2c/busses/i2c-omap.c |  131 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 6 deletions(-)

-- 
1.7.9.5
