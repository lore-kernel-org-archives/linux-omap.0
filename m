From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC] ETM/JTAG components states across OFF modes
Date: Mon, 3 May 2010 06:54:57 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203BADA0745@dlee02.ent.ti.com>
References: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44159 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab0ECLzF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 07:55:05 -0400
In-Reply-To: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "virtuoso@slind.org" <virtuoso@slind.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>

Hi Alex,

> From: virtuoso@slind.org [mailto:virtuoso@slind.org]
> Sent: Saturday, May 01, 2010 12:38 PM

Do you have a web viewable git tree where your full patch is applied? Or could you send me on the side files?

Main bit I was looking to check was that you have bug fix which came late in my original hack where a failed OFF mode needs to unlock the coresight registers at the fall through of WFI.

> I've finally got around to doing this. This is a rework of the previously
> posted [1] patch that implements ETM and JTAG context saving. There are
> two major changes since previous version:
>   * coresight OS save/restore mechanism is used for saving the ETM context,
>     so that it actually occupies ~54 words on omap3_arm_context instead of
>     128;

Seems you found some nice optimization.  I was thinking first patch was doing this in part.  You read from a port address and it gives you internal registers as necessary. You written them back to port for restore.

I came up with context size simply by inspecting # of times loop was necessary and looking at values written to save areas.  I assume you would have done something similar to determine size.

>   * a sysfs file is used to control if the ETM/JTAG context should be saved
>     in OFF mode.

Neat.  This is much more friendly then a recompile.

Regards,
Richard W.


