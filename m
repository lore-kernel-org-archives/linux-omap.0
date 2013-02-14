From: Roger Quadros <rogerq@ti.com>
Subject: [GIT PULL] usb: bug fixes for ehci-omap for 3.9
Date: Thu, 14 Feb 2013 14:14:11 +0200
Message-ID: <511CD513.5030100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Balbi, Felipe" <balbi@ti.com>, Roger Quadros <rogerq@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, stable@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Greg,

This pull request contains 2 bug fixes for ehci-omap for 3.9 as well
as older kernels. It is based on 3.8-rc6.

Please pull. Thanks.

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:
  git://github.com/rogerq/linux.git usbhost17-for-usb

Roger Quadros (2):
      USB: ehci-omap: Don't free gpios that we didn't request
      USB: ehci-omap: Fix autoloading of module

 drivers/usb/host/ehci-omap.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

--
cheers,
-roger
