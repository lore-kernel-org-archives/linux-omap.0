From: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 0/2][RESEND] omap i2c interrupt handler fixes
Date: Wed, 16 Dec 2009 16:02:22 +0200
Message-ID: <1260972144-31593-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This is the second version of the patch that I've sent to linux-omap to
address this issue. This time I've moved the whole errata workaround bit
to a separate function to get rid of too long lines and a couple of extra
levels of indentation.

The actual fix is the same as the first time, it adds a timeout to a busy
loop which happens to take place in an interrupt handler and is capable
of hanging the kernel.

Regards,
--
Alex
