From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Question about tracing in _pwrdm_state_switch()
Date: Mon, 30 Jan 2012 12:33:44 +0530
Message-ID: <CAMQu2gyoQ0K9OwiOLdELM4DbLx+Pj4qGpVfFkstfmHrmAcN-qA@mail.gmail.com>
References: <alpine.DEB.2.00.1201290302480.27331@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35642 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751003Ab2A3HEI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 02:04:08 -0500
Received: by mail-qw0-f54.google.com with SMTP id a17so2725286qae.13
        for <linux-omap@vger.kernel.org>; Sun, 29 Jan 2012 23:04:06 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201290302480.27331@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: jpihet@newoldbits.com, linux-omap@vger.kernel.org, t-kristo@ti.com, khilman@ti.com, rnayak@ti.com

Paul,

On Sun, Jan 29, 2012 at 3:38 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi Jean
>
> Quick question on the tracing in _pwrdm_state_switch().
>
> That section of the code reads:
>
> =A0 =A0 =A0 =A0state =3D pwrdm_read_pwrst(pwrdm);
>
> ...
>
> =A0 =A0 =A0 =A0case PWRDM_STATE_PREV:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prev =3D pwrdm_read_prev_pwrst(pwrdm);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pwrdm->state !=3D prev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->state_counter[p=
rev]++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (prev =3D=3D PWRDM_POWER_RET)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_update_logic_membank_=
counters(pwrdm);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * If the power domain did not hit the=
 desired state,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * generate a trace event with both th=
e desired and hit states
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (state !=3D prev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0trace_state =3D (PWRDM=
_TRACE_STATES_FLAG |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ((state & OMAP_POWERSTATE_MASK) << 8) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ((prev & OMAP_POWERSTATE_MASK) << 0));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0trace_power_domain_tar=
get(pwrdm->name, trace_state,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0smp_processor_id());
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> This code is called after returning from WFI. =A0It appears to compar=
e the
> powerdomain's current power state ('state') with the powerdomain's
> previous power state ('prev'). =A0But it appears to me that it should
> instead compare the powerdomain's intended power state ('pwrdm->state=
')
> with 'prev' ? =A0The rationale is that the PRCM could have brought th=
at
> powerdomain up to a higher power state than 'pwrdm->state' during the
> wakeup process.
>
> What do you think?
>
You are right. 'state' is the current power state and not the intended
power state.
Infact the value cashed in the power domain structure is an intended st=
ate and
that should be compared with previous state same way as the counter cod=
e
is doing.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
