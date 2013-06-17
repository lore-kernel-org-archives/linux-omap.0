From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Mon, 17 Jun 2013 16:16:57 +0800
Message-ID: <CACVXFVMthQNgAe3QhMo8HUxuEYcFSOwsdb7RfAsFqwGFKL+dXA@mail.gmail.com>
References: <20130517191304.468.73487.stgit@localhost>
	<20130517191753.468.1734.stgit@localhost>
	<CACVXFVOp6n3RhZnWD_hRxqE8a8amPA5SRWfkVhz+yCGZTtGjvQ@mail.gmail.com>
	<20130612163124.GD8164@atomide.com>
	<20130612171407.GM8164@atomide.com>
	<51B98F1E.1000006@ti.com>
	<51B99B07.1050806@ti.com>
	<CACVXFVN3=hzWJEwHN5TXRoJ4mvVRVR+3=Tasw+gvLH3vsNHwUg@mail.gmail.com>
	<CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
	<51BEBDCD.3060104@ti.com>
	<87ppvlqhyy.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:49637 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab3FQIQ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 04:16:58 -0400
Received: by mail-ve0-f173.google.com with SMTP id jw11so1857415veb.4
        for <linux-omap@vger.kernel.org>; Mon, 17 Jun 2013 01:16:57 -0700 (PDT)
In-Reply-To: <87ppvlqhyy.fsf@lebrac.rtp-net.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Sricharan R <r.sricharan@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 17, 2013 at 4:06 PM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
> Sricharan R <r.sricharan@ti.com> writes:
>
> I hoped to have missed some mails and that people were testing pandabard
> support with full support but given what I see, the ethernet support is
> not there yet. This thread is about removing the non-DT boot. I see some
> contradiction here. Please, look again at what Thomas said in the IGEP thread:
> breaking existing support is bad and removing non-DT boot for panda with
> not-working ethernet would exactly to that.

+1

Even no any USB support on Sricharan's setting.

>
> Yeah, I'm aware that some extra patches are being developped like the
> omap clocks one: https://patchwork.kernel.org/patch/2541331/ but they
> don't seem to be in -next. So, again, please, wait that all needed bits
> are merged mainline before killing non-DT support (or provide 'mixed'
> support like what is/was done on kirkwood)

Agree, please don't be too quick, :-)


Thanks,
-- 
Ming Lei
