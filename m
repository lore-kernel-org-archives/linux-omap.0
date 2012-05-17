From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 03/19] ARM: OMAP4: PM: Add device-off support
Date: Thu, 17 May 2012 12:40:59 +0530
Message-ID: <CAMQu2gzwwVNVbNob4k-DXj04Hj4NgW9FuT0JQbvf7wOBkhf9CQ@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-4-git-send-email-t-kristo@ti.com> <87obpn92jy.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:45082 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761020Ab2EQHLU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 03:11:20 -0400
Received: by qadz32 with SMTP id z32so1653217qad.19
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 00:11:19 -0700 (PDT)
In-Reply-To: <87obpn92jy.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Thu, May 17, 2012 at 4:06 AM, Kevin Hilman <khilman@ti.com> wrote:
> +Jean for functional power states
>
> Tero Kristo <t-kristo@ti.com> writes:
>
>> This patch adds device off support to OMAP4 device type.
>
> Description is rather thin for a patch that is doing so much.
>
>> OFF mode is disabled by default,
>
> why?
>
>> however, there are two ways to enable OFF mode:
>> a) In the board file, call omap4_pm_off_mode_enable(1)
>> b) Enable OFF mode using the debugfs entry
>> echo "1">/sys/kernel/debug/pm_debug/enable_off_mode
>> (conversely echo '0' will disable it as well).
>
> This part needs to be a separate patch.
>
> But, as stated in the core retention series, I'd like to move away fr=
om
> these global flags all together.
>
> The way we manage the disabling of certain states (like off) is alrea=
dy
> clumsy for OMAP3, and it's getting worse with OMAP4. =A0Basically, I =
think
> this feature needs to be supported by using constraints on functional
> power states. =A0 Having checks all over the place is getting unwield=
y and
> not attractive to maintain.
>
> The combination of constraints and functional power states should mak=
e
> this much more manageable. =A0 Until we have that, I'd prefer to keep
> the debugfs enable/disable stuff as separate patches at the end of th=
e
> series used only for testing.
>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> [t-kristo@ti.com: largely re-structured the code]
>
> then the sign-off above from Santosh probably doesn't apply anymore.
> You should change that to a Cc and just mention tht this is based upo=
n
> some original work from Santosh.
>
> First, =A0some general comments:
>
> There is a lot going on in this patch, so it is hard to follow what a=
ll
> is related, and why. =A0Just a quick glance suggests it needs to be b=
roken
> up into at least a few parts:
>
> - low-level PRM support: new APIs for various off-mode features)
> =A0(should probably be done on top of functional power states)
> - powerdomain core support or "achievable" states
> =A0(should probably be done on top of functional power states)
> - IRQ/GIC context save/restore
> - secure RAM save/restore (this has been tightly coupled to the GIC
> =A0but it's not obvious why)
> - PM debug support to enable/disable off-mode
> =A0(for testing only, not for merge)
>
=46urther split sounds good to me.

Regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
