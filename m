From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 27 May 2010 01:40:38 -0700
Message-ID: <AANLkTikL7ZubQlzycYz6p8orMQ6pGK1zLo0nUfoAf8l8@mail.gmail.com>
References: <CEE6BB42CAD6E947908279175AF8470A025A7D7DC4@EXDCVYMBSTM006.EQ1STM.local>
	<Pine.LNX.4.44L0.1005261156130.1328-100000@iolanthe.rowland.org>
	<CEE6BB42CAD6E947908279175AF8470A025A8206ED@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A025A8206ED@EXDCVYMBSTM006.EQ1STM.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus WALLEIJ <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-88
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 12:46 AM, Linus WALLEIJ
<linus.walleij@stericsson.com> wrote:
> [Alan Stern]
>> On Wed, 26 May 2010, Linus WALLEIJ wrote:
>> (...)
>> > Now if this mechanism is going in, my main interest is that there
>> > is some clearly cut way and design pattern for supporting both
>> > runtime PM and suspend blocks.
>>
>> It's not difficult. =A0You just have to decide what situations should
>> block opportunistic suspend. =A0For example, let's say that opportunistic
>> suspend should be blocked when your event queue is non-empty.
>>
>> Then in the routine that adds new events to the queue, while still
>> holding the spinlock that protects your queue, you enable your suspend
>> blocker. =A0Likewise, in the routine that takes events off the queue and
>> sends them to userspace, while holding the spinlock you test whether
>> the queue has become empty; if it has you disable your suspend blocker.
>>
>> That's all. =A0No other changes are needed (except to create and destroy
>> the suspend blocker, of course). =A0No other interaction with suspend,
>> resume, or runtime PM.
>
> OK I understand it will be rather OK to do this. For example I have
> drivers/spi/amba-pl022.c which is quite clearly taking elements
> off a queue and transmitting them.
>
> Currently, as we do not have suspend blockers, we try to stop the
> queue in suspend() and if that fails we return something negative
> so that the suspend() is blocked by the negative return code.
>
> Maybe the behaviour for an SPI bus should rather be to return
> -EBUSY as long as there are events in the queue. I don't quite
> know frankly.
>
> (We haven't added runtime PM yet, it will likely be the same
> thing.)
>
> With suspend blockers we take a suspend blocker when we add
> elements to the queue and release it when the queue is empty.
>
> But with suspend blockers the need for suspend() to check if
> the queue can be stopped or return -EBUSY if there are elements
> in it is not necessary: suspend() simply won't be called
> since a suspend blocker is taken. There is no way for
> suspend() to stop a running queue like we do today if using
> suspend blockers.
>
> This means that driver writers only targeting configurations
> where suspend blockers are used will probably not care about
> handling suspend() calls by trying to stop the queue or
> checking if there are things in it, because there will never
> be anything there.
>
> So while it is easy for me to have the driver work under both
> suspend blockers and runtime PM or common suspend(), the
> two configurations actually have different semantics of the
> suspend() call: in the suspend blockers case you don't need
> to check anything, just suspend, and in =A0the runtime PM
> case you have to check that you can actually suspend.
>
> Is this analysis correct?
>

Mostly, yes. With the current suspend blocker implementation, if you
only start blocking suspend from a user-space thread, or a freezable
kernel thread, then your suspend hook will never be called while you
block suspend unless you use forced suspend. If you for instance start
blocking suspend in response to an interrupt on the other hand, there
is no guarantee that drivers you depend on have not already been
suspended or that they will not suspend after you block suspend, so
you may have to implement a suspend hook to manually abort suspend
even when using suspend blockers. You can add a check if your suspend
blocker is active within your critical section in your suspend hook.
Our alarm driver does this.

> If yes then OK, it's not totally elegant but if that is
> where we have to go, I can live with it. There will likely
> be people who implement for only one or the other semantic
> behaviour, but we have worse things to cope with already.
>

Yes, but you can support both forced suspend and opportunistic suspend
in the same driver. Supporting both is harder if the suspend blocker
api is not in the mainline kernel.

-- =

Arve Hj=F8nnev=E5g
