From: "Kumar, Purushotam" <purushotam@ti.com>
Subject: RE: HSMMC block transfer (CMD53) doesn't complete
Date: Thu, 21 Aug 2008 20:12:48 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593019FE3BA55@dbde02.ent.ti.com>
References: <CDADC90344D4F540AE43CFF18CCEA01C087264E4@ex01.vocollect.int>
 <48AC22EF.9010102@vocollect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50883 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760014AbYHUOnA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 10:43:00 -0400
In-Reply-To: <48AC22EF.9010102@vocollect.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Josh Karabin <gkarabin@vocollect.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Josh
> Karabin
> Sent: Wednesday, August 20, 2008 7:28 PM
> To: linux-omap@vger.kernel.org
> Subject: Re: HSMMC block transfer (CMD53) doesn't complete
> 
> 
> Romantic, William wrote:
> > I'm using the OMAP35x evm, the Libertas driver, and a Marvel sd8686 WiFi
> > radio.  I currently have everything running with some workarounds and
> > I'm looking to properly resolve the issues.
> 
> Is anyone else working on fixing up HSMMC SDIO, or are there any partial
> patches waiting in the wings?  Bill's work is going to generate patches
> for the list's review over the next couple of weeks.  It would be a
> shame to duplicate effort unnecessarily, or at least not to collaborate
> if duplication helps us get something out faster.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi,

We working on SDIO solution on OMAP35x EVM for Marvel sd 8686 (Libertas driver). We will plan to push SDIO support in near future.

Regards,
Purushotam
