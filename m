From: Afzal Mohammed <x0148406@ti.com>
Subject: Re: [PATCH v2 00/14] OMAP-GPMC related cleanup for common zImage
Date: Wed, 17 Oct 2012 10:59:47 +0530
Message-ID: <507E424B.8040706@ti.com>
References: <cover.1349672877.git.afzal@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9F7B0A@DBDE01.ent.ti.com> <20121010163840.GA13585@parrot.com> <20121016180600.GA15569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59840 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab2JQFaN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 01:30:13 -0400
In-Reply-To: <20121016180600.GA15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ivan Djelic <ivan.djelic@parrot.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, "Hunter, Jon" <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Ivan,

On Tuesday 16 October 2012 11:36 PM, Tony Lindgren wrote:
> * Ivan Djelic<ivan.djelic@parrot.com>  [121010 09:40]:

>> I ran several mtd regression tests on a Beagle Board on your gpmc-czimage-v2 tag.
>> All BCH error correcting tests passed successfully.

>> I occasionally had weird read errors though, especially when reading blank pages:
>> the omap driver returned 512-byte sectors containing something like:

>> I was able to reproduce the problem also on l2-mtd tip, albeit less often.
>> The problem seems to occur quite randomly, it may be a hardware issue on
>> my board...

> Things like this typically happen in the GPMC timings are not correct.
> Maybe add #define DEBUG to top of gpmc.c and compare the timings
> before and after Afzal's patches?

Latest series for gpmc related cleanup for common zImage removed
dependency on minor timing cleanups (this series was dependent on
on another series that did minor timing cleanups).

A pull request for the new series on gpmc cleanup for common zImage
that does not contain timing related changes and without dependency
on timing related changes has been sent to Tony (forwarded to you now).
He has pulled those changes onto l-o in
"omap-for-v3.8/cleanup-headers-gpmc"

As there are no changes w.r.t timing's in the new series, behaviour
should be same as without.

>> Anyway, the ECC handling part looks OK to me.

Regards
Afzal
