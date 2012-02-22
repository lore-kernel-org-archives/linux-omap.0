From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv10 3/4] omap3: add common twl configurations for vdd1 and vdd2
Date: Wed, 22 Feb 2012 11:16:42 -0800
Message-ID: <8739a21xwl.fsf@ti.com>
References: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
	<1329733568-26676-4-git-send-email-t-kristo@ti.com>
	<871upn4tzf.fsf@ti.com> <1329907675.4102.488.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:35158 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753213Ab2BVTQc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 14:16:32 -0500
Received: by mail-pw0-f50.google.com with SMTP id wy7so451745pbc.9
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 11:16:31 -0800 (PST)
In-Reply-To: <1329907675.4102.488.camel@sokoban> (Tero Kristo's message of
	"Wed, 22 Feb 2012 12:47:55 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> On Tue, 2012-02-21 at 16:00 -0800, Kevin Hilman wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>> 
>> > VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
>> > to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
>> > are needed by DVFS.
>> >
>> > Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data manuals:
>> > - SWCS019L : TWL4030 ES3.1 Data Manual rev L
>> > - SWCS030E : TWL5030 ES1.2 Data Manual rev E
>> >
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> 
>> Do you have a similar patch for OMAP4 support?
>
> It looks like OMAP4 support requires some changes to the twl-regulator /
> twl-core in addition to the twl-common.c. I have these available (just
> created them), should I post these out? 

Yes please.

> Attached here for reference in case you need to test something
> quickly.

Thanks, it's easier for me to validate actual voltage scaling on OMAP4
since I have a setup to easily measure voltage rails.

Thanks for these, I verified they work using my v2 CPUfreq driver on
OMAP4430.

Kevin

