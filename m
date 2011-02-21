From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 14/17] omap4: cpuidle: Add MPUSS RET OFF states
Date: Mon, 21 Feb 2011 19:31:50 +0530
Message-ID: <fb10d0ee60740869487349b87e9d7e23@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-15-git-send-email-santosh.shilimkar@ti.com>
 <AANLkTik-hj+-ZPnfVKLCH0h-QeyziH4H-j6EE+_QHHCU@mail.gmail.com> <6176616fe77333f80f0cfaae4fc8aff3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51371 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751576Ab1BUOBw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 09:01:52 -0500
Received: by mail-qy0-f174.google.com with SMTP id 7so1977849qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 06:01:51 -0800 (PST)
In-Reply-To: <6176616fe77333f80f0cfaae4fc8aff3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Monday, February 21, 2011 3:57 PM
> To: Jean Pihet
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; linux-arm-
> kernel@lists.infradead.org; Rajendra Nayak
> Subject: RE: [PATCH 14/17] omap4: cpuidle: Add MPUSS RET OFF states
>

[...]

> > I think the piece of code below is rather difficult to read and
> > understand. Based on the patch description and the comment here
> > below
> > I do not see the relation with the code.
> >
> There is relation. The comments are as per the conditions. And
> The hardware constraint is back-ground behind the conditions.
>
> > " On OMAP4 because of hardware constraints, no low power states
> are
> >  targeted when both CPUs are online and in SMP mode. The low power
> >  states are attempted only when secondary CPU gets offline to OFF
> >  through hotplug infrastructure. "
> > The test below does not seem to match this comment.
> >
> > > + =A0 =A0 =A0 /*
> > > + =A0 =A0 =A0 =A0* Special hardware/software considerations:
> > > + =A0 =A0 =A0 =A0* 1. Do only WFI for secondary CPU(non-boot - CP=
U1).
> > > + =A0 =A0 =A0 =A0* =A0 =A0Secondary cores are taken down only via=
 hotplug
> > path.
> > The comment looks contradictory. Which one is taken OFF using this
> > code, which one from hotplug?
> > Does this correspond to the condition '(dev->cpu)' in the test
> > below?
>
> Yes.
> >
> > > + =A0 =A0 =A0 =A0* 2. Do only a WFI as long as in SMP mode.
> > Does this correspond to the condition '(num_online_cpus() > 1)' in
> > the
> > test below? If so it this one triggering the low power mode for
> > cpu0?
> yes
> >
> > > + =A0 =A0 =A0 =A0* 3. Continue to do only WFI till CPU1 hits OFF =
state.
> > > + =A0 =A0 =A0 =A0* =A0 =A0This is necessary to honour hardware
> recommondation
> > > + =A0 =A0 =A0 =A0* =A0 =A0of triggeing all the possible low power=
 modes once
> > CPU1 is
> > > + =A0 =A0 =A0 =A0* =A0 =A0out of coherency and in OFF mode.
> > Does this correspond to the condition '(cpu1_state !=3D
> > PWRDM_POWER_OFF)' in the test below?
> >
> Yes
>
> > > + =A0 =A0 =A0 =A0* Update dev->last_state so that governor stats
> reflects
> > right
> > > + =A0 =A0 =A0 =A0* data.
> > > + =A0 =A0 =A0 =A0*/
> > > + =A0 =A0 =A0 cpu1_state =3D pwrdm_read_pwrst(cpu1_pd);
> > > + =A0 =A0 =A0 if ((dev->cpu) || (num_online_cpus() > 1) ||
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cpu1_state !=3D PW=
RDM_POWER_OFF)) {
> > Are '||' correct here?
> Yes.
>
> > Sorry if the code behaves correctly, the remarks are about
> > readability especially in the comments.
> >
> You got all three correct. Instead of having three If's doing
> same thing I have merged them and added comments above.
>
> And you got all of them correctly.
>
Will add the code conditions in comments as well so that
it becomes mere readable.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
