From: Tony Lindgren <tony@atomide.com>
Subject: Re: 3.13 gta04 mmc not working
Date: Fri, 27 Dec 2013 16:56:52 -0800
Message-ID: <20131228005651.GD5116@atomide.com>
References: <CAAfyv36c8XktjUxpX0NQLh9vgBdr-FTKToamUT5ankzTZG_wJw@mail.gmail.com>
 <CAAfyv36uE6hgEYW6t9Zhmn6W1Zd6XCR9xz8vNNuxaL4XzXvCUQ@mail.gmail.com>
 <20131227181620.GC5116@atomide.com>
 <CAAfyv356QxMGCGa3CC0UNeLrVLzMguSFgV6C-mwDKgUMfmWt-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33579 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752422Ab3L1A5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Dec 2013 19:57:05 -0500
Content-Disposition: inline
In-Reply-To: <CAAfyv356QxMGCGa3CC0UNeLrVLzMguSFgV6C-mwDKgUMfmWt-g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

* Belisko Marek <marek.belisko@gmail.com> [131227 11:57]:
> On Fri, Dec 27, 2013 at 7:16 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Belisko Marek <marek.belisko@gmail.com> [131221 15:58]:
> >> OK seems I found solution:
> >> http://marc.info/?l=linux-omap&m=138756097116464&w=2
> >
> > Good to hear :)
> >
> >> @Tony: Is this going to 3.13?
> >
> > Sorry too intrusive for 3.13, should be all set to go into v3.14.
> So we keep DT mmc booting broken in 3.13 for omap3?

Yeah for some dual voltage cards. For DT booting, that series is
getting into the area of "fixes for things that never worked before"
although it is working for legacy booting :)

Regards,

Tony
