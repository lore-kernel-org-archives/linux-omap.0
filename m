From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 0/7] Add TI EMIF SDRAM controller driver
Date: Fri, 04 May 2012 12:02:01 +0530
Message-ID: <4FA377E1.9060008@ti.com>
References: <1335529449-28046-1-git-send-email-santosh.shilimkar@ti.com> <CAP=VYLrCTOb9Qtz_HU5976cew_FR=qN6=x=_nD48ZprTcCjoUg@mail.gmail.com> <20120504000312.GB32225@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:50839 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859Ab2EDGcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 02:32:09 -0400
Received: by obbup16 with SMTP id up16so5859659obb.39
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 23:32:07 -0700 (PDT)
In-Reply-To: <20120504000312.GB32225@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 04 May 2012 05:33 AM, Greg KH wrote:
> On Thu, May 03, 2012 at 06:38:23PM -0400, Paul Gortmaker wrote:
>> On Fri, Apr 27, 2012 at 8:24 AM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>>> Add a driver for the EMIF SDRAM controller used in Texas Instrument SoCs
>>
>> Hi Santosh,
>>
>> Can you send Greg a patch that adds proper dependencies to the Kconfig?
>> I was going to simply add an ARM dependency, but perhaps you want to
>> restrict it further to a subset of OMAP platforms?
>>
Thanks Paul for reporting the issue.

>> At the moment it is causing build failures in other architectures.
>>
>> http://kisskb.ellerman.id.au/kisskb/buildresult/6243036/
> 
> I think there's a config option for readl/writel, but yes, ARM would
> probably be fine as well.
> 
Just send a patch [1] to Greg. EMIF driver build is restricted to
ARCH_OMAP2PLUS for now and can be extended later if any other
non OMAP architecture start using it.

Regards
Santosh

[1] https://lkml.org/lkml/2012/5/4/22
