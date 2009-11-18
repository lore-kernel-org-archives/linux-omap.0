From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v2 1/1] omap: serial: fix non-empty uart fifo read abort
Date: Wed, 18 Nov 2009 10:50:23 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C8630A@dbde02.ent.ti.com>
References: <1258501151-30866-1-git-send-email-vikram.pandita@ti.com>,<20091118010011.22360590@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59677 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbZKRFVv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 00:21:51 -0500
In-Reply-To: <20091118010011.22360590@lxorguk.ukuu.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 17 Nov 2009 17:39:11 -0600
Vikram Pandita <vikram.pandita@ti.com> wrote:

> OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
> Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.

Minor nitpicking for the changelog.

OMAP3430 is better instead of OMAP3 here, since the 3630 also qualifies
as OMAP3

>
> Overrigt the default 8250 read handler: mem_serial_in()

s/Overrigt/Overwrite

> by a custom handler: serial_in_8250()
>
> serial_in_8250() makes sure that RX fifo is not read when empty,
> on omap4 and 3630 silicons only
>
> tested on zoom3(3630) board
