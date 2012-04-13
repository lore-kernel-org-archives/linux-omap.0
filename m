From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
Date: Fri, 13 Apr 2012 14:56:31 +0530
Message-ID: <4F87F147.3040002@ti.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com> <1331659524-7635-3-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204101803020.20894@utopia.booyaka.com> <4F8565C7.4080506@ti.com> <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:60135 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758126Ab2DMJ0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 05:26:39 -0400
Received: by obbta14 with SMTP id ta14so429473obb.33
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 02:26:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: b-cousson@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Gadiyar <gadiyar@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

Hi Paul,

>> >  While the patch did fix the issue for Anand, I guess it
>> >  was because of the additional delay post reset, waiting on the
>> >  RESETDONE bit and timing out, before accessing the i2c_con register.

I thought some more on this and the logic of the delay between the
SOFTRESET bit being set and an immediate register access did not make
much sense, because even polling on RESETDONE bit involves an immediate
i2c register access, albeit a different one.

I had a chat again with Anand this morning and realized the patch that
fixed the problems he saw on some customer hardware had changes from
both patch 1/2 and patch 2/2 from this series clubbed into one patch.
I seem to have split them into 2 patches later while posting it out
on the list.

So in all likelihood its the changes in patch 1/2 which made a
difference and the patch 2/2 was a result of my (wrong) analysis based
on code review.

The problems seen were extremely rare and not having access to those
few failing boards is making it difficult to re-validate with these
changes removed. However based on my analysis (hopefully right this time 
:)) it seems safe to revert this patch in mainline.

Should I go ahead and send a revert for the -rc?

regards,
Rajendra





