From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/5] OMAP4: hwmod data fixes and update
Date: Fri, 10 Dec 2010 16:54:04 +0100
Message-ID: <4D024D1C.2020703@ti.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com> <87hbem4g76.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51040 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756061Ab0LJPyN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 10:54:13 -0500
In-Reply-To: <87hbem4g76.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/10/2010 1:36 AM, Kevin Hilman wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:

[...]

> As with the other series, I tried to pull this into my pm-core for
> testing with all the other PM stuff we have baking for 2.6.38.
>
> Unfortunately, this series has conflicts with Paul's
> pwrdm_prcm_[ab]_2.6.38 branches.
>
> Could you rebase this on Paul's pwrdm_prcm_b_2.6.38 branch?

- for_2.6.38/clock is now rebased on top of pwrdm_prcm_b_2.6.38
- for_2.6.38/hwmod_data is rebased on top of for_2.6.38/clock

Regards,
Benoit
