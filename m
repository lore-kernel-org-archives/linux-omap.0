From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH V2] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
Date: Mon, 21 May 2012 08:36:35 -0500
Message-ID: <CAOMWX4f2N1dS8RcwYAyUpmWVKPkEHGuhMGGZ3__D-DwipsjzFQ@mail.gmail.com>
References: <1337365122-702-1-git-send-email-nm@ti.com> <20120519095237.GA26761@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:55534 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754501Ab2EUNjB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 09:39:01 -0400
Received: by wgbdq10 with SMTP id dq10so4521596wgb.15
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 06:38:58 -0700 (PDT)
In-Reply-To: <20120519095237.GA26761@besouro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eduardo.valentin@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Wenbiao Wang <wwang@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

 Sat, May 19, 2012 at 4:52 AM, Eduardo Valentin <eduardo.valentin@ti.com>
wrote:
>
>
> I guess it is time to properly document this increasing busy loop delay..
> As it is getting closer to ms scale..
Does the following sound good?
/* Maximum time for Voltage Processor to enter or exit idle */

Regards,
Nishanth Menon
