From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH 0/3] OMAP: hwmod: reset API proposal
Date: Wed, 27 Jun 2012 20:23:52 -0500
Message-ID: <CALLhW=7jt3J2GwLgD57qCx+_hpw3y=0kADdU=_uYRajq5FQy+A@mail.gmail.com>
References: <1339811681-5256-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37663 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab2F1BXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 21:23:53 -0400
Received: by vcbf11 with SMTP id f11so1175921vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 18:23:53 -0700 (PDT)
In-Reply-To: <1339811681-5256-1-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.luna@linaro.org>

Hi Paul,

On 15 June 2012 20:54, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
> Recent changes in omap_hwmod framework have reworked the behaviour
> towards hardreset handling, commit 747834a (ARM: OMAP2+: hwmod:
> revise hardreset behavior) recommends for drivers to implement
> their own reset sequences until code out-of-tree hits mainline
> and then their needs and code can be reviewed.
>
> Since it is not clear when this will occur for all drivers and
> hwmod code was not deleted (presumably because at some point it
> will handle the resets once again), this series exports functions
> to handle hardreset lines in an attempt to reduce code duplication
> for those who have a common reset sequence.
>
> These APIs are intended to be used by iommu for now, but were
> tested with IPU and remoteproc on Pandaboard.

Do you have any comments for these patches?

Regards,

Omar
