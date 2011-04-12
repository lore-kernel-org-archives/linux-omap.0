From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: pandaboard can't reboot on 2.6.38-rc2?
Date: Tue, 12 Apr 2011 10:28:00 +0530
Message-ID: <cac49110c8a25779b39fbf0f5808bdc7@mail.gmail.com>
References: <BANLkTikjyaA4mL-eWOcPse2T7NC2rbCfkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:32933 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078Ab1DLE6U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Apr 2011 00:58:20 -0400
Received: by mail-fx0-f52.google.com with SMTP id 6so6391014fxm.39
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 21:58:19 -0700 (PDT)
In-Reply-To: <BANLkTikjyaA4mL-eWOcPse2T7NC2rbCfkg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>, linux-omap@vger.kernel.org

Bob Liu wrote:
> Hi, folks
>
> I am using pandaboard and compiled a 2.6.38-rc2 kernel for it.
> Everything works fine except that it can't reboot.
>
> #reboot
> #
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to all processes
> Requesting system reboot
> [  120.742370] Restarting system.
>
> Then hanged...
>
> Has anyone seen similar problem?

As a quick workaround, turn off CONFIG_ARCH_OMAP2 and
rebuild the kernel. That should get you functional reboots.

Looks like something in the asm code is messed up when building
with OMAP2 support - I don't understand it well enough to solve
it, but maybe this is a data point for people that do know
the code better.

- Anand
