From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/5] omap: add ocp2scp as a misc driver
Date: Wed, 30 May 2012 18:43:51 +0000
Message-ID: <201205301843.51568.arnd@arndb.de>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1338375394-16268-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 30 May 2012, Kishon Vijay Abraham I wrote:
> 
> This patch series is done as a preparatory step for adding phy drivers
> for dwc3 and musb.
> 
> This series adds a new driver for ocp2scp to which phy drivers are connected.
> 
> I'm planning to send phy drivers asap. Meanwhile I'd like to get some
> review comments for this series. I have also plans to send device tree
> adaptation of the ocp2scp driver.
> 
> Developed on
> http://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-next
> 
> If it has to be based on some other tree, please let me know.

This must be the most pointless driver I've seen in a long time. It doesn't
actually do anything at all, it just creates child devices from a static
lookup table.

Just put the devices you actually want into the device tree instead and
have them automatically created.

	Arnd
