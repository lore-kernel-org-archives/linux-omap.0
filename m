From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/7] ARM: dts: AM43x: Add devcice tree nodes
Date: Wed, 9 Jul 2014 01:31:15 -0700
Message-ID: <20140709083114.GH28884@atomide.com>
References: <1404884193-20580-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31001 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaGIIbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 04:31:14 -0400
Content-Disposition: inline
In-Reply-To: <1404884193-20580-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mark.rutland@arm.com, galak@codeaurora.org, robh+dt@kernel.org, linux@arm.linux.org.uk, balbi@ti.com, kishon@ti.com, broonie@kernel.org

* Keerthy <j-keerthy@ti.com> [140708 22:40]:
> The patch series adds the device tree nodes and the corresponding
> documentation. The series also enabled tps65218 config options
> in the omap2plus_defconfig.
> 
> The series is boot tested on both AM43x-epos-evm and AM437x-gp-evm.

Are the .dts changes safe to apply separately without breaking
anything?

Regards,

Tony
