From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Mon, 17 Jun 2013 01:27:24 -0700
Message-ID: <20130617082724.GI20992@atomide.com>
References: <CACVXFVOp6n3RhZnWD_hRxqE8a8amPA5SRWfkVhz+yCGZTtGjvQ@mail.gmail.com>
 <20130612163124.GD8164@atomide.com>
 <20130612171407.GM8164@atomide.com>
 <51B98F1E.1000006@ti.com>
 <51B99B07.1050806@ti.com>
 <CACVXFVN3=hzWJEwHN5TXRoJ4mvVRVR+3=Tasw+gvLH3vsNHwUg@mail.gmail.com>
 <CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
 <51BEBDCD.3060104@ti.com>
 <87ppvlqhyy.fsf@lebrac.rtp-net.org>
 <CACVXFVMthQNgAe3QhMo8HUxuEYcFSOwsdb7RfAsFqwGFKL+dXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57543 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932214Ab3FQI1b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 04:27:31 -0400
Content-Disposition: inline
In-Reply-To: <CACVXFVMthQNgAe3QhMo8HUxuEYcFSOwsdb7RfAsFqwGFKL+dXA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ming Lei <tom.leiming@gmail.com> [130617 01:22]:
> On Mon, Jun 17, 2013 at 4:06 PM, Arnaud Patard
> <arnaud.patard@rtp-net.org> wrote:
> > Sricharan R <r.sricharan@ti.com> writes:
> >
> > I hoped to have missed some mails and that people were testing pandabard
> > support with full support but given what I see, the ethernet support is
> > not there yet. This thread is about removing the non-DT boot. I see some
> > contradiction here. Please, look again at what Thomas said in the IGEP thread:
> > breaking existing support is bad and removing non-DT boot for panda with
> > not-working ethernet would exactly to that.
> 
> +1
> 
> Even no any USB support on Sricharan's setting.

That's also related to the auxclk. Let's see what Mike says before
we start adding back any legacy hacks for it. 

> > Yeah, I'm aware that some extra patches are being developped like the
> > omap clocks one: https://patchwork.kernel.org/patch/2541331/ but they
> > don't seem to be in -next. So, again, please, wait that all needed bits
> > are merged mainline before killing non-DT support (or provide 'mixed'
> > support like what is/was done on kirkwood)
> 
> Agree, please don't be too quick, :-)

Too quick? The basic DT based booting has been working for a few years
now to some extent on omaps :)

Regards,

Tony
