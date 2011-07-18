From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 3/6] regulator: omap smps regulator driver
Date: Mon, 18 Jul 2011 16:40:33 -0700
Message-ID: <87ipqzkvim.fsf@ti.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
	<1311010522-5868-4-git-send-email-t-kristo@ti.com>
	<20110718182218.GJ25081@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:53980 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751854Ab1GRXkg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jul 2011 19:40:36 -0400
Received: by mail-iw0-f172.google.com with SMTP id 39so3839272iwn.31
        for <linux-omap@vger.kernel.org>; Mon, 18 Jul 2011 16:40:35 -0700 (PDT)
In-Reply-To: <20110718182218.GJ25081@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Mon, 18 Jul 2011 21:22:19 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com

Felipe Balbi <balbi@ti.com> writes:

> On Mon, Jul 18, 2011 at 08:35:19PM +0300, Tero Kristo wrote:
>> diff --git a/drivers/regulator/omap-smps-regulator.c b/drivers/regulator/omap-smps-regulator.c
>> new file mode 100644
>> index 0000000..8b56e4f
>> --- /dev/null
>> +++ b/drivers/regulator/omap-smps-regulator.c
>> @@ -0,0 +1,179 @@
>> +/*
>> + * omap-vp-regulator.c -- support SMPS regulators for OMAP chips
>
> name is wrong here.

In fact, just leave filenames out of file headers all together to avoid
this kind of problem.

Kevin
