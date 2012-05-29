From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for save_secure_all
Date: Tue, 29 May 2012 15:48:10 -0500
Message-ID: <CAOMWX4c7dP92BB=gtmGdRmOz+5-BNd4e5z+96OBjgZGEdCDbQA@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-15-git-send-email-t-kristo@ti.com> <871umj4qnl.fsf@ti.com>
 <1337593097.28274.19.camel@sokoban> <87pq9mg2w4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:41696 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751380Ab2E2Ush (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 16:48:37 -0400
Received: by wgbdr1 with SMTP id dr1so3628185wgb.12
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 13:48:31 -0700 (PDT)
In-Reply-To: <87pq9mg2w4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: t-kristo@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

On Tue, May 29, 2012 at 3:15 PM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> On Wed, 2012-05-16 at 17:06 -0700, Kevin Hilman wrote:
>>> +Benoit
>>>
>>> Tero Kristo <t-kristo@ti.com> writes:
>>>
>>> > save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
>>> > otherwise the secure ROM code will crash.
>>> >
>>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>
>>> I think I mentioned this already (I'm already lost in what I've said for
>>> thisseries), but I don't think the secure RAM stuff belongs in the
>>> wakeupgen driver.
>>
>> As mentioned, save_secure_all saves:
>> - secure RAM
>> - GIC registers
>> - some other mysterious stuff
>>
>> Attempting to do separate saves for secure RAM + GIC hang the device
>> during wakeup, in addition to being really inefficient (secure API calls
>> are expensive.)
>
> I guess my comment wasn't that this isn't needed, but that it doesn't
> seem to belong in the wakeupgen base (which should probably converted
> into a real driver.)
>
> Seems better to have this stuff in the secure code, maybe omap-secure.c?
>

Perhaps OFF mode notifier might help best here. In addition - it might
be safer to protect all calls with clkdm_wakeup around
secure_dispatcher instead of just the save_secure_all.. ROM code is
not smart enough around it.
an completely safe version used by security driver can be found here:
http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=security/smc/tf_comm_mshield.c;h=b5279fef0fa400438a57b3941af13d965e983bf0;hb=p-android-omap-3.0#l253


this is what the production kernels have used in the past.
Regards,
Nishanth Menon
