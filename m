From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP3: GPIO fixes for off-mode
Date: Mon, 1 Dec 2008 11:26:54 -0800
Message-ID: <200812011126.55412.david-b@pacbell.net>
References: <> <1228131512-12099-1-git-send-email-tero.kristo@nokia.com> <1228131512-12099-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:40073 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751263AbYLAT06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 14:26:58 -0500
In-Reply-To: <1228131512-12099-2-git-send-email-tero.kristo@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

On Monday 01 December 2008, Tero Kristo wrote:
> Off mode is now using the omap2 retention fix code for scanning GPIOs
> only during off-mode transitions. All the *non_wakeup_gpios variables
> are now used for off-mode transition tracking on OMAP3. This patch fixes
> cases where GPIO state changes are missed during off-mode.

I second the "no #ifdefs" comment ...

Could you uplevel your description here a bit?  I'm trying to
understand if what this does is complete and correct.

My understanding is that we currently have several mechanisms
interacting to affect things that relate to the OMAP3-only
"off" modes for pins used as GPIOs:

 - irq_chip.set_wake() calls, for GPIOs used as IRQs.
   We should assume that if the IRQ is wake-enabled, that
   applies to OFF mode too.  (AFAICT, this mechanism is
   not handled by this patch.)

 - Hmm, and because a goal is to transparently enter OFF
   modes to save power, rather than only after drivers
   get suspend() calls that tend to trigger set_wake(),
   an un-commented conclusion seems to be that all GPIOs
   used as IRQs implicitly act like set_wake() was called.
   (Something which *is* partially addressed here.)

 - omap_cfg_reg() configuration for any pin can include
   its OFF-mode parameters.  Virtually unused ... and
   not addressed by this patch, so I'm puzzled how pins
   are expected to be kept active with just this patch.

 - OMAP2-specific bug workarounds, some GPIOs can't be
   used for wakeup, ergo bank->non_wakeup_gpios.  This
   is resolved for OMAP3, yes?

When I looked at this issue a while back, I came to believe
that we'd need to map GPIOs to their config registers so
we could diddle the OFF-mode bits.  And I don't see such
a mapping (table) here...

- Dave




