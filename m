From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 15/23] OMAPDSS: RFBI: Add dssdev pointers as arguments
 to all exported functions
Date: Fri, 31 Aug 2012 20:00:23 +0530
Message-ID: <5040CA7F.1040900@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>  <1346326845-16583-1-git-send-email-archit@ti.com>  <1346326845-16583-16-git-send-email-archit@ti.com> <1346422820.16067.21.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60679 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583Ab2HaOaJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 10:30:09 -0400
In-Reply-To: <1346422820.16067.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 31 August 2012 07:50 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
>> All functions of an interface driver used by a panel driver should have an
>> omap_dss_device pointer as an argument. This may not be needed by some of the
>> interfaces now as driver data is globally visible in them. The correct way
>> to retrieve driver data is to extract the platform device from the output,
>> and then extract the driver data from the platform device.
>>
>> Add dssdev arguments from functions used by panel drivers which currently miss
>> it. This will come to use when the RFBI functions retrieve the driver data
>> in the correct manner.
>
> This and the similar patch for HDMI could probably also be left out for
> now. Again I agree that this is correct direction, but this is not
> really needed (right?) for output work or writeback. And we'll
> eventually just change these parameters again.
>
> The motivation for this patch was probably to have common format for the
> output driver's functions, so that you can use func pointers in an ops
> struct?

Yes, or the fact that we need the function to pass something related to 
the output to configure it. Things work now since we just have one 
instance of hdmi/rfbi, and that we have a global struct from which we 
can get the required info. We definitely need to pass something to these 
functions, whether we should pass the panel, or the output itself isn't 
clear yet.

>
> Let's delay that work until the common panel framework gets a bit more
> solid.

I get your point. We might need to replace the dssdevs with outputs (or 
something similar) in the future. Hence it would lead to churn.

>
> Sorry if I'm saying "leave this patch out" for most of the patches =). I
> just want to avoid extra churn, going back and forth with the code. The
> most important things now are to get the output work in a state that WB
> can be used, and on the other hand to remove the dssdev dependencies so
> that at some point we can remove dssdev totally.

That's okay. If we keep this stuff, it'll be us who have to change it 
later :)

Archit
