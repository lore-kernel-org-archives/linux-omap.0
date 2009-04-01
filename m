From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Tue, 31 Mar 2009 21:11:46 -0700
Message-ID: <873actrp19.fsf@deeprootsystems.com>
References: <87bprz9zju.fsf@deeprootsystems.com>
	<49C940CA.9070805@deeprootsystems.com>
	<f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
	<f9d2a5e10903301044u775edfdo7ac540b3e1bdc597@mail.gmail.com>
	<873acu26ms.fsf@deeprootsystems.com>
	<f9d2a5e10903301601q5fcd331bs44c81d854ad0082f@mail.gmail.com>
	<87myb1wnvc.fsf@deeprootsystems.com>
	<f9d2a5e10903311431r6f053f02l25aba8183233c2b9@mail.gmail.com>
	<87iqlpuv1c.fsf@deeprootsystems.com>
	<f9d2a5e10903311830u1ea8b5dgb485a19c523f845f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:31201 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbZDAELv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 00:11:51 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3386292rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 21:11:49 -0700 (PDT)
In-Reply-To: <f9d2a5e10903311830u1ea8b5dgb485a19c523f845f@mail.gmail.com> (Russ Dill's message of "Tue\, 31 Mar 2009 18\:30\:33 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russ Dill <russ.dill@gmail.com> writes:

[...]

>
> root@beagleboard:/sys/power# echo 1 > clocks_off_while_idle
> root@beagleboard:/sys/power# echo 1 > enable_off_mode
> root@beagleboard:/sys/power# echo 1 > voltage_off_while_idle
> root@beagleboard:/sys/power# echo mem > state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> omapfb omapfb: timeout waiting for FRAME DONE
> Successfully put all powerdomains to target state
> Restarting tasks ... done.
>
> Neato :) This is still with all the user processes running an with a
> NAND filesystem. I'm still getting rather high ~80mA@5V power
> consumption, so I'll need to further investigate what rails the
> twl4030 is actually turning off.

Great!  glad it worked for you.

The kernel has some work to do to be sure that *everything* is
properly init'd to allow proper idle states.  Until then,
unfortunately we have to rely on more gentle bootloaders.

And FWIW, on my Beagle, I've never seen < 80mA either, but I haven't
done any further digging.

Kevin
