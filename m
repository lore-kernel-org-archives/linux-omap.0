From: Jacek Burghardt <JacekBurghardt@caias.us>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
	multiple readers
Date: Sun, 21 Nov 2010 20:03:23 +0000
Message-ID: <3r3uw0pt42hbqvtsfo5996q6.1290369799122@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from host6.netdorm.com ([64.182.105.6]:52508 "EHLO host6.netdorm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab0KUUoU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Nov 2010 15:44:20 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "balbi@ti.com" <balbi@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, linux omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>



Felipe Balbi <me@felipebalbi.com> wrote:


Hi Hari,

On Fri, 2010-11-19 at 22:01 -0600, Kanigeri, Hari wrote:
> Of course :), profiling was done before releasing this code and no
> difference observed with or without blocking notifier. All the OMAP4

would you share some numbers ?

> use cases are exercising this code. Just curious , are you doubting
> the blocking notifier mechanism ?

a little bit. Yeah. It added about 600ms of time spent on musb's probe
when we were using blocking notifier for charger detection. When we
moved to atomic notifier, that was solved. Anyway, you can never be sure
when that will be scheduled and if cpu is really busy, it might pose a
great deal.

--
balbi
