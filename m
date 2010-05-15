From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 21:02:34 -0700
Message-ID: <AANLkTinztS8B4LkceGgZB94sRKbseKQ6qMnWB0Jcyh9I@mail.gmail.com>
References: <AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
	<Pine.LNX.4.44L0.1005142216481.11498-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005142216481.11498-100000@netrider.rowland.org>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@google.co>
List-Id: linux-omap@vger.kernel.org

On Fri, May 14, 2010 at 7:25 PM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> On Fri, 14 May 2010, Arve Hj=F8nnev=E5g wrote:
>
>> On Fri, May 14, 2010 at 1:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> >
>> > Hello,
>> >
>> > On Mon, 3 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >
>> >> No, suspend blockers are mostly used to ensure wakeup events are not
>> >> ignored, and to ensure tasks triggered by these wakeup events
>> >> complete.
>> >
>> > Standard Linux systems don't need these,
>>
>> If you don't want to lose wakeup events they do. Standard Linux
>> systems support suspend, but since they usually don't have a lot of
>> wakeup events you don't run into a lot of problems.
>
> The primary client for opportunistic suspend and suspend blockers
> appears to be embedded systems. =A0These systems are typically capable of
> powering the CPU down and up again with low latency, and they typically
> have very aggressive runtime PM support capable of powering down each
> device when it's not in active use. =A0Given this ability, it does seem
> that opportunistic suspend and suspend blockers might be unnecessary.
>

With the current kernel and user-space code we run, we get
significantly better battery life on the msm plaform using suspend
compared to entering the same power state from idle. On some devices
it takes only five wakeup events per second to cut the best case
battery life in half.

> I'd like to explore this avenue a little farther. =A0In particular, what
> is the issue involving loss of wakeup events? =A0Can you describe this in
> more detail?
>

On the desktop systems I have used I only wake the up the system by
pressing a button/key or with an rtc alarm. Losing a button or key
wakeup event is not usually a problem on a desktop since the user will
press it again. Losing an alarm however could be a problem and this
can be avoided by using opportunistic suspend and suspend blockers.

>> > because the scheduler just keeps
>> > the system running as long as there is work to be done.
>> >
>>
>> That is only true if you never use suspend.
>
> Why would you want to use system suspend if runtime PM can do
> everything you need?
>
Because it stops threads that wakeup every second to check if they
have work to do (this includes standard kernel threads), and it
prevents bad apps that never go idle from completely destroying our
battery life.

> Sure, I can see that an ACPI-based system needs something more. =A0But
> that's not the real issue here.
>

The system we started with entered a much lower power state from
suspend than idle so we needed wakelocks to get more than 24 hours
battery life. We kept wakelocks when we moved to the msm platform
since it reduces our power consumption.

-- =

Arve Hj=F8nnev=E5g
