From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 08/12] ARM: OMAP4: hwmod data: add SL2IF hardreset
 line
Date: Thu, 14 Jun 2012 11:09:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206141052240.30212@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004614.20034.50895.stgit@dusk> <4FD9DF2A.3010000@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38521 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab2FNRJ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 13:09:59 -0400
In-Reply-To: <4FD9DF2A.3010000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

Hi

On Thu, 14 Jun 2012, Cousson, Benoit wrote:

> I don't think we should allow that at hwmod level. This line is already
> handled by the IVAHD hwmod. We will then have some potential issue since
> nothing will prevent the concurrent access.
> Moreover that IP is only used by the IVAHD and thus should be handled by the
> same driver. The SL2 being inside the IVA subsystem, it should be reset when
> the IVA will be reset and thus does not require an individual control.

If a hardreset line will affect an IP block, then the line should be 
listed as one of the IP block's hardreset lines.  Otherwise, the hwmod 
data will not accurately reflect the hardware -- the ultimate goal.

> I guess, we should just mark the dependency with some external power resource
> to avoid the fmwk to try to enable that automatically.

Right now, the presence of a hardreset line will effectively cause the 
hwmod code to ignore the IP block from a reset and enable point of view.  
So the IP block won't be enabled automatically right now anyway, since we 
still don't have a clear sense of how to handle those.

> It is similar to DSS sub IPs and to some extend McPDM for my point of view.

These seem like different cases to me.

The DSS has no hardreset and the sub-IPs have their own softreset bits.  
As far as I know, the main reason why we can't have individual reset 
functions for the DSS sub-IPs is because we don't have hierarchical IP 
block enable/disable implemented in the hwmod code, not any real hardware 
constraint.

McPDM has a functional clock dependency on an external (non-SoC) device 
that's only controllable via I2C.  And, the McPDM can block the ABE 
clockdomain from going idle.  That's just wacky.

So those cases seem quite different to me.  One is a software issue.  And 
the other is an off-chip (non-OMAP) dependency, unlike the SL2IF/IVAHD 
issue in which all the needed resources are still on-chip.

> Maybe we should rename HWMOD_EXT_OPT_MAIN_CLK with something more 
> generic like HWMOD_EXT_POWER_DEP to highlight the dependency with an 
> external resource. It can be a external clock or another module.

Yes, I agree that it would be convenient to have some flag, either on the 
hwmod or the hardreset line, to indicate that some of the reset lines are 
shared.


- Paul
