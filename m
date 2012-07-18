From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 7/8] ARM: OMAP: clockdomain: add support for
 preventing autodep delete
Date: Wed, 18 Jul 2012 12:16:08 +0300
Message-ID: <1342602968.4672.92.camel@sokoban>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
	 <1342189185-5306-8-git-send-email-t-kristo@ti.com>
	 <5003F453.9020903@ti.com> <1342536971.4672.82.camel@sokoban>
	 <50066284.1030903@ti.com> <1342598720.4672.83.camel@sokoban>
	 <50067C0D.2040508@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40912 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab2GRJQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 05:16:15 -0400
In-Reply-To: <50067C0D.2040508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Wed, 2012-07-18 at 14:34 +0530, Rajendra Nayak wrote:
> On Wednesday 18 July 2012 01:35 PM, Tero Kristo wrote:
> > On Wed, 2012-07-18 at 12:45 +0530, Rajendra Nayak wrote:
> >> On Tuesday 17 July 2012 08:26 PM, Tero Kristo wrote:
> >>> Anyway, it also looks like this fix is no longer needed with the latest
> >>> kernel, something has changed with the gpio code / or latencies and it
> >>> doesn't crash anymore. Thus, it looks like patches 7&   8 can be dropped
> >>> from this set for now. This is the behavior with beagleboard at least,
> >>> if someone can verify this with some other omap3 hw that would be nice.
> >>
> >> I can test it on a omap3 SDP. What do you want me to test?
> >
> > Just try suspend + cpuidle with and without off-mode enabled and see if
> > there are any problems. I've usually seen problems with off-mode myself.
> 
> So I just knocked off the last 2 patches from 'mainline-3.5-rc6-pwrdm-
> changes-v4' and tested on my 3430 SDP.
> 
> I was able to hit RET and OFF in both suspend and cpuidle. Did not see
> any issues.

Okay thanks, so it looks pretty safe then.

-Tero

