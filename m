From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Sat, 16 Aug 2008 00:09:37 +0300
Message-ID: <94a0d4530808151409p309cf9e2sf1ab3274baac32fb@mail.gmail.com>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <5d5443650808150052l29bf0830u60ff256b51d53066@mail.gmail.com>
	 <94a0d4530808150247g52c1e258v5b922e01fb5154bc@mail.gmail.com>
	 <20080815.133409.81509340.Hiroshi.DOYU@nokia.com>
	 <20080815112112.GB16840@atomide.com>
	 <13B9B4C6EF24D648824FF11BE8967162036210E182@dlee02.ent.ti.com>
	 <94a0d4530808151220v75f45a09hdbca8cdf69b93b59@mail.gmail.com>
	 <94a0d4530808151228s136e112die4718ca8ed90c22e@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE8967162036210E46B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:19608 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbYHOVJi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 17:09:38 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1129131rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 14:09:37 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036210E46B@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Pasam, Vijay" <vpasam@ti.com>

On Fri, Aug 15, 2008 at 11:16 PM, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> Hi Felipe,
>
>> owner@vger.kernel.org] On Behalf Of Felipe Contreras
>
> <snip>
>
>> >> As part of contributing this code there has been a lot of reworking
>> of the code. Last I had heard checkpatch and sparse warnings had been
>> killed. There was also a lot of work in making sure there would be no
>> legal impact to the kernel to clear its ability to be contributed.
>> >
>> > Not true: 13 errors, 246 warnings.
>
> Today another set of warning changes is in queue. Will have to check what the current number has become. It will be low. The start number a while back was defiantly very high.
>
> Checkpatch.pl is just a guide.  Completely changing code for the tool isn't probably a good idea. It might even get you severally flamed on LKML :)  The recent threads are informative (ok to read, bad to be in).
>
> Incidentally, when I asked the person working these changes, they had reported 0 functional errors had been fixed by the checkpatch changes.  A lot of the noise was typedef reduction.

I'm not familiar with checkpatch, but I guess the purpose is not to
highlight functional issues.

However, there are functional issues, but it makes sense to cleanup
the code first: there's no point in analyzing code that is never used.

> <snip>
>
>> Err, I got confused about the CE/Link, I meant the xdctools... or
>> whatever is needed to compile DSP nodes. AFAIK the DSP compiler is not
>> enough.
>
> You are correct that the internal DSP architecture is not opened up only the ARM side and the peripherals.  DSP internals is another topic.  You should be able to compile the ARM side.

Indeed, if I put myself the open source cap I can create ARM side
applications, but then I need something running on the DSP in order to
test them. If I put my corporate cap I can do that, and see that
effectively, my ARM application works. But how are maintainers
supposed to test this?

At the very least I would expect a base image binary, and a dummy dsp
node that simply copies the buffers received so that anyone can get
their hands dirty with the dsp bridge. Otherwise it's just some code
that nobody can test (hard to merge that way).

> A few years back I had heard about some people even successfully running Linux on the C6x DSP.  I think it ran well, but kind of neat all the same.  DSPBIOS or other tiny OSes work much better there.

Interesting, another platform to conquer for Linux ;)

Best regards.

-- 
Felipe Contreras
