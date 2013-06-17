From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Mon, 17 Jun 2013 16:41:50 +0800
Message-ID: <CACVXFVP+-Qm-HrjF1vFxS5JCmf8rR7MdU44mw5-yo0UACYdfrw@mail.gmail.com>
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
	<20130617082724.GI20992@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:46083 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217Ab3FQIlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 04:41:50 -0400
Received: by mail-ve0-f180.google.com with SMTP id pa12so1872020veb.39
        for <linux-omap@vger.kernel.org>; Mon, 17 Jun 2013 01:41:50 -0700 (PDT)
In-Reply-To: <20130617082724.GI20992@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 17, 2013 at 4:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> Too quick? The basic DT based booting has been working for a few years
> now to some extent on omaps :)

I mean it is OK to drop legacy mode now if it won't break old system.
Otherwise, it is better to slow down the dropping legacy patch so that
the board won't be one brick for us old board users, :-)


Thanks,
-- 
Ming Lei
