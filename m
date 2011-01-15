From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Open issues after 2.6.38 merge window
Date: Sat, 15 Jan 2011 10:49:37 +0530
Message-ID: <9ba47985064c771620bac3f4fce6a3b0@mail.gmail.com>
References: <20110114194758.GM4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:57534 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750739Ab1AOFTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jan 2011 00:19:39 -0500
Received: by mail-fx0-f44.google.com with SMTP id 9so3656477fxm.3
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 21:19:38 -0800 (PST)
In-Reply-To: <20110114194758.GM4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Saturday, January 15, 2011 1:18 AM
> To: linux-omap@vger.kernel.org
> Subject: Open issues after 2.6.38 merge window
>
> Hi all,
>
> Before I update out master branch, let's try to summarize the
> open issues after the merge window. Here's a list of issues
> in omap-fixes-for-linus that I'm aware of:
>

> - omap4430 es1.0 hangs if L2X0 cache is enabled
>
Will have look at this one on Monday

> - omap4 panda powers down after boot (watchdog?)
>
Must be watchdog

> - omap3 ldp board powers down after boot?
>
I guess this was already concluded as a watchdog issue.


> Any other issues?
>
I saw the build related pull request from you, so most
of those gets sorted out.

- !CONFIG_RUNTIME_PM, boot crash because of watchdog.

Posted the patch for this but I need to verify one scenario
pointed out by Paul Where if the boot-loader keeps watchdog
enabled.

- omap2plus_defconfig build break because of SWP_EMULATE
missing patch.

This one will gets fixed once the Catalin patch is merged

Regards,
Santosh
