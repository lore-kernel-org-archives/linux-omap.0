From: Linus WALLEIJ <linus.walleij@stericsson.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 26 May 2010 09:23:47 +0200
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025A7D7DC4@EXDCVYMBSTM006.EQ1STM.local>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl> <87sk68r1zh.fsf@deeprootsystems.com>
	<s2qd6200be21005031709r28420f0ezf3cf286517ee9114@mail.gmail.com>
	<alpine.DEB.2.00.1005141422110.3348@utopia.booyaka.com>
	<AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
	<alpine.DEB.2.00.1005172018380.27473@utopia.booyaka.com>
	<AANLkTinOFSVHnufbVKIei0KMbfkVvDgLVDRHkCldagfY@mail.gmail.com>
	<alpine.DEB.2.00.1005250050060.13376@utopia.booyaka.com>
	<AANLkTilj79bWWIxg-g6OmLtk37zaAdjntoJAfZPBivAV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilj79bWWIxg-g6OmLtk37zaAdjntoJAfZPBivAV@mail.gmail.com>
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
To: =?Windows-1252?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Walker <dwalker@codeaurora.>
List-Id: linux-omap@vger.kernel.org

[Arve wrote]
> On Tue, May 25, 2010 at 2:41 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Mon, 17 May 2010, Arve Hj=F8nnev=E5g wrote:
> >>
> >> How do you know if the work being done while suspending is work that
> >> is needed to suspend or work that should abort suspend?
> >
> > Consider a suspending system in which all "untrusted" processes have be=
en
> > placed into TASK_INTERRUPTIBLE state and have had their timers
> > disabled.[2] The only remaining work to do on the system is work that
> > needs to be done as part of the suspend process, or work that is part of
> > a
> > "trusted" process or the kernel. =A0If the suspend needs to be aborted =
due
> > to the arrival of an event, this can be handled as part of the standard
> > suspend process (described below).
> =

> That means modifying all kernel code that would use suspend blockers
> to abort suspend by returning an error from suspend instead. How is
> this better than using suspend blockers?

It will mean that the same API is used for blocking suspend in
regular suspend/resume, runtime PM runtime_suspend/runtime_resume
and now also suspend blockers, right? So only one code path for
drivers that want to support both, no?

That'll be a bit more elegant for drivers that want to support
both runtime PM and suspend blockers I believe.

Overall as a driver writer I'm quite confused at this point, if
I have a driver X, how is that code going to look if it is going
to support both runtime PM *and* suspend blockers? I don't say
it has to support both mechanisms in parallell, I'm even fine
with putting it in #ifdef:s, but how will the source code look?
A real-world example on a simple driver out of the Motorola Droid
git or so would help a lot.

It's quite relevant since e.g. all OMAP drivers will need this
modification to be used with Android-like systems, and at
ST-Ericsson we will need both runtime PM and suspend blockers for
our drivers as well. It will as a consequence affect the drivers
for all ARM reference boards since we use the drivers for ARM
PrimeCells. etc...

Now if this mechanism is going in, my main interest is that there
is some clearly cut way and design pattern for supporting both
runtime PM and suspend blocks.

Yours,
Linus Walleij
