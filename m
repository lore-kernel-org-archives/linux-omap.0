From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 00/19] OMAP: voltage layer cleanup and restructure
Date: Thu, 24 Mar 2011 17:02:02 -0700
Message-ID: <87lj04xe2t.fsf@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55120 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751110Ab1CYACG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 20:02:06 -0400
Received: by mail-gw0-f44.google.com with SMTP id 20so272334gwb.31
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 17:02:04 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com> (Kevin
	Hilman's message of "Wed, 23 Mar 2011 17:00:14 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Kevin Hilman <khilman@ti.com> writes:

> This series is the begining of a voltage layer cleanup and restruture
> with the primary goal of splitting up voltage domain, voltage
> processor (VP) and voltage controller (VC) code.
>
> The RFC part is for the last 3 patches in the series, and for
> discussion of how/if to split out the SoC specifics.  As an example, I
> started on the VC and split out some functionality (setting slave i2c
> addr, setting PMIC register addresses) into hooks that can be
> implemented in SoC specific code.  I'd appreciate any input on this
> approach as well as the types of functions/APIs that should exist at
> this level.

Based on some more discussions with Paul, I decided on a slightly
different approach based on a suggestion from Paul.

Rather than create the vc3xxx.c/vc4xxx.c files, instead I create the SoC
specific functions for the VC in the existing SoC specific PRM code
(prm2xxx_3xxx.c and prm4xxx.c.)

This new approach replaces patches 17 & 19 of $SUBJECT series, and I'll
post the two new patches in response to this mail as well.

I've also updated my pm-wip/voltdm branch to contain the new approach.

Comments welcome.

Kevin

