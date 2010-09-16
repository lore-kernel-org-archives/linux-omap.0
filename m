From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
Date: Thu, 16 Sep 2010 11:12:06 +0200
Message-ID: <4C91DF66.6020003@compulab.co.il>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il> <1284627281-26059-4-git-send-email-grinberg@compulab.co.il> <20100916090018.GM3393@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:52795 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab0IPJMN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 05:12:13 -0400
In-Reply-To: <20100916090018.GM3393@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

 Hi,

On 09/16/10 11:00, Felipe Balbi wrote:
> Hi,
>
> On Thu, Sep 16, 2010 at 03:54:39AM -0500, Igor Grinberg wrote:
>
> put a description here.

This is a relatively small patch, is the subject not descriptive enough?

>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>
> [snip]
>
>> +static int cm_t3517_init_usbh(void)
>> +{
>> +    int err;
>> +
>> +    err = gpio_request(USB_HUB_RESET_GPIO, "usb hub rst");
>> +    if (err) {
>> +        pr_err("CM-T3517: usb hub reset gpio request failed: %d\n",
>> +               err);
>> +    } else {
>
> if (err) {
>     pr_err("...");
>     return err;
> }
>
> gpio_direction_output(...);
>
> this will save you on identation level.

Yes it will, but even if the hub reset gpio is for some reason unavailable,
we don't want to disable ehci completely...
There are other ports, that are not wired through the hub.

-- 
Regards,
Igor.

