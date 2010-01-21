From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 0/8] OMAP3: PM: Open Switch Retention support in the
 cpuidle thread.
Date: Thu, 21 Jan 2010 12:38:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0BE1@dbde02.ent.ti.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
 <alpine.DEB.2.00.1001202314040.24456@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57496 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab0AUHIs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 02:08:48 -0500
In-Reply-To: <alpine.DEB.2.00.1001202314040.24456@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>



>>-----Original Message-----
>>From: Paul Walmsley [mailto:paul@pwsan.com]
>>Sent: Thursday, January 21, 2010 11:54 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com
>>Subject: Re: [PATCH 0/8] OMAP3: PM: Open Switch Retention support in the cpuidle thread.
>>
>>
>>Hi Thara,
>>
>>I'd like to merge the powerdomain changes separately from the other
>>changes, most of which should probably go through Kevin's PM branch.
>>
>>After you revise your patches based on the comments, can you take your
>>patches 3, 4, and the powerdomain portions of patch 7 and post those in a
>>separate series as an OSWR preparatory powerdomain patch set?  That will
>>make it easier for both Kevin and I to handle.

When you say patch 7, I believe you are mentioning the book keeping part for OSWR where logic_ret_off and mem_ret_off counters are added. I can separate this out and post these three patches separately. Do let me know should I base these on linux-omap master branch or Kevin's pm tree.

>>
>>Note: the powerdomain code will need to be edited somewhat to bring it
>>up-to-date with the latest OMAP4 changes in the for_2.6.34 branch, which
>>is where your patches will go.  I'm happy to do this, but after I do it,
>>will you be able to test the updated series to ensure that this process
>>didn't break anything?

Thanks for this and sure I can test the updated series! But I do not understand what OMAP4 specific support has to be added for these three patches. These three patches will be considerably free of OMAP2/OMAP3/OMAP4 specific stuff. Or are you talking of rebasing on 2.6.34 kernel?

Regards
Thara
