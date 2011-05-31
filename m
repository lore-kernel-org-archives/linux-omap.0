From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: don't trace functions called from sched_clock
Date: Tue, 31 May 2011 04:49:35 -0700
Message-ID: <20110531114935.GY11352@atomide.com>
References: <1304846514-15641-1-git-send-email-rabin@rab.in>
 <BANLkTi=imJXEKriWdXOGE_wWWkQvdtLAHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62032 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754434Ab1EaLtj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 07:49:39 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=imJXEKriWdXOGE_wWWkQvdtLAHg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rabin Vincent <rabin@rab.in> [110527 08:36]:
> Tony,
>=20
> On Sun, May 8, 2011 at 14:51, Rabin Vincent <rabin@rab.in> wrote:
> > omap_readl() is used from the sched_clock() implementations and so =
must
> > be marked notrace to avoid recursion in ftrace. =C2=A0Same thing wi=
th
> > mpu_read() for OMAP1.

We should rather ioremap the 32KSYNCT_BASE in omap_init_clocksource_32k
and then use __raw_readl. That allows us to get rid of omap_read usage
here and simplifies the code.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
