From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] ARM: omap: edma: add suspend suspend/resume hooks
Date: Fri, 18 Oct 2013 17:57:06 +0200
Message-ID: <52615A52.5070506@gmail.com>
References: <1380639886-9526-1-git-send-email-zonque@gmail.com> <5254DB86.4000104@ti.com>,<5254E60F.80009@ti.com> <F774F8C9-0A8F-4B27-8607-874FB0901A78@ti.com> <5254F54D.7060709@ti.com> <52550809.2000407@gmail.com> <52556467.7010400@ti.com> <5255B942.5000601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5255B942.5000601-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joelf-l0cyMroinI0@public.gmane.org
Cc: Gururaja Hebbar <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org" <neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org>, "bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/09/2013 10:14 PM, Joel Fernandes wrote:
> On 10/09/2013 09:12 AM, Joel Fernandes wrote:
>> On 10/09/2013 02:38 AM, Daniel Mack wrote:
> [..]
>>> (And the 'v3' in the subject is really my bad, sorry - I only sent one
>>> version of this patch ever).
>>>
>>> I can respin the patch on top of the proper driver once all the edma
>>> bits have eventually been moved to drivers/dma. Is anyone continuing
>>> Matt Porter's work on this?
>>
>> The work is waiting on conversion of the davinci-pcm ASoC driver to DMA Engine,
>> which once done can make exposing the private EDMA API in arch/arm/common/edma.c
>> obsolete and we can take it to drivers/dma. Some more work to be done in edma in
>> unifying the probe etc.
> 
> Forgot to mention, since ASoC DMAengine conversion is not going to happen any
> time soon considering the amount of work involved, I suggest you respin this
> patch on the common/edma code itself. That way we can keep suspend/resume
> working on these platforms that use EDMA till the actual conversion takes place.

Ok, I also figured that the current patch does not really suffice. There
seems to be an issue with omap_hsmmc DMA channels being disfunct after
resume, so I'll respin it.

> I suggest though to recreate the state based on existing datastructures instead
> of allocating/saving additional memory.
> 
> Hope you're also in agreement with my comments on your original patch on what
> needs to / need not be saved.

I'm still not sure whether the parameters block has to be preserved
manually. Let see what we're left with eventually :)


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
