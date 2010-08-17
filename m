From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] omap: dss2: Add SPI dependency to Kconfig of ACX565AKM
 panel
Date: Tue, 17 Aug 2010 13:45:02 +0300
Message-ID: <1282041902.2348.27.camel@tubuntu.research.nokia.com>
References: <1281529382-11523-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:35418 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab0HQKpN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 06:45:13 -0400
In-Reply-To: <1281529382-11523-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>

On Wed, 2010-08-11 at 14:23 +0200, ext Jarkko Nikula wrote:
> This panel driver is using SPI for its communication so add CONFIG_SPI
> dependency.

Thanks, applied.

 Tomi


