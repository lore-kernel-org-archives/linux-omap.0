From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: Don't allow moving managers away from
 enabled displays
Date: Thu, 04 Aug 2011 11:08:43 +0300
Message-ID: <1312445323.2143.8.camel@deskari>
References: <1312402251-31588-1-git-send-email-daniel.morsing@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58611 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751675Ab1HDIIs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 04:08:48 -0400
In-Reply-To: <1312402251-31588-1-git-send-email-daniel.morsing@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Morsing <daniel.morsing@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, 2011-08-03 at 22:10 +0200, Daniel Morsing wrote:
> If a manager is moved while attached to an enabled display, the DSS
> system will be left in an inconsistent state. This will eventually cause
> a kernel oops when the enabled display is disabled.
> 
> Fix this by not allowing the user to move a manager away from an enabled
> display.

Thanks, applying.

 Tomi


