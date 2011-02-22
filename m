From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/3] OMAP2+ hwmod fixes
Date: Tue, 22 Feb 2011 12:09:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102221200260.22636@utopia.booyaka.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com> <4D5BCC10.2060301@ti.com> <6cc4b2788ff1e15c22987d5db91f0395@mail.gmail.com> <4D5E85EA.70605@ti.com> <alpine.DEB.2.00.1102210901140.22636@utopia.booyaka.com>
 <e6550ef1ea27499e3bc093e264c54d0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54343 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab1BVTJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 14:09:57 -0500
In-Reply-To: <e6550ef1ea27499e3bc093e264c54d0f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rajendra

On Tue, 22 Feb 2011, Rajendra Nayak wrote:

> The original behavior of the iterators, to terminate upon
> encountering an error, seems fine to me. The only problem
> I faced was that they fail silently and go undetected, unless
> their user catches the return value and WARN's, which I found
> was not the case with most users, mainly those of
> omap_hwmod_for_each_by_class.
> I was thinking of keeping the behaviour of these iterators
> same for now and add WARN's in these iterators itself upon
> an error, so its seen even if the user fails to catch it.

What's your opinion on adding the pr_err() or WARN() into the code that 
the iterator calls for each hwmod?  That code should know why something 
fails, so it should be able to provide a more detailed error message.  Of 
course, it is not as general a solution...


- Paul
