From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] Some omap_device/hwmod/pwrdomain patches
Date: Fri, 27 May 2011 07:57:23 -0700
Message-ID: <874o4g6vjg.fsf@ti.com>
References: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com>
	<87ipsxfjyd.fsf@ti.com> <1306474266.1905.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:55055 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751370Ab1E0O51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 10:57:27 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so805955pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 07:57:26 -0700 (PDT)
In-Reply-To: <1306474266.1905.8.camel@deskari> (Tomi Valkeinen's message of
	"Fri, 27 May 2011 08:31:06 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

[...]

>
>> This isn't something in general that drivers should be aware of, so I'd
>> rather not see this exposed to drivers (unless there's a real need.)
>
> Ok, I'll drop the patch. I don't think there's any need for this in DSS.
>
>> As soon as I finish the move to device power domains (hopefully for
>> 2.6.41), the driver's callbacks will only be called if the device has
>> lost context, so checking for context loss will not be needed at all at
>> the driver level.
>
> This sounds good. Runtime PM's suspend & resume callbacks or something
> else? 

Runtime PM callbacks.

Kevin
