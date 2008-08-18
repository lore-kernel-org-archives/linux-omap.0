From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Mon, 18 Aug 2008 22:54:21 +0530
Message-ID: <5d5443650808181024i12028fabv2fd35ff6151ba2a7@mail.gmail.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
	 <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E0B3121EE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:43884 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbYHRRYW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 13:24:22 -0400
Received: by gxk10 with SMTP id 10so5154663gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 10:24:21 -0700 (PDT)
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
> -- I agree with Vijay. We can remove the simple wrapper functions like the ones in CSL and ISR, but some of the other >modules in the services provide more functionality than just being the wrappers. We don't want to compromise on any >current debugging features that are provided by these modules at the expense of replacing the services functions with >direct kernel calls. This would require careful analysis.

What are those __other__ modules? Could you please list out them so
that other can help you why direct kernel API won't work there?

Now there are beagleboards out in the market, other developers can
also help you guys in submitting/cleaning up patches, as far as there
is no duplicate work going on and regular visibility on work done by
TI/Nokia on Bridge internally.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
