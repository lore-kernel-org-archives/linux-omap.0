From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: Problems in cpuidle
Date: Mon, 09 Mar 2009 12:05:36 +0200
Message-ID: <871vt7ko3z.fsf@trdhcp146196.ntc.nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC0EDF9C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32410 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbZCIKGQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 06:06:16 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC0EDF9C@dbde02.ent.ti.com> (ext Premi's message of "Fri\, 6 Mar 2009 18\:32\:07 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Premi, Sanjeev" <premi@ti.com> writes:

> While working with cpuidle, I have come across these problems.
> I am also working on the solutions, but would be good to hear
> more thoughts.
>
> 1) The flag 'enable_dyn_sleep' is honoured only in omap3_idle_bm_chec=
k()
>    but in the C1 state, omap3_enter_idle() is invoked directly.
>    So, the system can transition to deeper idle state(s)
>
>    Same is the case with 'sleep_block'.
>
>    Possible Solutions:
>      a)  Call omap3_can_sleep() in omap3_enter_idle().
>          This makes omap3_idle_bm_check() redundant; and can be remov=
ed.
>
>      b)  Make single entry point for all idle states
>          But would be an overkill for C1 state.
>
>      c)  Change omap3_can_sleep() to check for omap_uart_can_sleep()
>          and omap3_fclks_active() only.
>          Move check for 'enable_dyn_sleep' and 'sleep_block' into
>          omap3_enter_idle()
>
>     I believe (c) would be the most optimal.

Selecting (c) will break traditional pm_idle. Current plan is to add on=
e more C
state (C1) which would prevent mpu/core sleep transitions. Then remove
fclk_active check completely.

--=20
Jouni H=C3=B6gander
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
