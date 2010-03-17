From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCHv2 0/3] OMAP: DSS2: Allow us to use SDI
Date: Wed, 17 Mar 2010 16:10:50 +0200
Message-ID: <1268835050.2417.277.camel@tubuntu.research.nokia.com>
References: <1268829321-29769-1-git-send-email-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25411 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab0CQOMw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 10:12:52 -0400
In-Reply-To: <1268829321-29769-1-git-send-email-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2010-03-17 at 13:35 +0100, Quadros Roger (Nokia-D/Helsinki)
wrote:
> SDI now makes use of vdds_sdi regulator supply.
> DPI can now be disabled on systems that don't have it
> 
> changes since v1:
> - Incorporated review comments
> - no more omap3xx checks for regulator enable/disable in SDI
> - Added Kconfig option to enable/disable DPI
> 
> Roger Quadros (3):
>   OMAP: DSS2: Add Kconfig option for DPI display type
>   OMAP: DSS2: Remove redundant enable/disable calls from SDI
>   OMAP: DSS2: Use vdds_sdi regulator supply in SDI

I think this patch set looks ok. Thanks!

 Tomi

Ps. I took the liberty of removing an extra #include <plat/cpu.h>


