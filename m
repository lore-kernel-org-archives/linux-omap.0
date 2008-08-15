From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Fri, 15 Aug 2008 22:28:19 +0300
Message-ID: <94a0d4530808151228s136e112die4718ca8ed90c22e@mail.gmail.com>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <5d5443650808150052l29bf0830u60ff256b51d53066@mail.gmail.com>
	 <94a0d4530808150247g52c1e258v5b922e01fb5154bc@mail.gmail.com>
	 <20080815.133409.81509340.Hiroshi.DOYU@nokia.com>
	 <20080815112112.GB16840@atomide.com>
	 <13B9B4C6EF24D648824FF11BE8967162036210E182@dlee02.ent.ti.com>
	 <94a0d4530808151220v75f45a09hdbca8cdf69b93b59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:7857 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756041AbYHOT2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 15:28:20 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1088934rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 12:28:20 -0700 (PDT)
In-Reply-To: <94a0d4530808151220v75f45a09hdbca8cdf69b93b59@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Pasam, Vijay" <vpasam@ti.com>

On Fri, Aug 15, 2008 at 10:20 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Aug 15, 2008 at 7:01 PM, Woodruff, Richard <r-woodruff2@ti.com> wrote:
>> Hi,
>>
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Tony Lindgren
>>> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080815 13:34]:
>>> > Thank you guys for your comments,
>>> >
>>> > It seems that some of the patches couldn't be sent to ML because of
>>> > the size limitation of vger.kernel.org ML. Now Tony is finding the
>>> > place to put the rest up on somewhere for review. I don't know if
>>> > reviwing these base code makes so much sense at this momenent,
>>> > though..which doesn't mean "no probelm";p
>>>
>>> I've copied your patches to:
>>>
>>> http://www.muru.com/linux/tidspbridge/
>>>
>>> > I hope that everyone could work together on this branch without any
>>> > problems eventually.
>>>
>>> We need to also figure out who's going to maintain the dspbridge
>>> branch. Ideally somebody with experience with dsp and linux..
>>
>> Really all the design, maintenance and test experience of that code is inside of TI.  This has lived for years and derivates have shipped in products.  Who ever watches over it needs to be able to provide a creditable multi-year commitment.
>>
>> As part of contributing this code there has been a lot of reworking of the code. Last I had heard checkpatch and sparse warnings had been killed. There was also a lot of work in making sure there would be no legal impact to the kernel to clear its ability to be contributed.
>
> Not true: 13 errors, 246 warnings.
>
>> If people really need it to work and not re-wait for a year, some sane strategy needs to be employed. Most people in the mainline kernel just won't care about a niche driver like this. As such the only real gate for its inclusion is mainly _here_.
>>
>> As there are many users/customers putting a solid and functional 1.0 in place would benefit everyone who needs it and would allow cooperative development to ensure it would indeed work starting _today_ and continuing into the future.  TI users _today_ use and need this bridge.
>>
>> Major interface and functional partitioning changes will happen as such a piece of code evolves. This kind of thing seems more like 2.0 goals.  The point is that is something to be planned in a ToDo list.  Are their missing functions in what it provides today?
>>
>> For this kind of piece to be successful it needs support from many sides.
>>
>> TI is willing to support this and has the necessary critical technical context, incentive and attention span. Agreement is needed on roadmap aspects of the code. If that doesn't happen what will result is a lot of local patches on everyone's development tree.
>
> What TI has offered so far is code, and the comments have been on this
> code. You seem to want maintainers to understand that this is code
> that works "today", but I don't think the code can be tested right now
> since the tools (CE/Link) are not available out in the open.

Err, I got confused about the CE/Link, I meant the xdctools... or
whatever is needed to compile DSP nodes. AFAIK the DSP compiler is not
enough.

-- 
Felipe Contreras
