From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 09:11:44 +0200
Message-ID: <1275030704.32462.11.camel@laptop>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	 <Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	 <20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	 <20100527220949.GB10602@srcf.ucam.org>
	 <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	 <20100527223605.GB11364@srcf.ucam.org>
	 <20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>
	 <20100528043114.GC26177@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100528043114.GC26177@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tytso@mit.edu
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-05-28 at 00:31 -0400, tytso@mit.edu wrote:
> Keep in mind, though, that a solution which is acceptable for Android
> has to include making sure that crappy applications don't cause the
> battery to get drained.  There seem to be some people who seem
> adamently against this requirement.  

Again, Alan, Thomas and myself don't argue against that, what we do
however argue against is suspend running apps as a form of power
management.

If you were to read Alan's latest posts he clearly outlines how you can
contain crappy apps.

A combination of weakening QoS guarantees (delaying wakeups etc.)
blocking on resources (delay servicing requests) and monitoring resource
usage (despite all that its still not idle) and taking affirmative
action (shoot it in the head).

If we pose that a well behaved application is one that listens to the
environment hints and idles when told to, we can let regular power
management kick in and let deep idle states do their thing.

If a bad application ignores those hints and manages to avoid getting
blocked on denied resources, we can easily spot it and promote an
attitude of violence toward it in the form of SIGXCPU, SIGSTOP, SIGTERM
and SIGKILL, possibly coupled with a pop-up dialog -- much like we get
today when we try to close a window and the app isn't responding.

If we then also let the environment maintain a shitlist of crappy apps
(those it had to take affirmative action against) and maybe set up a
service that allows people to share their results, it provides an
incentive to the app developers to fix their thing.

How is this not working?
