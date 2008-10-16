From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: omapfb: help from userspace
Date: Wed, 15 Oct 2008 23:49:24 -0700
Message-ID: <e5e6ade50810152349x38b6f5e2oe59780cc2008c837@mail.gmail.com>
References: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com>
	 <e5e6ade50810081321h6f638cafjbe00f4c8a3a50f2c@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE89671620365B58844@dlee02.ent.ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com>
	 <20081009124357.GF26230@atomide.com>
	 <e5e6ade50810091055se7af4aasc404eb92f176dfeb@mail.gmail.com>
	 <alpine.DEB.2.00.0810150556140.14740@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:55191 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbYJPGt1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 02:49:27 -0400
Received: by qw-out-2122.google.com with SMTP id 3so936200qwe.37
        for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 23:49:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0810150556140.14740@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>

On Wed, Oct 15, 2008 at 4:57 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Nathan,
>
> could you try Lauri's patch posted here:
> http://marc.info/?l=linux-omap&m=122407150608770&w=2
> without the strongly-ordered memory patches?

This patch works for my DSP test case.

I receive 10-20 kernel messages per second as follows:
irq -33, desc: c0414580, depth: 0, count: 0, unhandled: 0

However, DSP Bridge continues to function normally without errors.

- Nathan
