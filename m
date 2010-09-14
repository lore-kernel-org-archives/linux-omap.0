From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP2+: GPIO: move late PM out of interrupts-disabled idle path
Date: Tue, 14 Sep 2010 07:41:03 -0700
Message-ID: <87fwxcwfpc.fsf@deeprootsystems.com>
References: <1284418958-5887-1-git-send-email-khilman@deeprootsystems.com>
	<1284418958-5887-3-git-send-email-khilman@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD25F71C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60732 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769Ab0INOlK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 10:41:10 -0400
Received: by gwj17 with SMTP id 17so2385456gwj.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 07:41:10 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F71C@dbde02.ent.ti.com>
	(Charulatha Varadarajan's message of "Tue, 14 Sep 2010 19:44:33
	+0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tero Kristo <tero.kristo@nokia.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

[...]

>> -void omap2_gpio_prepare_for_idle(int power_state)
>> +void omap2_gpio_prepare_for_idle(void)
>>  {
>> -	int i, c = 0;
>> -	int min = 0;
>> +	int i, c = 0, min = 0;
>> +	int per_next_state;
>> +
>> +	if (!per_pwrdm)
>> +		return;
>
> "per_pwrdm" is not available for OMAP24xx. Hence
> this breaks the omap2_gpio_prepare_for_idle() path for OMAP2.
>
> In OMAP2420, all gpio banks are in wakeup domain and
> in OMAP2430 GPIO banks 1-4 are in wakeup domain & GPIO5 is
> in core domain.

Sure, this patch is just a proof of concept that we can move the GPIO
idle management out of the interrupts disabled path.

When you adapt this approach to your conversion series, since you have
already broken these functions up to be per-bank, you can have a
per-bank powerdomain that can be configured per-SoC.

Kevin

