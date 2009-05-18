From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Mon, 18 May 2009 15:47:31 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038BED5E2B@dlee02.ent.ti.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
 <20090518133241.GH3067@n2100.arm.linux.org.uk>
 <878wku8hkb.fsf@deeprootsystems.com>
 <13B9B4C6EF24D648824FF11BE8967162038BED5CA9@dlee02.ent.ti.com>
 <20090518202431.GM7042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59439 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbZERUsB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 16:48:01 -0400
In-Reply-To: <20090518202431.GM7042@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>


> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, May 18, 2009 3:25 PM

> The call to the enter method essentially calls the core specific suspend
> function (eg, pxa25x_cpu_suspend()), which is an assembly function which
> ultimately ends up powering down the core resulting in full loss of state
> in the CPU.  We seem to be able to avoid having to save the exception mode
> registers there.
>
> The same thing is done with sa11x0 and Samsung SoCs.
>
> I don't see any reason for OMAP to be "special" in this regard.

The code flow is:
        - Wakeup event
        - ARM reboots and uses SOC mask ROM context restore helper
        - Mask ROM code jump to restore pointers with MMU OFF.
        - Restore code resets ARM CortexA8 state
        -*- Trustzone SMI calls are made to restore some secure state
        - Jump back from SRAM to C code

The dangling question to me is if any of the cpu state is needed by the trustzone monitor code as a precondition.  The doc's I have led me to believe its ok, but I've not verified this.

Regards,
Richard W.

