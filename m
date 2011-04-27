From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v9 6/9] MFD: TWL4030: workaround changes for TWL4030
 Erratum 27
Date: Wed, 27 Apr 2011 19:54:24 +0530
Message-ID: <BANLkTi=fokShu_ZyK6uMZ2mf5Pe4=P9+9Q@mail.gmail.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
	<1302784077-16697-7-git-send-email-leslyam@ti.com>
	<20110426101306.GJ2659@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:40143 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751167Ab1D0OY0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Apr 2011 10:24:26 -0400
Received: by wwb28 with SMTP id 28so1775791wwb.3
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 07:24:24 -0700 (PDT)
In-Reply-To: <20110426101306.GJ2659@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Samuel,

On Tue, Apr 26, 2011 at 3:43 PM, Samuel Ortiz <sameo@linux.intel.com> w=
rote:
> Hi Lesly,
>
> On Thu, Apr 14, 2011 at 05:57:54PM +0530, Lesly A M wrote:
>> Workaround for TWL5030 Silicon Errata 27 & 28:
>> =A0 =A0 =A0 27 - VDD1, VDD2, may have glitches when their output val=
ue is updated.
>> =A0 =A0 =A0 28 - VDD1 and / or VDD2 DCDC clock may stop working when=
 internal clock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 is switched from internal to external.
>>
>> Erratum 27:
>> =A0 =A0 =A0 If the DCDC regulators is running on their internal osci=
llator,
>> =A0 =A0 =A0 negative glitches may occur on VDD1, VDD2 output when vo=
ltage is changed.
>> =A0 =A0 =A0 The OMAP device may reboot if the VDD1 or VDD2 go below =
the
>> =A0 =A0 =A0 core minimum operating voltage.
>>
>> =A0 =A0 =A0 WORKAROUND
>> =A0 =A0 =A0 Set up the TWL5030 DC-DC power supplies to use the HFCLK=
IN instead of
>> =A0 =A0 =A0 the internal oscillator.
>>
>> Erratum 28:
>> =A0 =A0 =A0 VDD1/VDD2 clock system may hang during switching the clo=
ck source from
>> =A0 =A0 =A0 internal oscillator to external. VDD1/VDD2 output voltag=
es may collapse
>> =A0 =A0 =A0 if clock stops.
>>
>> =A0 =A0 =A0 WORKAROUND
>> =A0 =A0 =A0 If HFCLK is disabled in OFFMODE, modify the sleep/wakeup=
 sequence and
>> =A0 =A0 =A0 setuptimes to make sure the switching will happen only w=
hen HFCLKIN is stable.
>> =A0 =A0 =A0 Also use the TWL5030 watchdog to safeguard the first swi=
tching from
>> =A0 =A0 =A0 internal oscillator to HFCLKIN during the TWL5030 init.
>>
>> =A0 =A0 =A0 IMPACT
>> =A0 =A0 =A0 power sequence is changed.
>> =A0 =A0 =A0 sleep/wakeup time values will be changed.
>>
>> The workaround changes are called from twl4030_power_init(), since w=
e have to
>> make some i2c_read calls to check the TWL4030 version & the i2c will=
 not be
>> initialized in the early stage.
>>
>> This workaround is required for TWL5030 Silicon version less than ES=
1.2
>> The power script & setup time changes are recommended by TI HW team.
>>
>> http://omapedia.org/wiki/TWL4030_power_scripts
>>
>> Changes taken from TWL4030 Erratum 27 workaround patch by Nishanth M=
enon.
> This patch and the following one depend on patch#4. Please re-send it=
 once you
> agreed with Tony about where it should go.
>

I will make the changes for Tony's comments and repost the patches.

Thanks & Regards,
Lesly A M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
