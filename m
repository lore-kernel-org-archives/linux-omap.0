From: Mike Turquette <mturquette@ti.com>
Subject: Re: [RFC PATCH 09/11] ARM: OMAP4+: thermal: introduce bandgap
 temperature sensor
Date: Tue, 29 May 2012 10:51:25 -0700
Message-ID: <20120529175125.GD2722@gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-10-git-send-email-eduardo.valentin@ti.com>
 <4FBFAA18.4040103@ti.com>
 <20120528111624.GC3923@besouro>
 <4FC4CBC8.2040600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:51932 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753041Ab2E2Rvi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 13:51:38 -0400
Received: by obbwd18 with SMTP id wd18so8974759obb.0
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 10:51:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FC4CBC8.2040600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: eduardo.valentin@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Keerthy <j-keerthy@ti.com>

On 20120529-15:14, Cousson, Benoit wrote:
> On 5/28/2012 1:16 PM, Eduardo Valentin wrote:
> >In fact I didn't touch the clk data on purpose and left the clock handling
> >as is. On my side I didn't know how the clock struct would look like with DT,
> >so, I didn't mess with it.
> >
> >Do you have a reference to check the work in progress for clock DT ?
> 
> Rob sent a pull request, it seems that now it is up to Mike T. :-)
> 
> http://lists-archives.com/linux-kernel/27640907-dt-clk-binding-support.html
> 

Due to the on-going discussion around those patches I haven't pulled
yet.  If everyone agrees once the dust settles then I'll take them in.

Regards,
Mike

