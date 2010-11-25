From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH v5 1/1] OMAP2: Spi: Force CS to be in inactive state after off-mode transition
Date: Thu, 25 Nov 2010 14:28:43 +0530
Message-ID: <2699B5D6798D4057B2679F7C8A16C537@wipblrx0099946>
References: <4CED8F6E.3000808@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40694 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536Ab0KYI7G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 03:59:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-omap <linux-omap@vger.kernel.org>, spi-devel-general@lists.sourceforge.net
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@deeprootsystems.com>

----- Original Message ----- 
From: "Gregory CLEMENT" <gregory.clement@free-electrons.com>
To: "linux-omap" <linux-omap@vger.kernel.org>; 
<spi-devel-general@lists.sourceforge.net>
Cc: "David Brownell" <dbrownell@users.sourceforge.net>; "Grant Likely" 
<grant.likely@secretlab.ca>; "Kevin Hilman" <khilman@deeprootsystems.com>
Sent: Thursday, November 25, 2010 3:49 AM
Subject: [PATCH v5 1/1] OMAP2: Spi: Force CS to be in inactive state after 
off-mode transition


> As request by Grant Likely, there is no more cover letter. Full changelog 
> is following.
> I am still reluctant to add this changelog in the patch description, as it 
> adds no value to
> the patch itself: when it was needed I try to updat comments or patch 
> description.
> I understand that Grant Likely would need an ack from other user as this 
> patch fix a corner case.
> Kevin Hilman made a few comments on this patch so he could add his "Ack 
> by" or at least his "Review by".
>

I was trying to run some tests with this patch. I find that the resume 
function registered by this patch doesnot seem to
get called during system wide suspend/resume, since spi_resume only calls 
the resume routine registered by spi client driver.
Is there something I am missing.

Thanks
Hemanth


