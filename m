From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention
 issue
Date: Mon, 23 Jul 2012 11:33:06 +0300
Message-ID: <500D0C42.8030508@ti.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com> <CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com> <87fw9o32v2.fsf@ti.com> <CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com> <87vcij1loh.fsf@ti.com> <CAP05o4+6LxwdwCUQF_0b6dCQ9JQarNeUBzO=qgdUgnreMtDeMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58533 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab2GWIdW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jul 2012 04:33:22 -0400
In-Reply-To: <CAP05o4+6LxwdwCUQF_0b6dCQ9JQarNeUBzO=qgdUgnreMtDeMg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, notasas@gmail.com

Hi,

On 06/22/2012 05:43 PM, Munegowda, Keshava wrote:
> On Fri, Jun 22, 2012 at 7:41 PM, Kevin Hilman <khilman@ti.com> wrote:
>> "Munegowda, Keshava" <keshava_mgowda@ti.com> writes:
>>
>> [...]
>>

>>
>> You are not reading what I write.
>>
>> To repeat: your patch fixes the oops during boot, and the suspend hang
>> and now I see CORE hit retention in *suspend*.
> 
> thanks !
> 
>>
>> However,  CORE does still not hit retention during *idle*.
> 
> here is the problem.
> 
> usb host retention in idle is not supported till now.
> in current code, usb host cuts clock only in driver suspend not in bus
> suspend ( auto suspend).
> usb host driver need to use the  io daisy chain framework through io wakeup.
> I will post the patches once ehci remote wakeup features stabilized in
> omap3, omap4 and omap5 too.
> 

We are talking about CORE retention support during idle. How is IO daisy
chaining related to that? Doesn't IO daisy chain only apply when device
hits OFF?

regards,
-roger
