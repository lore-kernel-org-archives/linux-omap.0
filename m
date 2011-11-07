From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH] ARM: OMAP: Fix build for OMAP3 only builds
Date: Mon, 7 Nov 2011 17:06:08 +0000
Message-ID: <20111107170608.GD15294@n2100.arm.linux.org.uk>
References: <1318421036-1498-1-git-send-email-weber@corscience.de> <B85A65D85D7EB246BE421B3FB0FBB5930328C7C406@dbde02.ent.ti.com> <4EB1398B.80901@gmail.com> <20111102171605.GK31337@atomide.com> <20111103183001.GU31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54236 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab1KGRGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 12:06:31 -0500
Content-Disposition: inline
In-Reply-To: <20111103183001.GU31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Weber <thomas.weber.linux@googlemail.com>, "Nori, Sekhar" <nsekhar@ti.com>, Thomas Weber <weber@corscience.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Nov 03, 2011 at 11:30:02AM -0700, Tony Lindgren wrote:
> Considering we now have the DT branch merged, I'll apply the earlier
> patch from Sanjeev with a minor modification to avoid a build
> warning in board-generic.c.
> 
> Updated patch below, Sekhar & Thomas, care to ack?

When are we likely to see this patch in mainline given that my OMAP
builds are yet again broken during the merge window?

(You can *and should* send fixes for regressions during the merge window.
If you want to batch them up and send them towards the end of the merge
window, that's a good idea too.  But to have a broken -rc1 is bad
practice.)
