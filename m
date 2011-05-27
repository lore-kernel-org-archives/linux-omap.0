From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 08/13] OMAP2+: PM: provide the next timer event API to PM modules
Date: Fri, 27 May 2011 09:44:57 +0200
Message-ID: <BANLkTikx5Av97OzUE4Wum8K9n_Gz1choXg@mail.gmail.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
	<1305739950-11695-9-git-send-email-j-pihet@ti.com>
	<87sjs19iff.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48470 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab1E0Ho6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 03:44:58 -0400
Received: by qyg14 with SMTP id 14so828128qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 00:44:58 -0700 (PDT)
In-Reply-To: <87sjs19iff.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, May 27, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Provide omap_pm_tick_nohz_get_sleep_length_us so that the code
>> from the OMAP PM modules can use it.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> This patch is doing more than mentioned in the changelog.
Agree, there is a bit of clean-up/rework as well. Will re-organize.

=2E..

>
>> +#endif
>> +
>> +#ifdef CONFIG_NO_HZ
>> +unsigned long omap_pm_tick_nohz_get_sleep_length_us(void)
>> +{
>> + =A0 =A0 return ktime_to_us(tick_nohz_get_sleep_length());
>> +}
>> +EXPORT_SYMBOL(omap_pm_tick_nohz_get_sleep_length_us);
>> +#endif
>
> Usage of this is OMAP2-specific and needed for this very old, debug-o=
nly
> interface.
> =A0I was inspired by some of what you did in this series, and
> will attempt to make your life easier by just removing this code all
> together. =A0I just posted a series for that.
Only OMAP2 uses it currently but I think it is useful to have the time
to next tick available for debug purpose.
BTW this change implements it in a more generic way:
tick_nohz_get_sleep_length is generic and also used by e.g. cpuidle to
determine the next state to enter.

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
