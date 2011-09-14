From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: Re: [PATCHv2 3/4] usb: musb: OMAP4430: Remove incorrect call to omap4430_phy_init()
Date: Wed, 14 Sep 2011 09:17:03 +0200
Message-ID: <CAFULf_xvrf15q0AZ+w4Fe1GhuM1sgBWwP3je3QOLjCuNkWdcqg@mail.gmail.com>
References: <CAFULf_xEyAzJjxm6U+eVbdidSa3soVmn8J9NcJ=w8Fhf65yQaw@mail.gmail.com>
	<20110812094824.GQ19467@legolas.emea.dhcp.ti.com>
	<CAFULf_xk4xWLq4zhGokpTqoh95eUe3sg1vvVg_KCbJ3VXDkkRg@mail.gmail.com>
	<20110816065401.GD2305@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f42.google.com ([209.85.212.42]:56873 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755883Ab1INHRE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 03:17:04 -0400
Received: by mail-vw0-f42.google.com with SMTP id 1so2200161vwl.1
        for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 00:17:03 -0700 (PDT)
In-Reply-To: <20110816065401.GD2305@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

I can't see this one queued up anywhere.  Did it just slip through the
cracks, or are there any problems with it?

BR,

Bjarne Steinsbo


On Tue, Aug 16, 2011 at 8:54 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Aug 12, 2011 at 05:28:07PM +0200, Bjarne Steinsbo wrote:
>> Don't call omap4430_phy_init(dev) before dev is initialized.
>> The real omap4430_phy_init(dev) call is done at the end of
>> this function.
>>
>> Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
>
> Tony, you can have this one through your OMAP tree:
>
> Acked-by: Felipe Balbi <balbi@ti.com>
>
> --
> balbi
>
