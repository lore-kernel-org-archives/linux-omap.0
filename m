From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC] omap_pm_get_device_context_loss_count() support on OMAP4
Date: Wed, 15 Jun 2011 18:18:42 +0530
Message-ID: <4DF8AA2A.5050200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob116.obsmtp.com ([74.125.149.239]:55900 "EHLO
	na3sys009aob116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753840Ab1FOMzu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 08:55:50 -0400
Received: by gxk1 with SMTP id 1so306770gxk.10
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 05:55:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hi,

This is to take the discussion forward which I started here
http://marc.info/?l=linux-omap&m=130812942102354&w=2
on how to support the omap_pm_get_device_context_loss_count()
api on OMAP4.

I started to work on this and thought I almost had patches
which would do the job on OMAP4,(keep a per-module/hwmod
context count by looking at the per-module context registers
that exist on OMAP4, similar to the per-pwrdm count maintained by
looking at the per-pwrdm prepwrst registers on OMAP3)
until I realized my approach had 2 issues

-1- The book keeping (similar to whats done in pwrdm_pre_transition()
and pwrdm_post_transition()) was turning out to be quite expensive
to be done for *every* low power system/cpu transition.
(Btw, some profiling shows me the existing book keeping is quite
expensive already)

-2- Doing this book keeping *only* during low power system/cpu
transitions is'nt enough as there could be modules which can
independently transition while the MPU and L3 are still active
like DSS, ABE, GFX etc.
This was avoided on OMAP3 with 'autodeps' as described in the discussion
thread above which made book keeping in low power system/cpu
transitions work for all.

Issue -1- might be a little easy to solve if the book-keeping
needs to be done only for domains/modules which transition along
with the system/cpu. The book keeping can then only be done for
specific C states (and suspend) instead of doing it for all C states.

What I am unable to fix is Issue -2-.

Me and Santosh discussed a lot on how to handle this and we thought
with all the HW governed transitions, the only foolproof way of
doing this was if the HW itself could log a count instead of just
logging the state of previous transition.
(Which is not the case on OMAP4 :-))

Does anyone else see any other way of handling this (Issue -2-) on OMAP4
in software?

regards,
Rajendra/Santosh





