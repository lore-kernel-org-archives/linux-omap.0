From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the display
 options
Date: Thu, 28 Mar 2013 18:09:16 +0200
Message-ID: <51546B2C.2030101@compulab.co.il>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:51912 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204Ab3C1QJY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 12:09:24 -0400
In-Reply-To: <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mike Rapoport <mike@compulab.co.il>

On 03/28/13 14:49, Tomi Valkeinen wrote:
> Boards with multiple display options for the same video bus have all the
> possible linux display devices present at the same time. Only one of
> those devices should be used at a time, as the video bus cannot be
> shared.

Yes, only one can be used at a time, but you can switch at runtime...

> 
> This model is hacky, and will be changed in the forthcoming DSS patches
> to a model where only one display device can be present on a single
> video bus.

What do you mean by "present"?
Is it active? or registered? or compiled in?

> 
> This patch creates Kconfig options to select which of the display
> devices is present on the board. While this model is also somewhat
> hacky, and prevents us from using a single kernel image for all the
> display options, it allows us to make the DSS driver changes for DT
> adaptation. And with DT, the information about display devices can be
> passed from the bootloader, solving the mess.

Hmmm, the fact that we cannot use the same binary for multiple displays...
This does not sound right and good at all...
While we try to move to support multiple platforms in the same binary, we
cannot support multiple displays? I agree that the multiplatform stuff is
not really related, but you know what I mean...

I bet there must be a much better solution for DT support.


-- 
Regards,
Igor.
