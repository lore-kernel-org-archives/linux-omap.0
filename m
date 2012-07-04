From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH V3 5/5] ARM: OMAP: change the USB TLL clocks device name
Date: Wed, 4 Jul 2012 13:56:56 +0530
Message-ID: <CAP05o4+3LvvB5ybx-mbhBcoLzoGGP0R_hMVoeK-F4E93AgTQMg@mail.gmail.com>
References: <1341241349-575-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1207040126450.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:59628 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756815Ab2GDI06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 04:26:58 -0400
Received: by lbjn8 with SMTP id n8so3725700lbj.0
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 01:26:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207040126450.6760@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com, b-cousson@ti.com, sshtylyov@mvista.com, tony@atomide.com

On Wed, Jul 4, 2012 at 1:00 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 2 Jul 2012, Keshava Munegowda wrote:
>
>> The platform device name for the functional, interface and
>> channel clocks of the TLL module is changed from usbhs device
>> to usb tll platform device name.
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> Reviewed-by: Partha Basak <parthab@india.ti.com>
>
> The basic idea of this patch looks reasonable, but you should make sure
> that this series doesn't result in a broken TLL at any point during the
> series.  Otherwise 'git bisect' operations will break.
>
> To do this, you'll presumably need to add the new clkdev aliases much
> earlier in the series, and remove the old ones at the end of the
> series.

Thanks Paul
  I will change this.
please let me if you have other comments on this series.

regards
keshava
