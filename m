From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv10 3/4] omap3: add common twl configurations for vdd1 and vdd2
Date: Tue, 21 Feb 2012 16:00:52 -0800
Message-ID: <871upn4tzf.fsf@ti.com>
References: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
	<1329733568-26676-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:37238 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753618Ab2BVAAn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 19:00:43 -0500
Received: by mail-pz0-f50.google.com with SMTP id d2so5746533dal.9
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 16:00:42 -0800 (PST)
In-Reply-To: <1329733568-26676-4-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 20 Feb 2012 12:26:07 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
> to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
> are needed by DVFS.
>
> Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data manuals:
> - SWCS019L : TWL4030 ES3.1 Data Manual rev L
> - SWCS030E : TWL5030 ES1.2 Data Manual rev E
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Do you have a similar patch for OMAP4 support?

Kevin
