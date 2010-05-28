From: Linus WALLEIJ <linus.walleij@stericsson.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 28 May 2010 13:54:49 +0200
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025A820FA7@EXDCVYMBSTM006.EQ1STM.local>
References: <CEE6BB42CAD6E947908279175AF8470A025A8206ED@EXDCVYMBSTM006.EQ1STM.local>
	<Pine.LNX.4.44L0.1005271121210.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271121210.3239-100000@iolanthe.rowland.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Walker <dwalker@codeaurora.>
List-Id: linux-omap@vger.kernel.org

[Alan]
> On Thu, 27 May 2010, Linus WALLEIJ wrote:
> 
> > OK I understand it will be rather OK to do this. For example I have
> > drivers/spi/amba-pl022.c which is quite clearly taking elements
> > off a queue and transmitting them.
> >
> > Currently, as we do not have suspend blockers, we try to stop the
> > queue in suspend() and if that fails we return something negative
> > so that the suspend() is blocked by the negative return code.
> 
> How can it fail?  Even if the queue can't be stopped immediately, can't
> the suspend routine block for a few milliseconds until the queue can be
> stopped?
> 
> > Maybe the behaviour for an SPI bus should rather be to return
> > -EBUSY as long as there are events in the queue. I don't quite
> > know frankly.
> 
> No.  It should stop the queue.
> 
> Think of it this way: Somebody has just closed the lid of their
> laptop and thrown the computer into a backpack.  You don't want the
> machine to fail to suspend merely because an SPI queue wasn't empty.

Not quite! On the other end of that SPI link is our power
regulators. (I'm not making this up, they are really there.) The events
in the queue may be the register writes that actually put the system
to low-power sleep.

But the apropriate action may likely be to wait for this queue to become
empty before returning 0 from suspend().

Yours,
Linus Walleij
