From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Thu, 8 Nov 2012 12:54:23 -0600
Message-ID: <509BFFDF.9040605@ti.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il> <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41990 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920Ab2KHSy1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Nov 2012 13:54:27 -0500
In-Reply-To: <509B666F.6080507@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>


On 11/08/2012 01:59 AM, Igor Grinberg wrote:

[snip]

> There is no reliable way to determine which source should be used in runtime
> for boards that do not have the 32k oscillator wired.

So thinking about this some more and given that we are moving away from
board files, if a board does not provide a 32kHz clock source, then this
should be reflected in the device-tree source file for that board.
Hence, at boot time we should be able to determine if a 32kHz clock
source can be used.

Cheers
Jon
