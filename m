From: Jean Pihet <jpihet@mvista.com>
Subject: Re: Script for applying a set of patches from a folder
Date: Fri, 5 Jun 2009 15:49:56 +0200
Message-ID: <200906051549.56878.jpihet@mvista.com>
References: <3284AAA8-73B9-4C4C-95FD-29BC92AFE5A8@mac.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:60968 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZFENug (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 09:50:36 -0400
In-Reply-To: <3284AAA8-73B9-4C4C-95FD-29BC92AFE5A8@mac.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

On Friday 05 June 2009 12:55:41 Elvis Dowson wrote:
> HI,
> 	Does anyone have a script that will allow me to apply all the patches
> that are contained in a folder, using the git apply command?
You need to use git am for that, with the dir as parameter. git am will apply 
each patch from the dir.

>
> I have hundreds of patches that I want to apply from the dss2 and pm
> branches to the linux-omap-2.6 branch, locally, to bring it upto date,
> to a known state before making specific patches for the overo platform.
>
> Best regards,
Regards,
Jean
>
> Elvis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


