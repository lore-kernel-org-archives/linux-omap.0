From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv6 4/7] ARM: OMAP: hwmod: Add support for per
 hwmod/module context lost count
Date: Thu, 19 Jul 2012 14:47:54 +0300
Message-ID: <1342698474.4672.129.camel@sokoban>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
	 <1339428387-4800-5-git-send-email-t-kristo@ti.com>
	 <CAOMWX4fecw5A0BhDG-swVubKtxTEKdNpcODOh7=uFBFbSAnbgw@mail.gmail.com>
	 <1342602902.4672.91.camel@sokoban>
	 <CAOMWX4dWnJSOwLVvrAfMd7a9eKE97ywR0TrS6imHFA67V5QZag@mail.gmail.com>
	 <1342691380.4672.123.camel@sokoban>
	 <CAOMWX4d9wBS2dx_6S9ouMagUPnAr3q8TYXpGq52nREfGHxVEUg@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53472 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745Ab2GSLsA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 07:48:00 -0400
In-Reply-To: <CAOMWX4d9wBS2dx_6S9ouMagUPnAr3q8TYXpGq52nREfGHxVEUg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Thu, 2012-07-19 at 05:27 -0500, Menon, Nishanth wrote:
> On Thu, Jul 19, 2012 at 4:49 AM, Tero Kristo <t-kristo@ti.com> wrote:
> >
> > Zero doesn't mean no context loss. If counter was previous MAX_INT, if
> > it goes to zero it is still a context loss, as the counter value
> > differs. Drivers do check against diff in the context loss counter, and
> > if there is one, they do restore which is the right way to handle it. No
> > need to unnecessarily make this more complicated than it is.
> 
> so we flip the responsibility of overflow to drivers. considering a
> similar scenario of jiffies
> /*
>  *      These inlines deal with timer wrapping correctly. You are
>  *      strongly encouraged to use them
>  *      1. Because people otherwise forget
>  *      2. Because if the timer wrap changes in future you won't have to
>  *         alter your driver code.
>  *
>  * time_after(a,b) returns true if the time a is after time b.
> ...
> */
> from past experience, it is highly possible that drivers never get
> this right. if the intent is just to let the drivers know context was
> lost, why not go back to the alternate possibility of a bool
> lost_context which tells the driver if it lost context since it last
> called the lost_context api.

This goes to the discussion whether the API of lost context stuff is
correct or not, and goes out of scope for this set.

I am just attempting to bring omap4 to omap3 level in the first place,
we can discuss about the potential API problems separately, and a change
like that should be relatively easy to implement anyway.... but will
break several drivers.

-Tero


