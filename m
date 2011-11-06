From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 1/4] ARM: OMAP3: cm-t35: add regulator supply for ads7846
Date: Sun, 06 Nov 2011 15:19:48 +0200
Message-ID: <4EB68974.5090907@compulab.co.il>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il> <1319017160-20391-2-git-send-email-grinberg@compulab.co.il> <20111104233938.GF31337@atomide.com> <20111104235720.GG31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:46963
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752148Ab1KFNT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Nov 2011 08:19:56 -0500
In-Reply-To: <20111104235720.GG31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On 11/05/11 01:57, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [111104 16:05]:
>> * Igor Grinberg <grinberg@compulab.co.il> [111019 02:05]:
>>
>> Applying to board branch for v3.3 merge window.
> 
> Hmm, actually I suggest you respin patches 2 and 3 so they apply
> on their own to current fixes branch. Then update 1 and 4 to
> apply on top of those.
> 
> This way we can apply 2 and 3 during the -rc cycle, and then
> queue 1 and 4 for the next merge window.

Well, actually all them are fixes, although it cannot be understood
from the subject.
I will adjust the subjects (and may be the commit messages also)
to be more specific and resend.

Thanks

-- 
Regards,
Igor.
