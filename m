From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] Add ability to set defaultless network device MAC addresses to deterministic computed locally administered values
Date: Fri, 29 Jun 2012 08:50:28 +0000
Message-ID: <201206290850.28541.arnd@arndb.de>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64746 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab2F2Iuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 04:50:32 -0400
In-Reply-To: <20120629054404.11091.31289.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org

On Friday 29 June 2012, Andy Green wrote:
> The following series adds some code to generate legal, locally administered
> MAC addresses from OMAP4 CPU Die ID fuse data, and then adds an api to
> devices.c allowing board files to register device paths for network devices
> that wish to use them.
> 
> On PandaBoard / ES, two devices have no board-level MAC either assigned by
> the manufacturer or stored on the board, the last patch in the series adds
> these device paths and gets them set when the network device is registered.
> 
> The patches are against today's linux-omap.
> 

I had already provided my

Acked-by: Arnd Bergmann <arnd@arndb.de>

when we discussed this last year, and Steven also gave his

Tested-by: Steven Rostedt <rostedt@goodmis.org>

I have one comment to the second patch, which is changed slightly
from the older version.

	Arnd
