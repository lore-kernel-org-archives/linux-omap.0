From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 07/10] ARM: OMAP2+: Require proper GPMC timings for devices
Date: Thu, 30 Oct 2014 16:27:25 +0200
Message-ID: <54524ACD.2030406@ti.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com> <1414628948-30702-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48930 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754623AbaJ3O1u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2014 10:27:50 -0400
In-Reply-To: <1414628948-30702-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

On 10/30/2014 02:29 AM, Tony Lindgren wrote:
> Now that we have timings in the .dts files for smc91x
> and 8250, we can remove the device specific checks and
> just print out the bootloader timings for devices that
> may not have timings in the .dts files.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
