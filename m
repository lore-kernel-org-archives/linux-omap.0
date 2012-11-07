From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv9 0/8] ARM: OMAP4: core retention support
Date: Wed, 7 Nov 2012 18:35:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211071831370.20704@utopia.booyaka.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com> <87d2zrg04t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-459243304-1352313323=:20704"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48786 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab2KGSfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 13:35:24 -0500
In-Reply-To: <87d2zrg04t.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-459243304-1352313323=:20704
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Mon, 5 Nov 2012, Kevin Hilman wrote:

> # echo mem > /sys/power/state=20
> [  102.271087] PM: Syncing filesystems ... done.
> [  102.282196] Freezing user space processes ... (elapsed 0.02 seconds) d=
one.
> [  102.312133] Freezing remaining freezable tasks ... (elapsed 0.02 secon=
ds) done.
> [  102.343353] Suspending console(s) (use no_console_suspend to debug)
> ???[  102.363433] PM: suspend of devices complete after 10.650 msecs
> [  102.365631] PM: late suspend of devices complete after 2.166 msecs
> [  102.369201] PM: noirq suspend of devices complete after 3.509 msecs
> [  102.369232] Disabling non-boot CPUs ...
> [  102.373016] CPU1: shutdown

[...]

By the way, looks like you're seeing the same garbage character generated=
=20
as I was on v3.6 with these patches.  It's the first character of the line=
=20
that's dated "102.363433".  At 230kbps, it comes across as a "5" that the=
=20
OMAP thinks originates from the host computer, sent to the Panda.

Would be useful if someone could identify what's causing this.  None of=20
the OMAP3 boards currently exhibit this behavior.  Would na=C3=AFvely assum=
e=20
that the OMAP4 is waking up fast enough to capture some of the bits of the=
=20
serial wakeup character, but have not confirmed this.


- Paul
--843723315-459243304-1352313323=:20704--
