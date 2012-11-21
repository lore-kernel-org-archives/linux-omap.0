From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 09/16] mfd: omap-usb-host: override number of ports from
 platform data
Date: Wed, 21 Nov 2012 16:50:42 +0200
Message-ID: <50ACEA42.2030701@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-10-git-send-email-rogerq@ti.com> <20121121134516.GK10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34808 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784Ab2KUOuo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 09:50:44 -0500
In-Reply-To: <20121121134516.GK10216@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 11/21/2012 03:45 PM, Felipe Balbi wrote:
> On Thu, Nov 15, 2012 at 04:34:07PM +0200, Roger Quadros wrote:
>> For some platforms e.g. OMAP5, we cannot rely on USBHOST revision
>> to determine the number of ports available. In such cases we have
> 
> you need to make it clear *why* we can't. Imagine someone reading this 5
> years from now... he'll be all like: "why can't I find any documentation
> about this OMAP5 ? Why was it so special that its revision register
> wasn't enough to figure out number of ports ?"

OK, i'll add a note like this "both OMAP5 and OMAP4 exhibit the same
revision ID in the USBHOST_REVISION register, but in fact have different
number of ports physically available on the SoC (i.e. 2 for OMAP4 and 3
for OMAP5 respectively). So we can't rely on REVISION register to
determine number of ports for OMAP5 and depend on platform data/Device
tree instead"

cheers,
-roger
