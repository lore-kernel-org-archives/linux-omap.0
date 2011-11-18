From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] arm: omap2: fix build failure
Date: Fri, 18 Nov 2011 09:16:50 +0800
Message-ID: <CACVXFVPx86+F_P_pDkPkPmyB_hhDBv__q7J3Rf5AC4GpaUfPxw@mail.gmail.com>
References: <1320726849-11854-1-git-send-email-tom.leiming@gmail.com>
	<87mxc61kpw.fsf@ti.com>
	<CACVXFVMtaiFiKSRh8geVpOzymtZsaUKc9tDHfgJYR57N+RQZ-g@mail.gmail.com>
	<87aa7u4k3i.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49782 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1KRBQv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Nov 2011 20:16:51 -0500
Received: by ggnb2 with SMTP id b2so1877557ggn.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 17:16:50 -0800 (PST)
In-Reply-To: <87aa7u4k3i.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Nov 18, 2011 at 3:36 AM, Kevin Hilman <khilman@ti.com> wrote:

> OK, but that doesn't mean you have to keep sending it. =A0It just mea=
ns
> Tony's fixes branch isn't in -next (yet.)

I do not care about which one is merged, but don't want to apply
the fix patch manually for each test, :-)

In fact, there are several other non-merged build failures for omap bui=
ld,
looks like the process is a bit slow, :-)

thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
