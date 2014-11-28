From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Sat, 29 Nov 2014 00:26:30 +0200
Message-ID: <20141128222630.GA1382@fuloong-minipc.musicnaut.iki.fi>
References: <20141027200008.GR2560@atomide.com>
 <201411271232.47231@pali>
 <20141128202719.GU2817@atomide.com>
 <201411282241.12095@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:56294 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaK1W0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2014 17:26:39 -0500
Content-Disposition: inline
In-Reply-To: <201411282241.12095@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Nov 28, 2014 at 10:41:12PM +0100, Pali Roh=E1r wrote:
> Does kernel provide some interface for telling userspace
> applications something like bootreason (e.g power key, software
> reset, rtc alarm, charger connected, ...)?

In N950/N9, NOLO passes this information using kernel command line
and applications are reading /proc/cmdline. If I remember correctly all
those custom proc files were removed from Nokia kernel, and everything
was passed via command line.

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
