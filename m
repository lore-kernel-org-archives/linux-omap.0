From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/2] arm/dts: Cleanup regulator naming and remove @0,1..
Date: Tue, 28 Aug 2012 11:51:52 +0530
Message-ID: <503C6380.4090107@ti.com>
References: <1343653940-16614-1-git-send-email-rnayak@ti.com> <1343653940-16614-3-git-send-email-rnayak@ti.com> <20120824202725.GA1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:57223 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645Ab2H1GV6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 02:21:58 -0400
Received: by obceq6 with SMTP id eq6so14310487obc.39
        for <linux-omap@vger.kernel.org>; Mon, 27 Aug 2012 23:21:57 -0700 (PDT)
In-Reply-To: <20120824202725.GA1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, b-cousson@ti.com

Hi Tony,

> * Rajendra Nayak<rnayak@ti.com>  [120730 06:17]:
>> regulators do not have a 'reg' property, hence the regulator@0,
>> regulator@1 do not make sense. get rid of it.
>
> Looks like this needs to be refreshed to apply. Care to
> refresh against current devel-dt branch in case other
> places need the same change?

Looks like devel-dt is missing the PATCH 1/2 from this series,
which you have already pushed in the -rc for merge.
With that applied, this ones applies cleanly too.

regards,
Rajendra

>
> Regards,
>
> Tony

