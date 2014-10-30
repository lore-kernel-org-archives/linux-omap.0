From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 08/10] ARM: OMAP2+: Drop legacy code for gpmc-smc91x.c
Date: Thu, 30 Oct 2014 16:28:56 +0200
Message-ID: <54524B28.4080005@ti.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com> <1414628948-30702-9-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46872 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758147AbaJ3O3V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2014 10:29:21 -0400
In-Reply-To: <1414628948-30702-9-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

On 10/30/2014 02:29 AM, Tony Lindgren wrote:
> This code was only used by 2430sdp, 3430sdp, and n900 development
> boards.
> 
> The 2430sdp is already device tree only, and all the users of the
> 3430sdp and n900 development boards are already booting in device
> tree mode, so we can drop the legacy smc91x support.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

