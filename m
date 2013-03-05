From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] board-overo.c: enable TWL4030 power off
Date: Tue, 5 Mar 2013 10:43:26 -0800
Message-ID: <20130305184326.GE11806@atomide.com>
References: <1362055461-27154-1-git-send-email-schnitzeltony@googlemail.com>
 <20130304190035.GT11806@atomide.com>
 <CALbNGRQbAq4NdS4JFmJABG_kwOWsHeY9xOuk=x7AzCk3zb9eBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:34991 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756664Ab3CESn2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 13:43:28 -0500
Content-Disposition: inline
In-Reply-To: <CALbNGRQbAq4NdS4JFmJABG_kwOWsHeY9xOuk=x7AzCk3zb9eBA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas =?utf-8?Q?M=C3=BCller?= <schnitzeltony@googlemail.com>
Cc: linux-omap@vger.kernel.org

* Andreas M=C3=BCller <schnitzeltony@googlemail.com> [130305 00:19]:
>
> Sorry for the noise but I am newbie here and have one question:
> Against which branch should patches send here be based on. Up to now =
I
> used Linus' mainline branch - is that OK?

Yes that's perfect. It's usually best to use the most recent stable
tag or development tag in Linus' tree. So that would be v3.9-rc1
currently for patches heading to v3.10 merge window.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
