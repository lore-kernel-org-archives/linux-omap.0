From: Juha Yrjola <juha.yrjola@solidboot.com>
Subject: Re: [PATCH 02/12] ARM: OMAP3: Store reboot mode in scratchpad on
 OMAP34xx
Date: Mon, 16 Mar 2009 18:07:07 +0200
Message-ID: <49BE792B.1090901@solidboot.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210333.16425.80205.stgit@localhost> <20090315155105.GB10786@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from solidboot.com ([92.48.122.80]:48392 "EHLO rei.solidboot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbZCPQGP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2009 12:06:15 -0400
In-Reply-To: <20090315155105.GB10786@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Russell King - ARM Linux wrote:

>> The reboot mode can be communicated to a bootloader (or the
>> kernel itself) with a scratchpad register. This functionality
>> is especially useful, if userspace is allowed to change
>> the reboot mode.
> 
> The reason for this being...

If my other patch [1] is applied, we are able to let user space tell the 
bootloader which mode to boot to.

On the Nokia Linux mobile devices, flashing is done mostly by the 
bootloader. If a USB host is connected at bootup, we enter a USB loop 
with a certain timeout. The timeout is disabled when the first flashing 
command arrives. This is no problem for Linux, but some unluckier 
operating systems are not able to even load their drivers quickly enough.

Hence, we need a way to let the bootloader know when to safely disable 
the timeout (when the user explicitly wants to perform flashing, that is).

Cheers,
Juha

[1] http://article.gmane.org/gmane.linux.ports.arm.kernel/53837
