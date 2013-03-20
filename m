From: Frank Agius <ftagius@yahoo.com>
Subject: Re: Beagleboard xM - Bogomips are very low
Date: Wed, 20 Mar 2013 08:48:40 -0400
Message-ID: <5149B028.9010703@yahoo.com>
References: <5148819A.5040500@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44007 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934250Ab3CTMsv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 08:48:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1UIIS8-0004Ol-Em
	for linux-omap@vger.kernel.org; Wed, 20 Mar 2013 13:49:12 +0100
Received: from 99-178-168-231.lightspeed.rlghnc.sbcglobal.net ([99.178.168.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 20 Mar 2013 13:49:12 +0100
Received: from ftagius by 99-178-168-231.lightspeed.rlghnc.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 20 Mar 2013 13:49:12 +0100
In-Reply-To: <5148819A.5040500@free.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org

On 3/19/2013 11:17 AM, Guillaume Gardet wrote:
> Hi,
>
> On a Beagleboard xM rev. B, I noticed that vanilla kernel 3.4.6 have the
> folowing bogomips for 300MHz and 800 MHz operations: 262.08 and 700.57.
>
> With kernel 3.7.10, I have : 175.65 and 467.41 bogompis.
>
> Any idea why bogomips are so low now?
>

I believe this is the reason for the BogoMIPS change:

http://www.spinics.net/lists/arm-kernel/msg221672.html

It looks like BogoMIPS reporting changed because of the delay routine 
patch introduced in 3.6.  So the change in BogoMIPS is real, but should 
not be a concern.

frank agius

> Guillaume
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


