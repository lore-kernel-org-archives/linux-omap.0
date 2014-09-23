From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 0/2] Fix a division by zero
Date: Tue, 23 Sep 2014 21:54:38 +0200
Message-ID: <1411502080-19769-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Greg,

Here's a couple of patches that fix a divison by zero in omap-serial.c. One's a
cleanup, the other the actual fix.

Thanks,
Frans

Frans Klaver (2):
  tty: omap-serial: pull out calculation from baud_is_mode16
  tty: omap-serial: fix a division by zero

 drivers/tty/serial/omap-serial.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

-- 
2.1.0
