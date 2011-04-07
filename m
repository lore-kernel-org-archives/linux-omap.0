From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH 2/2 v2] OMAP2/3: hwmod: fix gpio-reset timeouts seen
 during bootup.
Date: Thu, 7 Apr 2011 12:15:50 +0530
Message-ID: <20110407064550.GA19781@avinash-laptop>
References: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
 <1302018015-8858-3-git-send-email-avinashhm@ti.com>
 <BANLkTikwyk6b+d-QAz5LxuU_Lxgo4-A-hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44625 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752155Ab1DGGqG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 02:46:06 -0400
Received: by gwb17 with SMTP id 17so1227902gwb.15
        for <linux-omap@vger.kernel.org>; Wed, 06 Apr 2011 23:46:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikwyk6b+d-QAz5LxuU_Lxgo4-A-hg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

On Wed, Apr 06, 2011 at 11:28:00AM +0530, Gulati, Shweta wrote:
> Hi,
> 
> On Tue, Apr 5, 2011 at 9:10 PM, Avinash.H.M <avinashhm@ti.com> wrote:
> > GPIO module expects the debounce clocks to be enabled during reset. It doesn't
> > reset properly and timeouts are seen, if this clock isn't enabled during
> > reset. Add the HWMOD_CONTROL_OPT_CLKS_IN_RESET flags to the GPIO HWMODs, with
> > which the debounce clocks are enabled during reset.
> Minor comment,
> Rephrase as " GPIO module doesn't reset properly and timeouts are seen
> during bootup, if
> debounce clock is not enabled"
> to make commit log more clear.


Hi Shweta ,

thanks for the review.

i will fix the rephrase the change log .

br ,

- avinash

> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
