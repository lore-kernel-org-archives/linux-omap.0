From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS testing help?
Date: Tue, 04 Oct 2011 11:06:58 +0300
Message-ID: <1317715618.1893.4.camel@deskari>
References: <alpine.DEB.2.00.1110031446580.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:37332 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753139Ab1JDIHD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 04:07:03 -0400
Received: by mail-bw0-f48.google.com with SMTP id zu5so348481bkb.7
        for <linux-omap@vger.kernel.org>; Tue, 04 Oct 2011 01:07:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110031446580.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Hi Paul,

On Mon, 2011-10-03 at 14:48 -0600, Paul Walmsley wrote:
> Hello Sricharan,
> 
> It looks like Archit is out of the office.  Would it be possible for you 
> to test the updated DSS reset patch, below?
> 
> thanks
> 
> - Paul
> 
> ---------- Forwarded message ----------
> Date: Mon, 3 Oct 2011 13:30:06 -0600 (MDT)
> From: Paul Walmsley <paul@pwsan.com>
> To: Archit Taneja <archit@ti.com>
> Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>,
>     "Shilimkar, Santosh" <santosh.shilimkar@ti.com>,
>     "R, Sricharan" <r.sricharan@ti.com>, "tony@atomide.com" <tony@atomide.com>,
>     "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
>     "linux-arm-kernel@lists.infradead.org"
>     <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH v2] OMAP2PLUS: DSS: Ensure DSS works correctly if display is
>      enabled in bootloader

For what it's worth, I took your dss hwmod patches from
hwmod_dss_fixes_3.2 branch, and tested them with my latest dss tree.
Works fine on Blaze. However, I don't have a bootloader which would
enable the DSS, so that part I cannot test.

 Tomi


