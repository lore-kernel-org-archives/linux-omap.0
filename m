From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Tue, 19 Aug 2008 13:33:06 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E129DEDCB@dlee03.ent.ti.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
	 <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E0B3121EE@dlee03.ent.ti.com>
 <5d5443650808181024i12028fabv2fd35ff6151ba2a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:56918 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756249AbYHSSi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 14:38:27 -0400
In-Reply-To: <5d5443650808181024i12028fabv2fd35ff6151ba2a7@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "tony@atomide.com" <tony@atomide.com>

> What are those __other__ modules? Could you please list out them so
> that other can help you why direct kernel API won't work there?

--- You can check dsp bridge services folder on omap3/4+ tree for the __other__ modules :). 

CSL, ISR, PRCS modules can be removed. I provided an explanation on why clk.c cannot be removed in previous email. Some time ago I provided you an explanation on why dpc module cannot be replaced with direct calls to tasklets. 

If you have any questions on the rest of the modules please let me know.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Trilok Soni [mailto:soni.trilok@gmail.com]
> Sent: Monday, August 18, 2008 12:24 PM
> To: Kanigeri, Hari
> Cc: Pasam, Vijay; Hiroshi DOYU; linux-omap@vger.kernel.org; Woodruff,
> Richard; felipe.contreras@gmail.com; siarhei.siamashka@nokia.com; Ramirez
> Luna, Omar; Gupta, Ramesh; tony@atomide.com
> Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
> 
> Hi Hari,
> 
> On Mon, Aug 18, 2008 at 9:57 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > Hi,
> >
> >> Some of the above items are being looked at like replacing CSL, isr
> etc..
> >> But there are no equivalent API's or functionality available in kernel
> for
> >> many of them. We should replace the API's with the avaolable kernel
> API's
> >> and the remaining need to be looked at from long term.
> >>
> >
> > -- I agree with Vijay. We can remove the simple wrapper functions like
> the ones in CSL and ISR, but some of the other >modules in the services
> provide more functionality than just being the wrappers. We don't want to
> compromise on any >current debugging features that are provided by these
> modules at the expense of replacing the services functions with >direct
> kernel calls. This would require careful analysis.
> 
> What are those __other__ modules? Could you please list out them so
> that other can help you why direct kernel API won't work there?
> 
> Now there are beagleboards out in the market, other developers can
> also help you guys in submitting/cleaning up patches, as far as there
> is no duplicate work going on and regular visibility on work done by
> TI/Nokia on Bridge internally.
> 
> 
> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni

