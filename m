From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: Duration of mdelay and udelay depends on MPU frequency in SMP
Date: Mon, 13 Jun 2011 23:19:40 -0500
Message-ID: <BANLkTik9RVDtc0O2LkGTpbhT53a2CMcaTg@mail.gmail.com>
References: <BANLkTikGXzLba8uqXoffaUixBrEGj-XzRQ@mail.gmail.com>
 <BANLkTimVPnzMCL=NMb7hDkL97nJ=XdFExw@mail.gmail.com> <4DCB8158.8060507@ti.com>
 <BANLkTin1Tmjwjz8+J22Qi=cwu34Qp-B-wQ@mail.gmail.com> <4DF6D46B.90806@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:49378 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750844Ab1FNEUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jun 2011 00:20:04 -0400
Received: by mail-wy0-f170.google.com with SMTP id 34so7454147wyb.1
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 21:20:02 -0700 (PDT)
In-Reply-To: <4DF6D46B.90806@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Saquib <saquib.herman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Mon, Jun 13, 2011 at 22:24, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/10/2011 03:19 PM, Menon, Nishanth wrote:
>> On Thu, May 12, 2011 at 01:42, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>>>
>>> It's a well known problem if the udelay() is based of global lpj.
>>> You can read more here [1]
>>>
>>> Regards
>>> Santosh
>>> [1] http://eeek.borgchat.net/lists/arm-kernel/msg120702.html
>> I am curious about this topic now.
>> Searching Russel's patchworks for this:
>> http://www.arm.linux.org.uk/developer/patches/search.php?summary=udelay
>> I see nothing queued. What is the recommendation for udelay?
>
> The patches are sitting in Russell's patch tracker, waiting for him to
> accept/reject them.
>
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6874/1
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6875/1
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6873/1

thanks for the same and hope these do get through :)

Regards,
Nishanth Menon
