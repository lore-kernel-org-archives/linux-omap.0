From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 5/6] ARM: OMAP2: drop redundant pending write check for
 gptimer
Date: Sun, 7 Dec 2008 08:55:54 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D05AD4C@dlee02.ent.ti.com>
References: <20081205023737.3868.78857.stgit@localhost>
 <20081205024121.3868.18876.stgit@localhost>
 <20081207112511.GB1646@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59520 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbYLGO4W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Dec 2008 09:56:22 -0500
In-Reply-To: <20081207112511.GB1646@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> On Thu, Dec 04, 2008 at 06:41:21PM -0800, Tony Lindgren wrote:
> > omap_dm_timer_write_reg() already waits for pending writes to complete,
> > so the extra wait in omap_dm_timer_set_load() is superfluous.
>
> Is this right?  I mean - do you have to wait for each individual write
> to each register to complete before writing the next (and different)
> register?

No, the effect is not as your guessing.

Each effected register has a posting bit in 3430 which is tracked (see TWPS register).  You must be careful with reads or re-writes of the _same_ register.

> Given that the code waits for every write to complete, no wonder Richard
> Woodruff is complaining that the NOHZ code is poor (it isn't) - with three
> writes each waiting for the previous to complete- what was it, 78us each,
> to complete?  That's 234us just to reprogram the timer hardware with the
> CPU spinning waiting for each of the posted writes to complete.

In the above hack a while back I was wondering if 1 write was overtaking another causing some issue.  That hack kept it working at that time and it doesn't affect functionality.

Yes, NOHZ is _poor_ today in respect to needless reprogramming. Code can be improved. I have sent Thomas a patch for the same which is in the MM tree for a while now.

Today on every interrupt entry (> 2.6.27) and exit (all versions) it can potentially reprogram the hardware with the _same_ event.  If interrupts come in fast from a device (like MUSB) this will cause backing up at the posting during needless reprograms.  You never get all the way out of the NOHZ code before another interrupt comes.  This effect drops USB performance by 3x as shown by usbtest. A simple and correct tweak recovers that lost 3x in performance.

Regards,
Richard W.

