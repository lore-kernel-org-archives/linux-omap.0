From: Brian Swetland <swetland@google.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 15:59:16 -0700
Message-ID: <AANLkTil-Ky5L84JF7xn6su8VMtglBpZwCNIh7VgBiHgL@mail.gmail.com>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	 <878w7mgqse.fsf@deeprootsystems.com>
	 <87tyqaduvr.fsf@deeprootsystems.com> <201005142350.01222.rjw@sisk.pl>
	 <87k4r69k61.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:6650 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676Ab0ENW7U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 18:59:20 -0400
In-Reply-To: <87k4r69k61.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tony Lindgren <tony@atomide.com>, Matthew Garrett <mjg@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, May 14, 2010 at 3:45 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>>> Personally, I suspect that lack of this feature is not the real
>>> obstacle to getting these out-of-tree drivers upstream. =C2=A0Havin=
g this
>>> API upstream will not change the product schedules and corporate
>>> cultures that have prevented code from making its way upstream.
>>
>> But apparently it is considered as a suitable excuse.
>
> No, it is not a _technical_ excuse. =C2=A0Just a healthy, experience-=
based
> dose of skepticism.
>
> It was expressed because I find the arguments above for merging
> because it prevents out-of-tree drivers from merging quite
> unconvincing. =C2=A0This is not just about opportunistic suspend + su=
spend
> blockers specifically but comes from several years experience in the
> embedded Linux world.

It provides useful functionality -- you apparently disagree, but the
wakelock/suspendblock model is in use, shipping, and solving problems
for quite a lot of android devices that have been shipping for a while
now.  We actively go to lowest power state in idle (on omap, msm,
etc), and use drivers that aggressively declock and depower modules
(similar to runtime pm), but we have found that using the
opportunistic suspend model combined with wakelocks allows us to
attain even lower average power consumption in always-connected,
actively-syncing devices.

It has been claimed that because Android userspace makes use of this
functionality a number of silicon vendors who want to submit code
upstream are inconvenienced by having to maintain "android" and
"mainline" versions of their drivers.  I can't speak for them, since
nobody has identified the particular inconvenienced vendors to me, nor
have they spoken with me directly, but personally I do find that
having to maintain two different versions of drivers (one version for
upstream, one for shipping products) is inconvenient.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
