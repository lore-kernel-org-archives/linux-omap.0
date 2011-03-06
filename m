From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH V3 03/19] OMAP3+: voltage: remove initial voltage
Date: Sun, 06 Mar 2011 16:37:08 +0300
Message-ID: <4D738E04.5090207@ru.mvista.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com> <1299338962-5602-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56891 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab1CFNib (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Mar 2011 08:38:31 -0500
Received: by fxm17 with SMTP id 17so3390147fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 06 Mar 2011 05:38:30 -0800 (PST)
In-Reply-To: <1299338962-5602-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hello.

On 05-03-2011 18:29, Nishanth Menon wrote:

> Blindly setting a 1.2V setting

    Hm, seems tautological...

> in the initial structure may not even
> match the default voltages stored in the voltage table which are
> supported for the domain. For example, OMAP3430 core domain does not
> use 1.2V and ends up generating a warning on the first transition.

> Further, since omap2_set_init_voltage is called as part of the pm
> framework's initialization sequence to configure the voltage required
> for the current OPP, the call does(and has to) setup the system
> voltage(curr_volt as a result) using the right mechanisms appropriate
> for the system at that point of time. This also overrides
> initialization we are currently doing in voltage.c making it
> redundant. So, remove the wrong and redundant initialization.

> Signed-off-by: Nishanth Menon<nm@ti.com>

WBR, Sergei
