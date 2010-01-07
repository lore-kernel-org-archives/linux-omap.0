From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of
 sysconfig register.
Date: Thu, 7 Jan 2010 20:48:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D6B7B@dbde02.ent.ti.com>
References: <1260098674-27143-1-git-send-email-thara@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E171@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001051730230.21295@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42092 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab0AGPSd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 10:18:33 -0500
In-Reply-To: <alpine.DEB.2.00.1001051730230.21295@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: Paul Walmsley [mailto:paul@pwsan.com]
>>Sent: Wednesday, January 06, 2010 6:02 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org
>>Subject: RE: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of sysconfig register.
>>
>>On Wed, 23 Dec 2009, Gopinath, Thara wrote:
>>
>>> Hi Paul,Kevin.. Does this patch look ok?
>>
>>Hello Thara,
>>
>>looking over this patch.  Nice job on the descriptive patch comment;
>>it explains the problem well.  What do you think about a slightly
>>different approach -- that is, to add a hook to the hwmod code to
>>invalidate the cache if the module's powerdomain has lost context?

Hi Paul

It should be possible but I feel it is a bit cumbersome. Couple of reasons I have. 
a. Some modules like smartreflex does not have any power domain associated with it.
b. Invalidating the cache is not needed for all modules even if the module powerdomain context is lost. This is needed only for modules which employ always restore mechanism. All other modules will do explicit context save and restore of its registers
c. Getting whether power domain context is lost or not is not very straight forward. If I am not mistaken the only way is to keep tab of the powerdomain counters through omap_pm_get_dev_context_loss_count. I might be mistaken.

Regards
Thara
