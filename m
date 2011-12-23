From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Adding remoteproc/rpmsg to linux-next
Date: Fri, 23 Dec 2011 13:45:19 +0200
Message-ID: <CAK=WgbYanX_q8JDO6MF3zLWMkRiJ6uynmu+s7eBNrX4qL0N8ug@mail.gmail.com>
References: <CAK=WgbaU6vpiBGSgogYPjQNmrF-U0wk1rSXMX83DdgQa9hw5Mw@mail.gmail.com>
 <20111212103301.5ff6a582dca82394ace40e8d@canb.auug.org.au>
 <CAK=WgbZm9txdvZ1VW-iUn5306yMz1Y=DT_Uygwi6zPZNyWx7gA@mail.gmail.com> <201112221522.21146.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <201112221522.21146.arnd@arndb.de>
Sender: linux-next-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-next@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Brian Swetland <swetland@google.com>, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Stephen Boyd <sboyd@codeaurora.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rusty Russell <rusty@rustcorp.com.au>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Saravana Kannan <skannan@codeaurora.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 22, 2011 at 5:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Either way works for me, too. Right now, I would tend to let you send it
> to Linus directly because I haven't looked at the latest versions of the
> code for some time.

Directly to Linus it is then.

> While I generally trust you to do the right thing
> there, I'm not 100% comfortable to vouch for it in the way that an Ack
> or pull would imply without doing a more detailed review of the latest
> code.

Sure, I fully understand.

> I know that I promised you that review, but haven't gotten to it, sorry.
> I've done a 5 minute review now and it absolutely looks good to go in
> as far as I can tell, so I certainly don't object to you sending it
> to Linus for 3.3.

Thanks.

> If you think you need more Acks or if there are other
> reasons to have it go through arm-soc, please tell me and I'll try harder
> to find the time for a proper review.

I do have explicit Acks on the changes to other sub-systems, though
ideally I'd be happy to have some explicit Acks on the generic code
too.

But I hope this should be fine. Let's try to proceed this way and see
how it goes (maybe I should just tell Linus that despite the lack of
explicit Acks to some of the patches, people do think this is
good-to-go).

Thanks!
Ohad.
