From: =?iso-8859-1?Q?Lo=EFc?= Minier <lool@dooz.org>
Subject: Re: [PATCH] OMAP: PM: Fix build when CONFIG_PM_DEBUG isn't set
Date: Mon, 27 Sep 2010 23:05:59 +0200
Message-ID: <20100927210559.GC21671@bee.dooz.org>
References: <1285421817-6431-1-git-send-email-loic.minier@linaro.org>
 <87d3rzotj6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from duck.dooz.org ([194.146.227.125]:34152 "EHLO duck.dooz.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab0I0VbG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Sep 2010 17:31:06 -0400
Content-Disposition: inline
In-Reply-To: <87d3rzotj6.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Thara Gopinath <thara@ti.com>

On Mon, Sep 27, 2010, Kevin Hilman wrote:
> Could you move these down into the exisint #ifdef CONFIG_PM_DEBUG a
> little bit later in the file (after where omap2_pm_debug.)

 I hesitated doing that since there were a couple of other ifdefs using
 CONFIG_PM_DEBUG later in the file; I will send an updated patch moving
 to the ifdef CONFIG_PM_DEBUG.

> Also, could you sign-off on the patch please?

 Ah sorry about that

--=20
Lo=EFc Minier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
