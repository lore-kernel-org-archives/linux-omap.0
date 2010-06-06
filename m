From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 12:36:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006061202351.2933@localhost.localdomain>
References: <20100603193045.GA7188@elte.hu> <20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<201006050138.30859.rjw@sisk.pl>
	<alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
	<AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
	<alpine.LFD.2.00.1006050246350.2933@localhost.localdomain>
	<AANLkTikU21xF49Z-_Lnrq7U7buNmqw_gyEEST8LuN24z@mail.gmail.com>
	<alpine.LFD.2.00.1006051736040.2933@localhost.localdomain>
	<AANLkTinD39rI47innPbGz1Gi8PsXV5HqkmaQuJ70oQ63@mail.gmail.com>
	<alpine.LFD.2.00.1006052348200.2933@localhost.localdomain>
	<AANLkTikmWDHYJ8wWF2cZapbkHHjV09R39I37yvQXFmor@mail.gmail.com>
	<alpine.LFD.2.00.1006060148470.2933@localhost.localdomain>
	<AANLkTikdM79nmARagK9gLveMWEiT6rlk44UELes1k8Ch@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-339667858-1275819785=:2933"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikdM79nmARagK9gLveMWEiT6rlk44UELes1k8Ch@mail.gmail.com>
Content-ID: <alpine.LFD.2.00.1006061233360.2933@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-339667858-1275819785=:2933
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.LFD.2.00.1006061233361.2933@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o56Aap05004420

On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> > On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> >> > On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> >> > That download might take a minute or two, but that's not an
> >> >> >> > justification for the crapplication to run unconfined and pr=
event
> >> >> >> > lower power states.
> >> >> >> >
> >> >> >>
> >> >> >> I agree, but this is not a simple problem to solve.
> >> >> >
> >> >> > Not with suspend blockers, but with cgroup confinement of crap,=
 it's
> >> >> > straight forward.
> >> >> >
> >> >>
> >> >> I don't think is is straight forward. If the a process in the fro=
zen
> >> >> group holds a resource that a process in the unfrozen group needs=
, how
> >> >> do deal with that?
> >> >
> >> > I'm going to fix the framework which puts the group into freeze st=
ate
> >> > w/o making sure that there is no held shared resource. Come on it'=
s
> >> > not rocket science.
> >> >
> >>
> >> I'm not sure which framework you are talking about here, but I don't
> >> think there is a single framework that knows about all shared
> >> resources.
> >
> > Damn, it's not me talking about "our framework", you are mentioning
> > when it fits your needs.
>=20
> You said you were going to fix the framework. I did know if you were
> talking about the cgroup framework, or the android user-space
> frameworks. I don't think either has knowledge about all shared
> resources.

The cgroup freezer makes sure that there are no in kernel resources
blocked. Of course the user space side has to do the same and it's not
rocket science.
=20
> >
> > If you do not have a clearly defined user space framework, then we
> > talk about a completely random conglomeration of applications which
> > need to be brought into submission by some global brute force
> > approach.
> >
> > I'm tired of this, really. You just use terminlology as it fits to
> > defend the complete design failure of android. But you fail to trick
> > me :)
> >
> > Can you please explain in a consistent way how the application stack
> > and the underlying framework (which exists according to android docs)
> > is handling events and how the separation of trust level works ?
> >
>=20
> I don't think I can, since I only know small parts of it. I know some

Sigh. That's the main reason why this discussion goes nowhere.

How in heavens sake can we make a decision whether suspend blockers
are the right and only way to go, when the people=20

> events like input event go though a single thread in our system
> process, while other events like network packets (which are also
> wakeup events) goes directly to the app.

--8323328-339667858-1275819785=:2933
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--8323328-339667858-1275819785=:2933--
