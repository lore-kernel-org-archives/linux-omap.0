From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Mon, 18 Aug 2008 22:47:19 +0530
Message-ID: <5d5443650808181017w1ad90b9vcc6cc4d8abc6a963@mail.gmail.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
	 <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E0B3121EE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:9290 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbYHRRRV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 13:17:21 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2355508wxd.4
        for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 10:17:20 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E0B3121EE@dlee03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "tony@atomide.com" <tony@atomide.com>

Hi Hari,

On Mon, Aug 18, 2008 at 9:57 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Hi,
>
>> Some of the above items are being looked at like replacing CSL, isr etc..
>> But there are no equivalent API's or functionality available in kernel for
>> many of them. We should replace the API's with the avaolable kernel API's
>> and the remaining need to be looked at from long term.
>>
>
> -- I agree with Vijay. We can remove the simple wrapper functions like the ones in CSL and ISR, but some of the other modules in the services provide more functionality than just being the wrappers. We don't want to compromise on any current debugging features that are provided by these modules at the expense of replacing the services functions with direct kernel calls. This would require careful analysis.
>
> If any one has done any analysis on the services functions that can be removed without compromising the functionality and debugging feature, please share it on the mailing list.
>
> On the comment to remove clk.c, I don't agree with it. I think it provides an advantage of having a clk module in the DSP Bridge as all the calls to clock module are centralized in one location, which would aid in Bridge debugging.
>

If you mean there is separate clock infrastructure for DSPBridge other
than clock framework we have for OMAP, then DSPBridge should convert
to the one we have for OMAP. As recent work by Paul for clock
framework on OMAP3 and Power domains we need centralized code for clk
and power domains not separate clock infrastructure for DSPBridge.

Richard and Paul can probably explain more about OMAP clock framework
and why it has to be used by DSPBridge too.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
