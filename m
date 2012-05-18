From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: fix gpmc request_irq
Date: Fri, 18 May 2012 07:16:55 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
 <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49954 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab2ERHRO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 03:17:14 -0400
In-Reply-To: <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <ming.lei@canonical.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

Hi Santosh,

On Fri, May 18, 2012 at 12:33:16, Shilimkar, Santosh wrote:
> + Afzal who has been doing quite a bit of GMPC work recently.
> 
> On Fri, May 18, 2012 at 10:13 AM, Ming Lei <ming.lei@canonical.com> wrote:
> > The IRQ52 on OMAP2+ is not a shared interrupt line. If IRQF_SHARED
> > is passed to request_irq and dev_id is set as NULL, request_irq will
> > return -EINVAL.
> >
> GPMC IRQ line can shared between the multiple devices you
> connect on it.
:
> Are you sure it fails ?
> I just tried booting OMAP4 with 3.4-rc4 and don't see the irq
> failure error message. What I am missing ?

Issue happens on l-o master, this was mentioned in [1], now I feel
right solution is to keep dev-id.

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68749.html
