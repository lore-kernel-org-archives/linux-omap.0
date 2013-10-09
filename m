From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 9 Oct 2013 09:12:55 -0500
Message-ID: <52556467.7010400@ti.com>
References: <1380639886-9526-1-git-send-email-zonque@gmail.com> <5254DB86.4000104@ti.com>,<5254E60F.80009@ti.com> <F774F8C9-0A8F-4B27-8607-874FB0901A78@ti.com> <5254F54D.7060709@ti.com> <52550809.2000407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52550809.2000407-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Gururaja Hebbar <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org" <neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org>, "bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/09/2013 02:38 AM, Daniel Mack wrote:
> Hi everyone,
> 
> On 09.10.2013 08:18, Gururaja Hebbar wrote:
>> On Wednesday 09 October 2013 11:33 AM, Fernandes, Joel wrote:
>>> Some temporary issues with my mua so forgive any artifacts in this
>>> email.
>>>
>>> On Oct 9, 2013, at 12:14 AM, "Hebbar, Gururaja"
>>> <gururaja.hebbar-l0cyMroinI0@public.gmane.org> wrote:
>>>
>>>> On Wednesday 09 October 2013 09:58 AM, Joel Fernandes wrote:
>>>>> On 10/01/2013 10:04 AM, Daniel Mack wrote:
> 
>>>> AFAIK, Suspend/resume should be quick. Allocating and
>>>> deallocating on every iterating would be useless and time
>>>> consuming.
>>>
>>> Nobody said allocate and deallocate on every iteration. Allocate
>>> once during the first suspend call and then don't have to allocate
>>> on subsequent calls.
>>
>> I couldn't find any code which allocates parameters inside suspend. 
> 
> Me neighter :)
> 
> But on a general note, I wonder whether it's really worth discussing and
> merging this patch. As I wrote in the cover letter, it's just a quick
> and dirty solution that I copied from a very old BSP tree, and I know
> that the file I'm patching here is going to be removed soon anyway.
> Actually, the sooner the better.

OK, I realize its also unnecessary to allocate save anything. In your new
version when you respin, please just recreate the state based on the in-memory
kernel data structures already there. Ex, you know which channels were allocated
so you just set those bits in the IESR.

> (And the 'v3' in the subject is really my bad, sorry - I only sent one
> version of this patch ever).
> 
> I can respin the patch on top of the proper driver once all the edma
> bits have eventually been moved to drivers/dma. Is anyone continuing
> Matt Porter's work on this?

The work is waiting on conversion of the davinci-pcm ASoC driver to DMA Engine,
which once done can make exposing the private EDMA API in arch/arm/common/edma.c
obsolete and we can take it to drivers/dma. Some more work to be done in edma in
unifying the probe etc.

thanks,

-Joel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
