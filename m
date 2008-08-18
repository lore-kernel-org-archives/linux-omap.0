From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Mon, 18 Aug 2008 13:56:59 +0530
Message-ID: <5d5443650808180126n2dbadac6ma9fa63fc380e5d97@mail.gmail.com>
References: <94a0d4530808151409p309cf9e2sf1ab3274baac32fb@mail.gmail.com>
	 <EBA93F3E4CB46947A4C5275F6308CF3E03434E08@dlee15.ent.ti.com>
	 <94a0d4530808160257r77341fafn5f2b8404a8510203@mail.gmail.com>
	 <20080818075624.GB12243@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:24499 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbYHRI1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 04:27:00 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1231659yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 01:26:59 -0700 (PDT)
In-Reply-To: <20080818075624.GB12243@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, felipe.contreras@nokia.com

Hi Tony,

On Mon, Aug 18, 2008 at 1:26 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Felipe Contreras <felipe.contreras@gmail.com> [080816 12:58]:
>> Hi Vijay,
>>
>> On Sat, Aug 16, 2008 at 12:59 AM, Pasam, Vijay <vpasam@ti.com> wrote:
>> >> I'm not familiar with checkpatch, but I guess the purpose is
>> >> not to highlight functional issues.
>> >>
>> >> However, there are functional issues, but it makes sense to
>> >> cleanup the code first: there's no point in analyzing code
>> >> that is never used.
>> >
>> > There are about 9 errors with the latest set of patches. These are all
>> > false positives - not really errors. Majority of warnings also fall
>> > under this category.
>>
>> I'm not talking about issues returned by checkpatch, but issues
>> visible to the human observer.
>
> And the two pieces of code that need to be fixed for Linux ASAP
> for DSP are:
>
> - External device MMU hardware
> - Mailbox handling
>
> This code needs to be shared for dsp[bios|bridge|gateway|link].
> And it can be also used for any other devices and coprocessors
> needing MMU handling.
>

This task was pointed out on todo checklist created offline by
Doyu-San during early discussion.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
