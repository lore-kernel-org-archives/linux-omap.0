From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
Date: Thu, 16 Sep 2010 12:00:18 +0300
Message-ID: <20100916090018.GM3393@legolas.emea.dhcp.ti.com>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
 <1284627281-26059-4-git-send-email-grinberg@compulab.co.il>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60282 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab0IPJAf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 05:00:35 -0400
Content-Disposition: inline
In-Reply-To: <1284627281-26059-4-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, Sep 16, 2010 at 03:54:39AM -0500, Igor Grinberg wrote:

put a description here.

>Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>---

[snip]

>+static int cm_t3517_init_usbh(void)
>+{
>+	int err;
>+
>+	err = gpio_request(USB_HUB_RESET_GPIO, "usb hub rst");
>+	if (err) {
>+		pr_err("CM-T3517: usb hub reset gpio request failed: %d\n",
>+		       err);
>+	} else {

if (err) {
	pr_err("...");
	return err;
}

gpio_direction_output(...);

this will save you on identation level.

-- 
balbi
