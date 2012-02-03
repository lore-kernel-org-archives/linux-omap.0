From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly in
 non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 14:12:20 +0200
Message-ID: <CAMP44s14dGFQgNY3WBqb6-nBFUFNCxhjpSD8Dw0ZTqzKe-dnWg@mail.gmail.com>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:49875 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754678Ab2BCMMW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 07:12:22 -0500
In-Reply-To: <20120203150708.386951d2@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Paul Walmsley <paul@pwsan.com>, Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 3, 2012 at 6:07 AM, NeilBrown <neilb@suse.de> wrote:
> If I then enabled runtime_pm with a 5 second autosuspend delay:
> =C2=A0CORE is still permanently ON (I think the USB might be doing th=
at).

Maybe related to this:
http://thread.gmane.org/gmane.linux.usb.general/56096

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
