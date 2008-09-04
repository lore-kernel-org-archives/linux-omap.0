From: "Arun KS" <getarunks@gmail.com>
Subject: Re: Reset unused clocks during boot causing problem on 5912 OSK
Date: Thu, 4 Sep 2008 20:59:28 +0530
Message-ID: <dfeb90390809040829r131cbf1evcd9f058ad89f920c@mail.gmail.com>
References: <dfeb90390809030702o40710b8cpab328466dac3a4a@mail.gmail.com>
	 <20080903190019.GB19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:53987 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbYIDP3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 11:29:32 -0400
Received: by ti-out-0910.google.com with SMTP id b6so2000588tic.23
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 08:29:29 -0700 (PDT)
In-Reply-To: <20080903190019.GB19980@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

On 9/4/08, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Sep 03, 2008 at 07:32:51PM +0530, Arun KS wrote:
> > I am trying to write an ASOC driver for tlv320aic23 on 5912osk.
>
> 5912osk is OMAP1, yes ?  Uses arch/arm/mach-omap1/mcbsp.c ?
>
> Which is the file I pointed out passing physical addresses for mcbsp1
> and mcbsp3 instead of virtual addresses, resulting in code hitting
> something else rather than the right registers ?
>

But when i am requesting the mcbsp(omap_mcbsp_request(0)) in my init function,
I am able to get the requested mcbsp. What could be the reason for that?

Arun
