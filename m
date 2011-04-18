From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v9 4/9] OMAP3: PM: TWL4030 power scripts for OMAP3 boards
Date: Mon, 18 Apr 2011 18:25:09 +0530
Message-ID: <BANLkTinjkqmL5a2YQTnMYFSZt-11vRNy0w@mail.gmail.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
	<1302784077-16697-5-git-send-email-leslyam@ti.com>
	<20110418123240.GN12272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:35385 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751267Ab1DRMzM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 08:55:12 -0400
Received: by wwf26 with SMTP id 26so5315496wwf.8
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 05:55:09 -0700 (PDT)
In-Reply-To: <20110418123240.GN12272@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Tony,

On Mon, Apr 18, 2011 at 6:02 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> Hi,
>
> * Lesly A M <leslyam@ti.com> [110414 15:25]:
>> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_re=
set.
>>
>> TWL4030 power scripts which can be used by different OMAP3 boards
>> with the power companion chip (TWL4030 series).
>>
>> The twl4030 generic script can be used by any board file to update
>> the power data in twl4030_platform_data.
>>
>> http://omapedia.org/wiki/TWL4030_power_scripts
>>
>> Signed-off-by: Lesly A M <leslyam@ti.com>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: David Derrick <dderrick@ti.com>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>> =A0arch/arm/mach-omap2/twl4030-script.c | =A0331 +++++++++++++++++++=
+++++++++++++++
>> =A0arch/arm/mach-omap2/twl4030-script.h | =A0 23 +++
>> =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 33 +++-
>> =A03 files changed, 384 insertions(+), 3 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/twl4030-script.c
>> =A0create mode 100644 arch/arm/mach-omap2/twl4030-script.h
>
> To me it seems this should go into drivers/mfd instead.
> The script may contain omap specific values, but can be
> a loadable driver module.

- subsys_initcall(twl_init)
    -> twl_probe()
      -> twl4030_power_init()
        -> load_twl4030_script()  #to copy this script data to the PM I=
C.

Since this is getting called from a subsys initcall, not sure whether
we can make this scripts as loadable module.

>
> Maybe drivers/mfd/twl4030-script-omap.c?
Ok, fine

Regards,
Lesly A M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
