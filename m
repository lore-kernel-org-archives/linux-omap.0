From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 11/19] ARM: OMAP4: PM: save/restore CM L3INSTR registers when MPU hits OSWR/OFF mode
Date: Wed, 16 May 2012 16:17:23 -0700
Message-ID: <87sjez67i4.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-12-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:43607 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932946Ab2EPXR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 19:17:27 -0400
Received: by pbbro8 with SMTP id ro8so2329755pbb.39
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 16:17:25 -0700 (PDT)
In-Reply-To: <1336990730-26892-12-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:18:42 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> On HS devices on the way out of MPU OSWR and OFF ROM code wrongly
> overwrites the CM L3INSTR registers. So to avoid this, save them and
> restore on the way out from MPU OSWR/OFF.
>
> This errata applies to all HS/EMU versions of OMAP4.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [t-kristo@ti.com: added omap4 pm errata support]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Let's use the cluster PM notifiers here too, using the PM errata check
when registering the notifier.

Kevin

