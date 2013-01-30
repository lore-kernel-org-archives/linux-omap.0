From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v3 2/2] ARM: OMAP4: setup SoC model name during ID
	initialisation
Date: Wed, 30 Jan 2013 15:57:57 +0000
Message-ID: <20130130155757.GK2637@n2100.arm.linux.org.uk>
References: <1359558091-29251-1-git-send-email-ruslan.bilovol@ti.com> <1359558091-29251-3-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59132 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab3A3P6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jan 2013 10:58:06 -0500
Content-Disposition: inline
In-Reply-To: <1359558091-29251-3-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, eduardo.valentin@ti.com

On Wed, Jan 30, 2013 at 05:01:31PM +0200, Ruslan Bilovol wrote:
> Set up the SoC model name during OMAP ID initialisation
> so it will be displayed in /proc/cpuinfo:
> 
> / # cat proc/cpuinfo
> [...]
> CPU variant     : 0x2
> CPU part        : 0xc09
> CPU revision    : 10
> 
> SoC name        : OMAP4470

Hmm.  Still not happy.  Wasn't there some SoC infrastructure added to the
kernel to export this kind of information via sysfs?  See:

Documentation/ABI/testing/sysfs-devices-soc
