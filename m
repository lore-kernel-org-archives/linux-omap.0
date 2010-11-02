From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 2/4] OMAP3: PM: update DSP reset code to use new SCM DSP boot control functions
Date: Tue, 02 Nov 2010 13:27:18 +0000
Message-ID: <874obzg8jt.fsf@deeprootsystems.com>
References: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
	<1288109763-9446-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62866 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab0KBN1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 09:27:33 -0400
Received: by wyf28 with SMTP id 28so6711653wyf.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 06:27:31 -0700 (PDT)
In-Reply-To: <1288109763-9446-3-git-send-email-omar.ramirez@ti.com> (Omar
	Ramirez Luna's message of "Tue, 26 Oct 2010 11:16:01 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Tero Kristo <tero.kristo@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Omar Ramirez Luna <omar.ramirez@ti.com> writes:

> From: Paul Walmsley <paul@pwsan.com>
>
> Update the DSP reset code in pm34xx.c to use one of the new SCM DSP
> boot control functions, omap2430_ctrl_set_dsp_bootmode().
>
> This reset code should be moved out to a separate function to be
> called by the hwmod reset process at some point.  Also, 2430
> should be initializing the DSP in a similar fashion.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

In PATCH 0/x, please report on what platforms this was tested.

Kevin
