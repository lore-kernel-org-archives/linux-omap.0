From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH v2 0/2]
Date: Wed, 24 Sep 2014 09:55:20 +0200
Message-ID: <1411545322-22940-1-git-send-email-frans.klaver@xsens.com>
References: <20140923215831.GB651@kroah.com> <1411502080-19769-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140923215831.GB651@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 23, 2014 at 11:58 PM, Greg Kroah-Hartman wrote:
> So both would be needed to be backported to stable kernels?  Why not
> just do the fix first, then the cleanup afterward, to make backporting
> easier?

Sure thing. I read something about cleaning up first, then actually changing
stuff, but it doesn't really make sense to move bugs around before fixing them,
unless fixing them requires moving them around.

Anyway, here's the respin.

v1..v2:
  - swapped fix and cleanup to ease backporting

Frans Klaver (2):
  tty: omap-serial: fix division by zero
  tty: omap-serial: pull out calculation from baud_is_mode16

 drivers/tty/serial/omap-serial.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

-- 
2.1.0
