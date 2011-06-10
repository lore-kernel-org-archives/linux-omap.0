From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: Duration of mdelay and udelay depends on MPU frequency in SMP
Date: Fri, 10 Jun 2011 17:19:13 -0500
Message-ID: <BANLkTin1Tmjwjz8+J22Qi=cwu34Qp-B-wQ@mail.gmail.com>
References: <BANLkTikGXzLba8uqXoffaUixBrEGj-XzRQ@mail.gmail.com>
 <BANLkTimVPnzMCL=NMb7hDkL97nJ=XdFExw@mail.gmail.com> <4DCB8158.8060507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:55072 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753467Ab1FJWTf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 18:19:35 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2729992wya.5
        for <linux-omap@vger.kernel.org>; Fri, 10 Jun 2011 15:19:34 -0700 (PDT)
In-Reply-To: <4DCB8158.8060507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Saquib <saquib.herman@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>

On Thu, May 12, 2011 at 01:42, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 5/5/2011 12:23 PM, Saquib wrote:
>> Can anyone please help me to understand and fix this issue?
>>
>> When CPU frequency is "1008MHz", duration of delay was close to
>> theoretical value, however, when "300MHz", it was close to about 4 times
>> the theoretical value.
>>
>> I tested it on OMAP4(SMP) blaze board.
>
>>
> It's a well known problem if the udelay() is based of global lpj.
> You can read more here [1]
>
> Regards
> Santosh
> [1] http://eeek.borgchat.net/lists/arm-kernel/msg120702.html
I am curious about this topic now.
Searching Russel's patchworks for this:
http://www.arm.linux.org.uk/developer/patches/search.php?summary=udelay
I see nothing queued. What is the recommendation for udelay?

Regards,
Nishanth Menon
