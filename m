From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: dmtimer: fix sleeping function called from
 invalid context
Date: Mon, 12 Dec 2011 19:49:05 -0600
Message-ID: <CAB-zwWg76+Si9BXsXQt6-ZL=VL7qJ5YPN5FSC-07y8J8GFX0ew@mail.gmail.com>
References: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
	<1322194370-8073-2-git-send-email-omar.ramirez@ti.com>
	<20111209213447.GB31337@atomide.com>
	<CAB-zwWjHPzTT5QYZt9DvDcM9ny5VML3mDw3-rQRuBr-fcxYMvQ@mail.gmail.com>
	<20111212230825.GJ32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57691 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753685Ab1LMBtH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 20:49:07 -0500
Received: by mail-ww0-f54.google.com with SMTP id dt13so11092684wgb.11
        for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 17:49:06 -0800 (PST)
In-Reply-To: <20111212230825.GJ32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Dec 12, 2011 at 5:08 PM, Tony Lindgren <tony@atomide.com> wrote=
:
=2E..
>> @@ -134,22 +134,13 @@ static void omap_dm_timer_reset(struct
>> omap_dm_timer *timer)
>> =A0int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>> =A0{
>> ...
>> - =A0 =A0 =A0 ret =3D omap_dm_timer_set_source(timer, OMAP_TIMER_SRC=
_32_KHZ);
>> ...
>>
>> All clocks requested are set to 32 KHz first, even with the current
>> approach, there exists another API to set a new source.
>>
>> To be honest I don't know why the clocks are set to 32 KHz first,
>> maybe the default call path for users should be:
>
> You need a functional clock for the timer registers to work
> I believe.

Sounds logic :)

>> omap_dm_timer_request
>
> Yes this would make sense. The omap_timer_list should be protected
> by a mutex. There should not be a need for spinlock there as
> omap_dm_timer_request should be only called during init. If that's
> not the case, the the driver using it is broken.

Ok, I made this patch thinking that 'request' could be called from any
context, but if that is not the case mutex should be fine.

>> omap_dm_timer_set_source (new explicit call)
>> omap_dm_timer_start
>
> Once the timer has been requested, there should not be a need
> for locking as there should be only one timer user using the
> timer specific registers.
>
>> And remove setting the source to 32 KHz by default in omap_dm_timer_=
request.
>
> That you may need to be able to do anything with the timer :)

Well the intention was for the user to call it explicitly so it didn't
look as a hard coded setting, but I can keep it.

IIUC, mutex should be held instead of spin lock, I can do the change
instead of this patch and see how it goes.

Thanks,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
