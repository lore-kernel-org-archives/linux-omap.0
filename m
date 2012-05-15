From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Tue, 15 May 2012 09:39:34 -0500
Message-ID: <4FB26AA6.1060807@ti.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com> <CACVXFVOmLOm8qD5Mq8qJQGSCcD7kNhW9OOsQqzx6W77709CXEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46793 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932864Ab2EOOjl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 10:39:41 -0400
In-Reply-To: <CACVXFVOmLOm8qD5Mq8qJQGSCcD7kNhW9OOsQqzx6W77709CXEQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Hi Ming,

On 05/14/2012 11:53 PM, Ming Lei wrote:
> On Thu, May 10, 2012 at 5:35 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>> From: Jon Hunter <jon-hunter@ti.com>
>>
>> This patch is based upon Ming Lei's patch to add runtime PM support for OMAP4
>> [1]. In Ming's original patch the CTI interrupts were being enabled during
>> runtime when the PMU was used but they were only configured once during init.
>> Therefore move the configuration of the CTI interrupts to the runtime PM
>> functions.
> 
> As Shilimkar pointed out, you need to give the reason why the change
> is introduced
> in the patch.

Yes will do. I have been waiting to get some feedback on HW_AUTO versus
SW_SLEEP from design before posting a V2. I will enhance the changelog.

Cheers
Jon
