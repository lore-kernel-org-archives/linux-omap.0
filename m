From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v4 3/3] ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
Date: Fri, 23 Nov 2012 12:06:44 +0100
Message-ID: <87r4nkefy3.fsf@dell.be.48ers.dk>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
	<1353338956-19420-4-git-send-email-zonque@gmail.com>
	<87zk2djox6.fsf@dell.be.48ers.dk> <50AF51AF.4050003@gmail.com>
	<87vccwegu2.fsf@dell.be.48ers.dk> <50AF5610.7010505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42596 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab2KWLHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 06:07:34 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so544462wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Nov 2012 03:07:32 -0800 (PST)
In-Reply-To: <50AF5610.7010505@gmail.com> (Daniel Mack's message of "Fri, 23
	Nov 2012 11:55:12 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com

>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:

Hi,

 >> The other comment was about hw-romcode not being a very good
 >> name, as it apparently means the 1bit hamming code and ECC layout used
 >> on the older omap3, and not E.G. the bch8/elm layout used by
 >> E.G. am335x.

 Daniel> So which name would you pick? "bch1"?

No, it's hamming code, isn't it? To me it seems similar to the elm
discussion, E.G. we have a mix of ECC algorithm + ECC layout + use of hw
acceleration or not.

The choice of hardware acceleration or not should preferably be
transparent to this binding (E.G. it is purely an optimization, ECC
strength/format shouldn't change), so the driver should be free to
use it if it is available.


 Daniel> Thanks for the feedback - I'd also like to get these bindings
 Daniel> right in the first place.

Me too!

-- 
Bye, Peter Korsgaard
