From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain support via
 hwmod mux
Date: Tue, 29 Nov 2011 16:52:47 +0530
Message-ID: <1e686270c099fa4a270b6b01e6ac585c@mail.gmail.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com> <87pqh3qvkt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:54546 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753828Ab1K2LWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 06:22:51 -0500
Received: by mail-iy0-f181.google.com with SMTP id n33so11981938iae.12
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 03:22:50 -0800 (PST)
In-Reply-To: <87pqh3qvkt.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Tuesday, November 08, 2011 6:28 AM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain
> support via hwmod mux
>
> Hi Vishwa,
>
> Vishwanath BS <vishwanath.bs@ti.com> writes:
>
> > The folowing patch series provides IO Daisychain feature via omap
> hwmod mux
> > framework.
>
> The series looks OK at first glance, but needs a refresh against
> current
> mainline.
OK.
>
> Can you refresh this against Tony's 'fixes' branch and re-test.
>
> I tested this on OMAP3430/n900 and noticed that it no longer hit off
> mode from idle.
>
> IOW, If I enable UART timeouts and then enable off mode, I don't
> actually ever hit off during idle.  However, if I do a
> suspend/resume I
> see it hits off mode, then subsequent attempts to hit off during
> idle work.
>
> Can you investigate this?
OK. Let me check that.

Regards
Vishwa
>
> Kevin
