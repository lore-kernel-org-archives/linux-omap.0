From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS pwrdm usecount, disabling autodeps for DSS
Date: Fri, 09 Mar 2012 10:17:41 -0800
Message-ID: <87obs53agq.fsf@ti.com>
References: <87r4x27gh0.fsf@ti.com> <1331291641.1927.38.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:60068 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754553Ab2CISRj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 13:17:39 -0500
Received: by iaag37 with SMTP id g37so2386340iaa.6
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 10:17:38 -0800 (PST)
In-Reply-To: <1331291641.1927.38.camel@deskari> (Tomi Valkeinen's message of
	"Fri, 09 Mar 2012 13:14:01 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On Thu, 2012-03-08 at 16:42 -0800, Kevin Hilman wrote:
>> Hi Tomi,
>> 
>> A while ago you were asking about why DSS pwrdm counts were so high on
>> OMAP3, and why DSS was transitioning even though it was completely
>> unused. Paul and I just spent some a little time debugging this, and
>> narrowed it down to autodeps. (sorry it took so long, it finally
>> bothered me enough to actually look into it.)
>> 
>> The patch below fixes the problem at least when DSS is not loaded (DSS
>> just stays in retention), but I didn't try this with any active DSS
>> usage, or loading/unloding the DSS drivers.
>> 
>> Could you give the patch below a try on OMAP3 along with some active DSS
>> usage as well as unloading the modules after using.  Could you also
>> verify that suspend/resume continues to work for DSS?
>
> I didn't get very far with the patch =(. Tested on omap3 overo, with
> -rc6 based dss tree.

Bummer, thanks for trying.  

It seems we still have work to do in fixing the omap2/3 enable sequence.

At least we know the root cause of the DSS pwrdm usecount now.  

Kevin
