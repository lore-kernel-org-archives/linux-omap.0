From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 0/4] i2c: omap: patch series related to multimaster mode
Date: Fri, 21 Nov 2014 01:28:41 +0400
Message-ID: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Here is the patch series intended to improve stability of
i2c-omap driver in the i2c multimaster environments.

Tested on Beagleboard XM C.
For now all fine. No controller timeouts, no data corruptions.

Also impelemented i2c bus fault detection during startup and
after reset.

So, instead of the message "controller timeout" blaming IP,
you get "timeout waiting for bus ready".

What do think about it?

Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
