From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 7/7] omap mailbox move to drivers for v3.11 merge window
Date: Fri, 21 Jun 2013 09:39:25 +0200
Message-ID: <201306210939.26007.arnd@arndb.de>
References: <0MFrZm-1V3qHW1bmA-00EJsa@mx.kundenserver.de> <201306202146.27093.arnd@arndb.de> <37C860A02101E749A747FA2D3C1E3C504CD3DD@DLEE11.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56996 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422753Ab3FUHjc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jun 2013 03:39:32 -0400
In-Reply-To: <37C860A02101E749A747FA2D3C1E3C504CD3DD@DLEE11.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anna, Suman" <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 21 June 2013, Anna, Suman wrote:
> Yes, we still have a plan for a generic subsystem, and these would form the
> the base patches of OMAP adaptation towards that. OMAP mailbox was disabled
> since couple of releases now because of the multi-platform enablement. There were
> couple of different work-items needed on OMAP mailbox like fixing the multi-platform,
> converting to DT and adapting to the new framework. The previous subsystem was
> derived of the OMAP mailbox, so the first and last items were kinda automatic. The
> newest one based on Jassi's work is not gonna reuse any OMAP stuff, so this series
> handles the first one to avoid a huge pending patchset for OMAP on the generic
> framework finalization.

Ok, thanks for the explanation. Please also see the other email thread
about the linux-next conflict.

	Arnd
