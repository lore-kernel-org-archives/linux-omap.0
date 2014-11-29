From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 0/2] i2c: omap: new fixes for driver
Date: Sun, 30 Nov 2014 01:00:01 +0400
Message-ID: <1417294803-14729-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The first patch fix i2c-omap driver for omap2420, found by code review and
later reported by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> here[1].
Candidate for stable?

The second patch unhide the reson of system lockup.

The patch is rebased on branch 'i2c/for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
(6e79807443cba7397cd855ed29d6faba51d4c893)

Tony, could you check, what the patches fix the problem reported[1]?
Kevin, could you run tests for patches on all omap boards?

Regards,
Alexander.

[1] http://www.spinics.net/lists/linux-i2c/msg17811.html

Alexander Kochetkov (2):
  i2c: omap: fix buffer overruns during RX/TX data processing
  i2c: omap: show that the reason of system lockup is an unhandled ISR
    event

 drivers/i2c/busses/i2c-omap.c |   64 ++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 14 deletions(-)

-- 
1.7.9.5
