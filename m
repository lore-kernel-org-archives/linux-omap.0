From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Sun, 16 May 2010 21:54:51 -0700
Message-ID: <AANLkTikSu7D_qao0_coP8q0l6xL_sWp9c1-y_cYqm7wU@mail.gmail.com>
References: <AANLkTinztS8B4LkceGgZB94sRKbseKQ6qMnWB0Jcyh9I@mail.gmail.com>
	<Pine.LNX.4.44L0.1005151720330.24645-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005151720330.24645-100000@netrider.rowland.org>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@google.com>
List-Id: linux-omap@vger.kernel.org

On Sat, May 15, 2010 at 2:25 PM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> On Fri, 14 May 2010, Arve Hj=F8nnev=E5g wrote:
>
>> > I'd like to explore this avenue a little farther. =A0In particular, wh=
at
>> > is the issue involving loss of wakeup events? =A0Can you describe this=
 in
>> > more detail?
>> >
>>
>> On the desktop systems I have used I only wake the up the system by
>> pressing a button/key or with an rtc alarm. Losing a button or key
>> wakeup event is not usually a problem on a desktop since the user will
>> press it again. Losing an alarm however could be a problem and this
>> can be avoided by using opportunistic suspend and suspend blockers.
>
> How can runtime PM combined with CPUidle cause an alarm to be lost?
>
It doesn't. My desktop systems only gets to a low power state (<3W)
from suspend.

>> > Why would you want to use system suspend if runtime PM can do
>> > everything you need?
>> >
>> Because it stops threads that wakeup every second to check if they
>> have work to do (this includes standard kernel threads), and it
>> prevents bad apps that never go idle from completely destroying our
>> battery life.
>
> Ah, the ill-behaved apps problem. =A0I think everybody agrees that they
> are hard to deal with.
>
> The kernel-threads problem might better be addressed by fixing those
> threads than by adding a new API.
>
>> > Sure, I can see that an ACPI-based system needs something more. =A0But
>> > that's not the real issue here.
>> >
>>
>> The system we started with entered a much lower power state from
>> suspend than idle so we needed wakelocks to get more than 24 hours
>> battery life. We kept wakelocks when we moved to the msm platform
>> since it reduces our power consumption.
>
> Is it generally true among embedded systems nowadays that idle is
> capable of reaching essentially the same power states as suspend?

Embedded system in general, no, but all the recent SOCs I've seen that
target phones do.

-- =

Arve Hj=F8nnev=E5g
