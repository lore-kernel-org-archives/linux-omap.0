From: "Amit Pundir" <pundiramit@gmail.com>
Subject: Re: defconfig for omap3-evm
Date: Fri, 21 Nov 2008 18:01:49 +0530
Message-ID: <52c7556c0811210431l430fb536ie79fc85f98960e44@mail.gmail.com>
References: <52c7556c0811210416m41b41a7o21f3a0c95d737003@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403E8E67DF9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:46828 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbYKUMbv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 07:31:51 -0500
Received: by ti-out-0910.google.com with SMTP id b6so617528tic.23
        for <linux-omap@vger.kernel.org>; Fri, 21 Nov 2008 04:31:49 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E8E67DF9@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

In that I was trying to enable OMAP2 also and it failed and ask me to
choose only one. Otherwise I have used only OMAP3 option during which
build fail.

The reason I enable OMAP2 in that config is that the variable
(undefined reference to `omap2_int_ctrl') which the build is unable to
reference will only be available if OMAP2 is enabled.

Regards
Amit Pundir

On Fri, Nov 21, 2008 at 5:55 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
>
>
> Thanks,
> Vaibhav Hiremath
>
>> -----Original Message-----
>> From: Amit Pundir [mailto:pundiramit@gmail.com]
>> Sent: Friday, November 21, 2008 5:46 PM
>> To: Hiremath, Vaibhav
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: defconfig for omap3-evm
>>
>> here it is.
>>
> [Hiremath, Vaibhav] Is this the valid config file? The reason I am asking is, I see both OMAP2 and OMAP3 architectures have been enabled.
>
>> Thanks
>> Amit Pundir
>>
>> On Fri, Nov 21, 2008 at 5:39 PM, Hiremath, Vaibhav <hvaibhav@ti.com>
>> wrote:
>> > I think you missed to attach the .config file.
>> >
>> > Thanks,
>> > Vaibhav Hiremath
>
