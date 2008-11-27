From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [PATCH 3/9] OMAP: HSMMC: Make fclk disable request driven.
Date: Thu, 27 Nov 2008 10:40:25 +0200
Message-ID: <492E5CF9.9070402@nokia.com>
References: <49267E53.3070607@nokia.com> <20081126190815.GX11997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34562 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbYK0Ibk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 03:31:40 -0500
In-Reply-To: <20081126190815.GX11997@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Tony Lindgren wrote:
> * Adrian Hunter <ext-adrian.hunter@nokia.com> [081121 01:16]:
>> Start idle timer only at the end of request or request like operation
>> such card detect, set_ios, probe, or resume. This will ensure the fclk is
>> disable quickly after the operation is done, but never too early.
> 
>>From merging into mainline point of view, maybe this should be merged into
> the earlier patch for adding the idle timer?

I envisage that once we have fixed our outstanding bugs, we will review and
tidy up the code and then submit it to mainline as a single patch i.e. throw
away the patch history.

