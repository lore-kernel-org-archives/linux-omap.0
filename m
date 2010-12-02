From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v6] OMAP2+: PM: omap device: API's for handling mstandby
 mode
Date: Thu, 2 Dec 2010 09:22:38 +0100
Message-ID: <4CF7574E.7060705@ti.com>
References: <1291229228-4438-1-git-send-email-manjugk@ti.com> <4CF6AD2C.4020907@nokia.com> <20101202061139.GA5645@GLPP-machine> <4CF75192.3090705@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35550 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab0LBIWp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 03:22:45 -0500
In-Reply-To: <4CF75192.3090705@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Adrian and Manju,

On 12/2/2010 8:58 AM, Adrian Hunter wrote:
> On 02/12/10 08:12, ext G, Manjunath Kondaiah wrote:
>> * Adrian Hunter<adrian.hunter@nokia.com>   [2010-12-01 22:16:44 +0200]:
>>> On 01/12/10 20:47, ext G, Manjunath Kondaiah wrote:

[...]

>>> Also, there is a mutex but don't these functions get called
>>> sometimes in interrupt context?
>>
>> I feel we should leave this to caller of these API's. The caller should
>> make sure that, he disables interrupts if it is used in interrupt context.
>
> How does that help?  It seems to me that a mutex cannot be used for this.

That mutex is the one that was protecting the hwmod list and should not 
be used, we do have a per-hwmod mutex.
But it will disappear soon, Paul already submitted a patch to replace it 
by a spinlock (8297db801c424f95ef3ebfbd28e62b94798d35dd)

Please note that the goal of this API is to not be used at all :-)
It is there because of dirty HW bugs in several IPs.
So I'm fine to limit its usability and to prevent its usage everywhere.
Thanks to the spinlock it will anyway no longer be an issue.

Thanks,
Benoit
