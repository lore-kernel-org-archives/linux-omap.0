From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Tue, 25 Jan 2011 10:44:49 -0800
Message-ID: <AANLkTimAkfwKB2yt0h-tvgQpMMBHhxvRXEUnOnZLZdUV@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
	<20110124110609.GJ16202@n2100.arm.linux.org.uk>
	<20110124111114.GA19409@n2100.arm.linux.org.uk>
	<AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
	<20110125112946.GA13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:29224 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab1AYSox convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 13:44:53 -0500
Received: from kpbe19.cbf.corp.google.com (kpbe19.cbf.corp.google.com [172.25.105.83])
	by smtp-out.google.com with ESMTP id p0PIiq6V008402
	for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 10:44:52 -0800
Received: from qwe4 (qwe4.prod.google.com [10.241.194.4])
	by kpbe19.cbf.corp.google.com with ESMTP id p0PIioBA010806
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 10:44:51 -0800
Received: by qwe4 with SMTP id 4so111804qwe.15
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 10:44:50 -0800 (PST)
In-Reply-To: <20110125112946.GA13300@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 25, 2011 at 3:29 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 24, 2011 at 11:39:13PM -0800, Colin Cross wrote:
>> This doesn't work for oneshot timers if the TWD_TIMER_CONTROL regist=
er
>> gets reset by cpu idle between twd_set_mode and twd_set_next_event.
>> Shadowing ctrl in a percpu variable and rewriting it during every ca=
ll
>> to twd_set_next_event does work, but that's not much different, and =
a
>> little less efficient, than just saving and restoring the control an=
d
>> load registers in idle. =A0It does have the advantage that platforms
>> don't need any extra calls.
>
> BTW, do you think the patch is, nevertheless, an improvement and some=
thing
> we should do? =A0If so, please can I have your ack for it?

This patch does work after adding the missing clockevent broadcasts to
the Tegra idle driver, and allows me to remove all references to twd
registers in the idle and suspend code, so:
Acked-by: Colin Cross <ccross@android.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
