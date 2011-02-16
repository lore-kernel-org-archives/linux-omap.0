From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/3] OMAP2+ hwmod fixes
Date: Wed, 16 Feb 2011 14:07:28 +0100
Message-ID: <4D5BCC10.2060301@ti.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53472 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab1BPNHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 08:07:34 -0500
In-Reply-To: <1297858285-7056-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Rajendra,

On 2/16/2011 1:11 PM, Nayak, Rajendra wrote:
> This series fixes some hwmod api return values
> and also adds some state checks.
> The hwmod iterator functions are made to
> continue and not break if one of the
> callback functions ends up with an error.

By doing that, you change the behavior of this function.
I'm not sure I fully understand why.
Could you elaborate on the use case?

To avoid that behavior in the past, I was just returning
0 in case of failure to avoid stopping the iteration.
It looks like you do not want to stop the iteration but still
retrieve the error.
I do not see in this series what you plan to do with the
error at the end of the iteration.

Thanks,
Benoit
