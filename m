From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: omap4-keypad: Remove the OMAP4_KBD_SYSCONFIG and
 OMAP4_KBD_SYSSTATUS
Date: Mon, 26 Nov 2012 10:01:58 -0800
Message-ID: <20121126180158.GD14623@core.coreip.homeip.net>
References: <1353927079-12493-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64166 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932772Ab2KZSCE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 13:02:04 -0500
Content-Disposition: inline
In-Reply-To: <1353927079-12493-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com

On Mon, Nov 26, 2012 at 04:21:19PM +0530, Shubhrajyoti D wrote:
> The macros OMAP4_KBD_SYSSTATUS and OMAP4_KBD_SYSSTATUS are not used
> so remove them.

They document the existing registers and do not add bloat to the
generated objects so let's leave them be.

Thanks.

-- 
Dmitry
