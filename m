From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: serial: Fix the ocp smart idlemode handling
 bug
Date: Tue, 17 Apr 2012 12:43:14 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204171241230.29048@utopia.booyaka.com>
References: <1334339704-4554-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39013 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab2DQSnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 14:43:15 -0400
In-Reply-To: <1334339704-4554-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>

On Fri, 13 Apr 2012, Santosh Shilimkar wrote:

> The current serial UART code, while fidling with ocp idlemode bits,
> forget about the smart idle wakeup bit even if it is supported by
> UART IP block. This will lead to missing the module wakeup on OMAP's
> where the smart idle wakeup is supported.
> 
> This was the root cause of the console sluggishness issue, I have been
> observing on OMAP4 devices and also can be potential reason for some
> other UART wakeup issues.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

Of course, in the long term, these idlemode tweaking functions need to go 
through some kind of omap_bus/omap_device abstraction, since platform_data 
function pointers are going away with the DT conversion.  But since a 
decent omap_bus/omap_device is still a ways off, this is an important 
interim step.


- Paul
