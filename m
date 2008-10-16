From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: omapfb: help from userspace
Date: Thu, 16 Oct 2008 15:07:56 -0700
Message-ID: <e5e6ade50810161507y4a5ac9d6m9754169575dfbdda@mail.gmail.com>
References: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com>
	 <e5e6ade50810081321h6f638cafjbe00f4c8a3a50f2c@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE89671620365B58844@dlee02.ent.ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com>
	 <20081009124357.GF26230@atomide.com>
	 <e5e6ade50810091055se7af4aasc404eb92f176dfeb@mail.gmail.com>
	 <alpine.DEB.2.00.0810150556140.14740@utopia.booyaka.com>
	 <e5e6ade50810152349x38b6f5e2oe59780cc2008c837@mail.gmail.com>
	 <20081016205743.GS15820@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:27510 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756625AbYJPWH6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 18:07:58 -0400
Received: by qw-out-2122.google.com with SMTP id 3so89418qwe.37
        for <linux-omap@vger.kernel.org>; Thu, 16 Oct 2008 15:07:56 -0700 (PDT)
In-Reply-To: <20081016205743.GS15820@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, Rick Bronson <rick@efn.org>

On Thu, Oct 16, 2008 at 1:57 PM, Tony Lindgren <tony@atomide.com> wrote:
> Here's my patch to attempt to fix this issue, could you all give it a
> try please? So far it has worked for me, I'd like to hear what Nathan's
> dsp test case does!
>
> Basically it's modified patch from Russell, except reading back the
> revision register is not enough. Looks like we need to read back the
> same register we're writing.

I applied this patch and it didn't help.  I crashed once on boot-up
and then again within a couple of calls to the DSP Bridge 'ping' test,
both times with the irq -33.

Is there anything else I should have beside this patch?  I applied it
on latest linux-omap git.

- Nathan
