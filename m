From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v6 0/2] Add generic PHY support to USB HCD
Date: Wed, 24 Sep 2014 23:03:29 +0400
Message-ID: <37148636.BU5lT4M4eC@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: linux-sh@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, Peter.Chen@freescale.com, stern@rowland.harvard.edu, swarren@wwwdotorg.org, thierry.reding@gmail.com, balbi@ti.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, antoine.tenart@free-electrons.com
List-Id: linux-omap@vger.kernel.org

Hello.

   This patchset is against the usb-next' branch of Greg KH's 'usb.git' repo.
Here I add support for the generic PHY to the 'struct usb_hcd' (having to
rename the existing 'phy' field to 'usb_phy' beforehand). This was mainly
intended to be used with the PCI OHCI/EHCI drivers and also xHCI driver;
however there are several more dependent patchsets now posted to 'linux-usb'.

[1/2] usb: rename phy to usb_phy in HCD
[2/2] usb: hcd: add generic PHY support

WBR, Sergei
