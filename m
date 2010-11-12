From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 0/1] Put the OMAP2 SPI CS in inactive state when returning
 from suspend
Date: Fri, 12 Nov 2010 17:45:16 +0100
Message-ID: <4CDD6F1C.7030809@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44447 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641Ab0KLQpZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 11:45:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general <spi-devel-general@lists.sourceforge.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@deeprootsystems.com>

We notice that when system wake up from OFF mode, then CS is in inactive 
state until the first SPI transfer.
For our design it lead to some conflict on this I/O.
Inactive state for CS when there is no transfer should be the correct 
behavior: this is the purpose of these patches.

* Change from v2:
Use directly resume function of spi_master instead of using function 
from spi_device as Grant Likely pointed it out.
Force this transition explicitly for each CS used by a device.


Gregory CLEMENT (1):
   OMAP2: Spi: Force CS to be in inactive state after off-mode
     transition

  drivers/spi/omap2_mcspi.c |   29 +++++++++++++++++++++++++++++
  1 files changed, 29 insertions(+), 0 deletions(-)

