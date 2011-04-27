From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v9 4/9] OMAP3: PM: TWL4030 power scripts for OMAP3 boards
Date: Wed, 27 Apr 2011 18:29:08 +0530
Message-ID: <BANLkTikmm5cUhSagsWqPUAjgdQnjOy6W+A@mail.gmail.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
	<1302784077-16697-5-git-send-email-leslyam@ti.com>
	<20110418123240.GN12272@atomide.com>
	<BANLkTinjkqmL5a2YQTnMYFSZt-11vRNy0w@mail.gmail.com>
	<20110418125820.GO12272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46930 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756153Ab1D0M7K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Apr 2011 08:59:10 -0400
Received: by mail-ww0-f50.google.com with SMTP id 33so1657950wwc.31
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 05:59:09 -0700 (PDT)
In-Reply-To: <20110418125820.GO12272@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Tony,

On Mon, Apr 18, 2011 at 6:28 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Manuel, Lesly Arackal <leslyam@ti.com> [110418 15:52]:
>> >
>> > To me it seems this should go into drivers/mfd instead.
>> > The script may contain omap specific values, but can be
>> > a loadable driver module.
>>
>> - subsys_initcall(twl_init)
>> =A0 =A0 -> twl_probe()
>> =A0 =A0 =A0 -> twl4030_power_init()
>> =A0 =A0 =A0 =A0 -> load_twl4030_script() =A0#to copy this script dat=
a to the PM IC.
>>
>> Since this is getting called from a subsys initcall, not sure whethe=
r
>> we can make this scripts as loadable module.
>
> AFAIK it does not need to do anything that early. Maybe take a look
> at initialing it later?
>

The loading of script data & configuration of resource is one time proc=
ess,
later HW will take care(executing the sequence in TWL based on
sys_offmode, clk_req, ...signal states)

So any specific reason for making this twl script as loadable module?

Thanks & regards,
Lesly
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
