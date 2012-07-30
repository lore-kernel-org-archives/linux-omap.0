From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v6 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
Date: Mon, 30 Jul 2012 15:16:32 +0530
Message-ID: <CAAe_U6LWEiAE8TVVEQ5LcKy0_+J7Er2vP71MrQVrg=ZteyAeCw@mail.gmail.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
	<1343639400-28725-2-git-send-email-kishon@ti.com>
	<501655F2.7070900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:60875 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364Ab2G3Jqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 05:46:33 -0400
Received: by qcac10 with SMTP id c10so3341163qca.17
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 02:46:32 -0700 (PDT)
In-Reply-To: <501655F2.7070900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, b-cousson@ti.com, rnayak@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi,

On Mon, Jul 30, 2012 at 3:07 PM, Shubhrajyoti <shubhrajyoti@ti.com> wrote:
> On Monday 30 July 2012 02:39 PM, Kishon Vijay Abraham I wrote:
>> +                     writel(~PHY_PD, phy->control_dev);
>> +                     /* XXX: add proper documentation for this delay */
>> +                     mdelay(200);
> Do you need this to be busy?
This might be called from interrupt context. This delay was initially
added in omap_phy_internal.c and I just inherited it.

Thanks
Kishon
