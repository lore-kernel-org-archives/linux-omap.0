From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: omap: Fix IRQ handling return value
Date: Tue, 27 Aug 2013 10:38:19 -0700
Message-ID: <20130827173819.GD21564@kroah.com>
References: <1374067753-29560-1-git-send-email-oleksandr.savchenko@ti.com>
 <CAGa+x84dE_RwN2G1y_9OJFxnq3JKq5g0YZd+mFueOjjvMzyyew@mail.gmail.com>
 <CAGa+x859+7H3pjZfTFcECe4qMt4=SE_kmToZBt9zoVt0=sUcvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGa+x859+7H3pjZfTFcECe4qMt4=SE_kmToZBt9zoVt0=sUcvA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Alexander Savchenko <oleksandr.savchenko@ti.com>, jslaby@suse.cz, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, balbi@ti.com, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 27, 2013 at 07:30:19AM -0700, Kevin Hilman wrote:
> Greg,
> 
> 
> On Tue, Aug 20, 2013 at 8:44 AM, Kevin Hilman <khilman@linaro.org> wrote:
> > +Felipe
> >
> > On Wed, Jul 17, 2013 at 6:29 AM, Alexander Savchenko
> > <oleksandr.savchenko@ti.com> wrote:
> >> From: Ruchika Kharwar <ruchika@ti.com>
> >>
> >> Ensure the Interrupt handling routine return IRQ_HANDLED vs
> >> IRQ_NONE.
> >
> > Why?
> >
> > By unconditionally returning IRQ_HANDLED, this patch will surely break
> > systems where the UART IRQ is shared with other platforms.
> >
> > I just noticed this patch when bisecting a related problem.  Why
> > wasn't this Cc'd to linux-omap where OMAP users might have been more
> > likely to see it?
> >
> > Greg, without a better justification in the changelog, I think this
> > patch should be dropped from tty-next.
> 
> Can you drop this from tty-next please?
> 
> The authors aren't responding (one of the ti.com addresses bounced)
> and this "fix" is most is not correct.

Yes, sorry, behind on my pending tty patch queue.  I'll try to get to it
this week.

greg k-h
