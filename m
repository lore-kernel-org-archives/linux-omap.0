From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [RFC][PATCH] ARM: OMAP: McBSP: Use register cache
Date: Fri, 04 Sep 2009 14:07:11 +0300
Message-ID: <1252062431.23177.68.camel@eenurkka-desktop>
References: <1252042776.23177.39.camel@eenurkka-desktop>
	 <200909041234.06121.jkrzyszt@tis.icnet.pl>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16818 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbZIDLId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 07:08:33 -0400
In-Reply-To: <200909041234.06121.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "e3-hacking@earth.li" <e3-hacking@earth.li>

On Fri, 2009-09-04 at 12:34 +0200, ext Janusz Krzysztofik wrote:
> in normal (handset) mode, the noise level seems still acceptable. The only
> missing piece of a puzzle is my patch, that prevents the kernel driver from
> putting corrupted values into the McBSP control registers.
> 
> That learned, please reconsider:
> 1. Can my patch break anything, related or not?

That needs to be investigated in more detail.

> 2. How does it affect performance of otherwise unaffected machines?

Like you already know, shouldn't.

> 3. Is correcting a poorly designed machine behaviour worth of the change?
> 
> Thanks,
> Janusz


I'd say this is in the right track. All McBSP registers
(not status etc) will need to be stored in memory. (Now, they're not).
And all those register contents will need to be written back
in certain situations. So this is the case when there is an external
audio chip, that takes audio in in bursts. So once the
burst is complete, all McBSP clocks will be disabled for a duration.

Then (at least >= 3430) device will hit OFF mode, meaning
all register contents are lost, also McBSP's. They will
need to be written back at some point.

My quick verdict is, that your patch is, going into right
direction. But the thing is that my words don't count much ;)

(Possibly worth taking the patch in, if guaranteed to not break
 any others).

- Eero

