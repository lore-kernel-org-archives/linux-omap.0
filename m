From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 5/8] ARM: OMAP2+: PM: introduce power domains achievable
 functional states
Date: Thu, 19 Jul 2012 01:57:42 -0500
Message-ID: <CAOMWX4ftVew2OxR=4AziK_emgtr7aT6Yr7vkKze0Gyn6w=8hTA@mail.gmail.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
 <1339685591-11177-6-git-send-email-j-pihet@ti.com> <CAORVsuXbvkWHLm9mK3EgKSKFo400VoR6QSZbrS8hu1u8cV3e3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:55862 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751178Ab2GSG6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 02:58:04 -0400
Received: by weyx56 with SMTP id x56so1820377wey.13
        for <linux-omap@vger.kernel.org>; Wed, 18 Jul 2012 23:58:02 -0700 (PDT)
In-Reply-To: <CAORVsuXbvkWHLm9mK3EgKSKFo400VoR6QSZbrS8hu1u8cV3e3A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>, Tero Kristo <t-kristo@ti.com>

On Fri, Jun 15, 2012 at 6:28 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
>
> "
> 1. The while loops need optimization. - This can definitely be
> simplified and made non-risky; this also needs some more error
> handling
If you are interested using something like the following
static int _match_pwrst(u32 pwrsts, u8 pwrst, u8 default_pwrst)
{
       bool found = true;
       int new_pwrst = pwrst;

       /* Search down */
       while (!(pwrsts & (1 << new_pwrst))) {
               if (new_pwrst == PWRDM_POWER_OFF) {
                       found = false;
                       break;
               }
               new_pwrst--;
       }

       if (found)
               goto done;

       /* Search up */
       new_pwrst = pwrst;
       while (!(pwrsts & (1 << new_pwrst))) {
               if (new_pwrst == default_pwrst)
                       break;
               new_pwrst++;
       }
done:
       return new_pwrst;
}


new_pwrst = _match_pwrst(pwrdm->pwrsts, pwrst,
                         PWRDM_POWER_ON);
new_logic = _match_pwrst(pwrdm->pwrsts_logic_ret, logic,
                         PWRDM_POWER_RET);
to achieve the same code..
> 2. About the power domains state machine: you have only one power
> state to move in and out of: it is called ON. If you do ON->CSWR->ON
> etc. attempting to program ON->CSWR->OSWR is NOT supported in OMAP and
> is an invitation for production team to sit and debug for a while
> before finding the use of invalid power states
> "
>
> Point 2 is a good point. The solution would be to implement a state
> machine in this function and/or omap_set_pwrdm_state, possibly using a
> platform specific handling function.

Point 2 is not completely accurate -> Lower pwr state transitions can
indeed and is indeed
supported on OMAP4+. CSWR->OSWR->OFF is possible and omap_setpwrdm_state does
indeed handle this. however going to OSWR->CSWR is possible only by
OSWR->ON->CSWR.
this is again supported in code, however, in practice, we have found
that certain IP blocks(in
personal experience, it was DSS) need IP specific additional work
which is not easily doable..
so when we come out of suspend state, if the IP block has achieved a
lower powerstate than
what was programmed, we just leave it as is.

Regards,
Nishanth Menon
