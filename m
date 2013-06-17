From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Mon, 17 Jun 2013 01:49:42 -0700
Message-ID: <20130617084942.GJ20992@atomide.com>
References: <20130612171407.GM8164@atomide.com>
 <51B98F1E.1000006@ti.com>
 <51B99B07.1050806@ti.com>
 <CACVXFVN3=hzWJEwHN5TXRoJ4mvVRVR+3=Tasw+gvLH3vsNHwUg@mail.gmail.com>
 <CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
 <51BEBDCD.3060104@ti.com>
 <87ppvlqhyy.fsf@lebrac.rtp-net.org>
 <CACVXFVMthQNgAe3QhMo8HUxuEYcFSOwsdb7RfAsFqwGFKL+dXA@mail.gmail.com>
 <20130617082724.GI20992@atomide.com>
 <CACVXFVP+-Qm-HrjF1vFxS5JCmf8rR7MdU44mw5-yo0UACYdfrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21546 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074Ab3FQItq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 04:49:46 -0400
Content-Disposition: inline
In-Reply-To: <CACVXFVP+-Qm-HrjF1vFxS5JCmf8rR7MdU44mw5-yo0UACYdfrw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ming Lei <tom.leiming@gmail.com> [130617 01:47]:
> On Mon, Jun 17, 2013 at 4:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Too quick? The basic DT based booting has been working for a few years
> > now to some extent on omaps :)
> 
> I mean it is OK to drop legacy mode now if it won't break old system.
> Otherwise, it is better to slow down the dropping legacy patch so that
> the board won't be one brick for us old board users, :-)

Right, the plan is be able to use it naturally. The USB auxclk issue
is fixable for DT boot, we just need to decide what's the best way
to fix it.

Regards,

Tony
