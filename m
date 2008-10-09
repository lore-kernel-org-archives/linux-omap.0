From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: omapfb: help from userspace
Date: Thu, 9 Oct 2008 10:55:11 -0700
Message-ID: <e5e6ade50810091055se7af4aasc404eb92f176dfeb@mail.gmail.com>
References: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com>
	 <e5e6ade50810081321h6f638cafjbe00f4c8a3a50f2c@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE89671620365B58844@dlee02.ent.ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com>
	 <20081009124357.GF26230@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:20234 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbYJIRzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 13:55:13 -0400
Received: by qw-out-2122.google.com with SMTP id 3so45353qwe.37
        for <linux-omap@vger.kernel.org>; Thu, 09 Oct 2008 10:55:11 -0700 (PDT)
In-Reply-To: <20081009124357.GF26230@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>

On Thu, Oct 9, 2008 at 5:43 AM, Tony Lindgren <tony@atomide.com> wrote:
> Nathan, good to hear that the SO mode helps. But since you seem to
> have it easily reproducable..

Reproducing is as easy as applying the DSP Bridge kernel patches and
then running the 'ping.out' sample like this:  while true; do
ping.out; done

> Could you try the following patch based on RMK's earlier patch
> without the strongly ordered patch and see if that makes any
> difference?

Maybe it lasted a few seconds longer, or maybe it was luck, but in any
case it eventually went into an IRQ -33 loop even with this patch.

> If this patch alone does not do anything, maybe try reading back
> something from the dsp interrupt registers after write also
> in the dsp interrupt handler?

I will look into this and let you know.

> Also you might want to read through the thread linked in the
> patch description.
>
> And, if that still does not work, I'm suspecting that in some cases
> write-read is not enough, and only write-write ensures that it gets
> posted. Some ARM docs say that writes are only posted relative to
> other writes, but I don't know if it can be really that way.

Should I change the patch you sent me to do write write?

> At least we have at least one hack like that in the
> drivers/mmc/host/omap.c.
>
> Anyways, it would be nice to solve this issue for good. The problem
> has been making it easily reproducable.

At least I have a workaround for now.  It's good to be able to get DSP
work done.

- Nathan
