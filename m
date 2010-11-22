From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: newbie: can I ask a question about linux-omap-pm on this mailing list?
Date: Mon, 22 Nov 2010 08:25:17 -0800
Message-ID: <87k4k5wck2.fsf@deeprootsystems.com>
References: <891232.80252.qm@web113817.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55805 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab0KVQZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 11:25:25 -0500
Received: by ewy5 with SMTP id 5so1736821ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 08:25:24 -0800 (PST)
In-Reply-To: <891232.80252.qm@web113817.mail.gq1.yahoo.com> (Gabi Voiculescu's
	message of "Mon, 22 Nov 2010 06:05:43 -0800 (PST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gabi Voiculescu <boy3dfx2@yahoo.com>
Cc: linux-omap@vger.kernel.org

Gabi Voiculescu <boy3dfx2@yahoo.com> writes:

> Thank you for your reply.
>
> I am a newbie when it comes down to Linux git repositories.
> I am trying to do a 2.6.32 paravirtualization on top of L4, to run on the beagleboard(omap3 CPU), using as native kernel one from the linux-omap-pm repository. 
>
> Why 2.6.32? It seems we have to run some userland modules that were written to be compatible with that version of Linux.
>
> One part of the problem is to select the best suitable native commit for this purpose.
>
> I am now trying to identify the best native commit from linux-omap-pm that fits the bill: working 2.6.32 + pm features for omap3 processors.
>
> My initial attempt was to use pm-2.6.32 branch (git checkout --track -b pm-2.6.32 origin/pm-2.6.32). 
>
> I realized there are issues with some devices: the USB host (EHCI) detecting hubs.
>
> I have some problems navigating the linux-omap-pm git repository and I would really appreciate some feedback on these questions:
>
> 1. Was the pm-2.6.32 branch designed to add pm features to the TI 2.6.32-omap and Torvalds 2.6.32?
>  1.1. if true, the pm-2.6.32 was focused on omap1 (not omap3) features?
>  1.2. if not true, is there a better branch/commit/tag that deals with pm features on the omap3 SOC?
>  1.3. As far as you know has any testing been performed on omap3 with a version of Linux close to 2.6.32?

This wiki might help a little:

   http://elinux.org/OMAP_Power_Management

But also, a little clarification: The PM branch is for experimental,
under development, rapidly changing, and unstable code.  As the code is
stabilized it merges upstream and disappears from the PM branch.  As
such, the PM branch should not be considered a stable development or
product base.  It's goal is to have a common base for the developers
working on the OMAP PM core, and be the queue for new PM features to
merge upstream.

The branches/snapshots taken at various kernel release (e.g. 2.6.32)
were for convenience, but there were no promises of stability or feature
completeness.

So, while I do maintain the PM branch, I do not support anything but the
current versions on the latest kernel, and even there I make no promises
of stability or feature completeness.

In other words, once PM features are stable and complete enough, they
merge into the mainline kernel, so only half-working or poorly designed
features are left in the PM branch.

I understand this probably sounds kind of harsh, but that is the current
state of affairs.

That being said,  there are several code bases that used my pm-2.6.32
code base as a starting point (android-omap-2.6.32 for one) so you could
start there, but your chances of getting help/support from the community
on these older versions of the kernel are slim to none.

I realize this probably doesn't help much, but hope it at least
clarifies a little,

Kevin

>
>
> Thank you for your input,
> Gabi Voiculescu
> --- On Mon, 11/22/10, S, Venkatraman <svenkatr@ti.com> wrote:
>
>> From: S, Venkatraman <svenkatr@ti.com>
>> Subject: Re: newbie: can I ask a question about linux-omap-pm on this mailing list?
>> To: "Gabi Voiculescu" <boy3dfx2@yahoo.com>
>> Cc: "linux-omap" <linux-omap@vger.kernel.org>
>> Date: Monday, November 22, 2010, 12:36 PM
>> > Hi.
>> >
>> > I want to ask a newbie questions regarding
>> linux-omap-pm repositories(http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary).
>> >
>> > I know this mailing list is for the linux-omap
>> repository. I have searched the web for a mailing list
>> specific for linux-omap-pm without success.
>> >
>> > Is this the right mailing list to pose my question?
>> > If not, can you point me to a better one?
>> >
>> 
>> You have come to the right place. The linux-omap-pm tree is
>> maintained
>> by Kevin Hilman, and he checks this mailing list
>> regularly.
>> Ask away...
>> 
>
>
>       
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
