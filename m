From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: suspend blockers & Android integration
Date: Sun, 06 Jun 2010 09:31:46 -0500
Message-ID: <1275834706.7227.545.camel@mulgrave.site>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	<20100604071354.GA14451@elte.hu>
	<AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
	<20100604083423.GD15181@elte.hu>
	<AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd@mail.gmail.com>
	<1275653210.27810.39762.camel@twins>
	<AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
	<1275731653.27810.41078.camel@twins>
	<20100605092851.6ee15f13@infradead.org>
	<AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
	<AANLkTimKknOurmCffOpHjc1FjrP2MKf10pBwEEbLJPg_@mail.gmail.com>
	<AANLkTil1NCX91bWhpXHtC88Opr29mNjdhXD9RXQ6DI0y@mail.gmail.com>
	<AANLkTin1Za3GvfIKbcZdx6TzjIHzCvsg5uaY_Vk4nJIh@mail.gmail.com>
	<AANLkTilQ1k78dDCYadOa1Wiyjm2nsBcRpxwdpGvYcf8z@mail.gmail.com>
	<AANLkTin7oM3gVwHbIHWqYV8yeC6bbQ4q2jDDxAgz3DwQ@mail.gmail.com>
	<20100606124601.2f1f6714@schatten.dmk.lab>
	<20100606120557.72356de9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100606120557.72356de9@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 2010-06-06 at 12:05 +0100, Alan Cox wrote:
> On Sun, 6 Jun 2010 12:46:01 +0200
> Florian Mickler <florian@mickler.org> wrote:
> 
> > On Sun, 6 Jun 2010 12:00:47 +0200
> > Vitaly Wool <vitalywool@gmail.com> wrote:
> > 
> > > Even worse, the suspend wakelock will keep the
> > > whole kernel active, as opposed to powering off unused devices
> > > separately as it's done in runtime PM. 
> > 
> > That is not true. While the kernel is not suspended it does
> > runtime pm.
> 
> On several of our platforms runtime PM already includes suspend so a
> suspend wakelock does interfere with existing power managemet at that
> level (not to mention the maintenance mess it causes).
> 
> This is one of the reasons you want QoS information, it provides
> parameters by which the power management code can make a decision.
> Suspend blocksers simply don't have sufficient variety to manage the
> direction of power policy.
> 
> If Android chooses to abuse the QoS information for crude suspend
> blocking then that is fine, it doesn't interfere with doing the job
> 'properly' on other systems or its use for realtime work on other boxes.

Right ... and I think we can make use of this as an incremental way
forwards.  This QoS re-expression needs doing for the suspend from idle
+ cgroup approach, and it can be made to work with the current suspend
blockers patch.

I've already posted most of the necessary improvements to pm_qos, all of
which end up looking like the right thing to do independent of android.
There's really only one remaining thing, and that's adding statistics.

Once stats are added, I think I can transform the 8 android patches into
a set of 7 pm_qos transformations and one patch that adds the
opportunistic suspend infrastructure.  The 7 pm_qos patches should be
reasonably uncontroversial, but what they would allow us to do is to
unblock about 75% of the driver divergences from Qualcomm and others.
The 1 opportunistic suspend one will be confined to one or two files, so
is easy to maintain ... we can then argue over who should maintain it in
the interim, us or Google.

>From this basis, we can then proceed to look at implementing the cgroups
+ suspend from idle approach, and we can do this regardless of whether
the opportunistic suspend patch is applied or not.

There are three reasons why the whole debate is going in circles

     1. Lots of people are taking a holistic approach (i.e. must solve
        everything) ... this means that previously unarticulated issues
        keep cropping up that are unrelated to the current patch set ...
        but which set off another cascade of emails.
     2. There currently is no cgroups + suspend from idle approach
        implemented anywhere.  That means we have to argue theoreticals
        rather than actuals (theoreticals are easy to shoot down with
        other theoretical arguments ... leading to another email
        cascade).  If we implemented the thing, these arguments would
        compare one factual basis to another.
     3. We've lost sight of one of the original goals, which was to
        bring the android tree close enough to the kernel so that the
        android downstream driver and board producers don't have to
        choose between the android kernel and vanilla kernel.

I think the proposal above gets us to within 75% of the way to 3, moves
us towards a factual basis for 2 and eliminates some of the grounds for
argument of 1 ... now can we please get on with it?

James
