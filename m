From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] omap: dsp: make the driver actually work
Date: Wed, 6 Oct 2010 00:05:44 +0300
Message-ID: <AANLkTi=ENjWQRYitr_kYzmRKgve=CoBf=7Y5KHLJNLfb@mail.gmail.com>
References: <1286208555-8829-1-git-send-email-felipe.contreras@gmail.com>
	<20101005190741.GC20825@kroah.com>
	<AANLkTikOBWxXh7uVrDxfW3OnwOM58JTXU76KUUoQWBWM@mail.gmail.com>
	<27F9C60D11D683428E133F85D2BB4A5304681D4889@dlee03.ent.ti.com>
	<AANLkTin=k07hUq+cLAOsf0aYw5Ey23UOpbpo=+Eb49w9@mail.gmail.com>
	<27F9C60D11D683428E133F85D2BB4A5304681D48D3@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5304681D48D3@dlee03.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 5, 2010 at 11:09 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> Felipe Contreras wrote:
> ...
>>>
>>> phys_to_virt instead of ioremap should work fine, still need to try
>>> it though.
>>
>> I tried that... Didn't work. I guess we need to flush at some points
>> (since the memory is cacheable).
>
> Hmmm, because my other option was to move the reserved memory outside the kernel, but that involves specifying bootargs again and using dma_alloc_coherent with their restrictions.

Huh, if there's no contiguous memory region reserved, then the driver
is doing dma_alloc_coherent already, but that fails (apparently 5M is
too much). Plus I've read that dma_alloc_coherent is "precious";
shouldn't be used for that.

> If you are working on a different method and need any help let me know.

So, first I wanted to try reserving some region with mem=X boot param,
but that solution is ugly. If that worked, then I wanted ti see if
flushing each time we access that shm memory block works, but in the
process I wanted to reorganize the whole initialization code because
right now it's very ugly and confusing.

-- 
Felipe Contreras
