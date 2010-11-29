From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v5 1/1] OMAP2: Spi: Force CS to be in inactive state after
 off-mode transition
Date: Mon, 29 Nov 2010 18:18:00 +0100
Message-ID: <4CF3E048.4020208@free-electrons.com>
References: <4CED8F6E.3000808@free-electrons.com> <2699B5D6798D4057B2679F7C8A16C537@wipblrx0099946>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:54252 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab0K2RSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 12:18:10 -0500
In-Reply-To: <2699B5D6798D4057B2679F7C8A16C537@wipblrx0099946>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@deeprootsystems.com>

On 11/25/2010 09:58 AM, Hemanth V wrote:
> ----- Original Message ----- 
> From: "Gregory CLEMENT" <gregory.clement@free-electrons.com>
> To: "linux-omap" <linux-omap@vger.kernel.org>; 
> <spi-devel-general@lists.sourceforge.net>
> Cc: "David Brownell" <dbrownell@users.sourceforge.net>; "Grant Likely" 
> <grant.likely@secretlab.ca>; "Kevin Hilman" <khilman@deeprootsystems.com>
> Sent: Thursday, November 25, 2010 3:49 AM
> Subject: [PATCH v5 1/1] OMAP2: Spi: Force CS to be in inactive state after 
> off-mode transition
> 
> 
>> As request by Grant Likely, there is no more cover letter. Full changelog 
>> is following.
>> I am still reluctant to add this changelog in the patch description, as it 
>> adds no value to
>> the patch itself: when it was needed I try to updat comments or patch 
>> description.
>> I understand that Grant Likely would need an ack from other user as this 
>> patch fix a corner case.
>> Kevin Hilman made a few comments on this patch so he could add his "Ack 
>> by" or at least his "Review by".
>>
> 
> I was trying to run some tests with this patch. I find that the resume 
> function registered by this patch doesnot seem to
> get called during system wide suspend/resume, since spi_resume only calls 
> the resume routine registered by spi client driver.
> Is there something I am missing.

In fact the resume function for this driver won't be called by spi bus but by
platform bus. Indeed this function is registered in a platform_driver structure.

> 
> Thanks
> Hemanth
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
