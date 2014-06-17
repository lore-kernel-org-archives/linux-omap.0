From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC PATCH] clk: ti: CLK_SET_RATE_NO_REPARENT for ti,mux-clock
Date: Tue, 17 Jun 2014 11:04:31 +0300
Message-ID: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33109 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274AbaFQIFA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 04:05:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

While implementing DSS support for AM43xx I encountered a problem with clock
mux: clk mux may change the parent clock automatically, and with
set-rate-parent this leads to changing clocks for other devices. The problem is
described in more detail in the actual patch.

The problem doesn't seem to happen in -rc1, even if it was there in linux-next
(20140527). However, in -rc1, if I add debug prints to clk.c, I can see that
the code is going through the parents, but it decides to use the first one (the
correct one). So I presume it's just a matter of right clock rates or such
which will cause the parent to be changed.

Thus I think the problem is still there and should be fixed until it happens
again, either for DSS or for some other device.

This patch changes the behavior for all TI mux-clocks. I think it's much better
to default to CLK_SET_RATE_NO_REPARENT as changing the parent automatically
feels rather dangerouns to me.

Another option could be to set CLK_SET_RATE_NO_REPARENT only when the mux has
"ti,set-rate-parent" set, as (maybe) it's safe to change the parent if the
parent's rate will not be changed.

However, I'm fine with doing this only for the DSS, if someone has ideas how to
do that. A DT property would be easy, but I guess the argument against it is
the same as for the PLL rounding: it's not a hardware property.

Tomi Valkeinen (1):
  clk: ti: set CLK_SET_RATE_NO_REPARENT for ti,mux-clock

 drivers/clk/ti/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.9.1

