From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 0/5] i2c: omap: new fixes 2
Date: Wed,  3 Dec 2014 18:33:57 +0400
Message-ID: <1417617242-16869-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This pacth series intended for fixing problem reported
by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> here[1]

One of first four patched could fix the problem.
Last patch provide event trace so I could resolve problem.
It could be applied using 'git am' or 'patch -p1 ...'

Patches are rebased on branch 'i2c/for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
(6e79807443cba7397cd855ed29d6faba51d4c893)

Tony, could you check, does the series fix the problem reported[1]?
If yes, could you bisect and point commit that solve.
If no, could you provide trace output (with or without the patches
from series).
If no, could you check does i2c-omap.c from commit ca1f8da9ac5ce6e63d8f6933f83fabc1f3f961f4.
(the commit before my changes to kernel) work for you?

Thank you.

Regards,
Alexander.

[1] http://www.spinics.net/lists/linux-i2c/msg17811.html

Alexander Kochetkov (5):
  i2c: omap: ack only reported events
  i2c: omap: simplify i462 errata handling for NACK and AL cases
  i2c: omap: move STP generation logic into ISR thread
  i2c: omap: reimpelement STP hack via 2-phases transfer
  i2c: omap: add trace

 drivers/i2c/busses/i2c-omap.c |  162 ++++++++++++++++++++++++-----------------
 1 file changed, 95 insertions(+), 67 deletions(-)

-- 
1.7.9.5
