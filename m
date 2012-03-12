From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/6] gpio/omap: Some more driver cleanup and fixes
Date: Mon, 12 Mar 2012 11:42:34 -0700
Message-ID: <87wr6py82t.fsf@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
	<CAMQu2gzdfxJms8cc3VhsVzhGq4f8x1QeY6LU6X+2eFZ4_Yv_bw@mail.gmail.com>
	<20120312173425.A6B893E07B0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:56256 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751921Ab2CLSm2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 14:42:28 -0400
Received: by iaoo28 with SMTP id o28so7934124iao.26
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 11:42:26 -0700 (PDT)
In-Reply-To: <20120312173425.A6B893E07B0@localhost> (Grant Likely's message of
	"Mon, 12 Mar 2012 11:34:25 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

> On Thu, 23 Feb 2012 17:56:33 +0530, "Shilimkar, Santosh" <santosh.shi=
limkar@ti.com> wrote:
>> On Thu, Feb 23, 2012 at 5:40 PM, Tarun Kanti DebBarma
>> <tarun.kanti@ti.com> wrote:
>> > The cleanup is mostly getting rid of redundant fields in struct gp=
io_bank{}
>> > as we already have them as part of bank->context now. Also, remove=
 un-used
>> > variable from gpio_irq_handler.
>> >
>> > The fix include correction of _set_gpio_irqenable() implementation=
 and fix
>> > type mismatch of gpio trigger parameter.
>> >
>> > It is baselined on top of Kevin's following series:
>> > gpio/omap: cleanup and runtime PM conversion for v3.4
>> > git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-p=
m.git for_3.4/gpio/runtime-pm-cleanup
>> >
>> > I have applied Benoit's GPIO patches in following series on top of=
 Kevin's
>> > before applying my changes.
>> > gpio/omap: Cleanup and adaptation to Device Tree
>> > git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-=
dt.git for_3.4/dt_gpio
>> >
>> > Series is available here for reference:
>> > git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-lin=
ux-omap-dev for_3.4/gpio_further_cleanup_fixes
>> >
>> > Power Test: Off-mode and Retention on OMAP3430 (Suspend and Idle p=
aths).
>> > Functional Test: OMAP2430, OMAP3430SDP, ZOOM3, OMAP4430, OMAP4-BLA=
ZE
>> >
>> > Tarun Kanti DebBarma (6):
>> > =C2=A0gpio/omap: remove saved_fallingdetect, saved_risingdetect fi=
elds
>> > =C2=A0gpio/omap: remove saved_wakeup field from struct gpio_bank
>> > =C2=A0gpio/omap: remove suspend_wakeup field from struct gpio_bank
>> > =C2=A0gpio/omap: get rid of retrigger variable in gpio_irq_handler
>> > =C2=A0gpio/omap: fix trigger type to unsigned
>> > =C2=A0gpio/omap: fix _set_gpio_irqenable implementation
>> >
>> > =C2=A0drivers/gpio/gpio-omap.c | =C2=A0 56 +++++++++++++++++++----=
----------------------
>> > =C2=A01 files changed, 24 insertions(+), 32 deletions(-)
>> >
>> Nice clean-up series. I have gone through this series one more time
>> Thanks for updating change-logs. I noticed you dropped the edge trig=
gered
>> irq wakeup fix....I see on the list now.... Kevin has fixed that alr=
eady.
>>=20
>> Series looks good to me. You can add:
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> What's the status of this series?  Should I be expecting a v2?  Or am=
 I supposed
> to pick up this one? (a pull req would make things easier for me)

I haven't been through this one yet.

You can expect a pull req from me when ready.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
