From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Thu, 05 Jul 2012 15:06:31 -0700
Message-ID: <87pq89euc8.fsf@ti.com>
References: <20120611004502.20034.8840.stgit@dusk>
	<20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com>
	<alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
	<4FDA45F5.9090300@ti.com>
	<alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
	<4FDB387C.7030003@ti.com>
	<alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
	<alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com>
	<4FF475E6.3060308@ti.com>
	<alpine.DEB.2.00.1207041257200.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:49290 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753738Ab2GEWGV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 18:06:21 -0400
Received: by ghy10 with SMTP id 10so14625647ghy.16
        for <linux-omap@vger.kernel.org>; Thu, 05 Jul 2012 15:06:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207041257200.6760@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 4 Jul 2012 12:59:34 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> Hi Beno=C3=AEt
>
> On Wed, 4 Jul 2012, Benoit Cousson wrote:
>
>> > @@ -1141,8 +1144,16 @@ static void _enable_sysc(struct omap_hwmod =
*oh)
>> >  	sf =3D oh->class->sysc->sysc_flags;
>> > =20
>> >  	if (sf & SYSC_HAS_SIDLEMODE) {
>> > -		idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
>> > -			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
>> > +		clkdm_act =3D ((oh->clkdm &&
>> > +			      oh->clkdm->flags & CLKDM_ACTIVE_WITH_MPU) ||
>> > +			     (oh->_clk->clkdm &&
>>=20
>> This is crashing on OMAP4 due to a NULL oh->_clk that can happen on =
some
>> hwmod.
>>=20
>> +			     (oh->_clk && oh->_clk->clkdm &&
>>=20
>> Is fixing the issue.
>
> Thanks, just made the change and pushed the patch up to=20
> git://git.pwsan.com/linux-2.6 in the branch 'omap_fixes_c_3.5rc'

OK, to ensure this fix gets into v3.5-rc, I'm taking the version from
this branch and queuing up as a PM fix Tony.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
