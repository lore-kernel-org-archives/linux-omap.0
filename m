From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 09 Oct 2013 09:38:49 +0200
Message-ID: <52550809.2000407@gmail.com>
References: <1380639886-9526-1-git-send-email-zonque@gmail.com> <5254DB86.4000104@ti.com>,<5254E60F.80009@ti.com> <F774F8C9-0A8F-4B27-8607-874FB0901A78@ti.com> <5254F54D.7060709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:43568 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab3JIHiw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 03:38:52 -0400
In-Reply-To: <5254F54D.7060709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gururaja Hebbar <gururaja.hebbar@ti.com>
Cc: "Fernandes, Joel" <joelf@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "neumann@teufel.de" <neumann@teufel.de>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "vinod.koul@intel.com" <vinod.koul@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Balbi, Felipe" <balbi@ti.com>

Hi everyone,

On 09.10.2013 08:18, Gururaja Hebbar wrote:
> On Wednesday 09 October 2013 11:33 AM, Fernandes, Joel wrote:
>> Some temporary issues with my mua so forgive any artifacts in this
>> email.
>> 
>> On Oct 9, 2013, at 12:14 AM, "Hebbar, Gururaja"
>> <gururaja.hebbar@ti.com> wrote:
>> 
>>> On Wednesday 09 October 2013 09:58 AM, Joel Fernandes wrote:
>>>> On 10/01/2013 10:04 AM, Daniel Mack wrote:

>>> AFAIK, Suspend/resume should be quick. Allocating and
>>> deallocating on every iterating would be useless and time
>>> consuming.
>> 
>> Nobody said allocate and deallocate on every iteration. Allocate
>> once during the first suspend call and then don't have to allocate
>> on subsequent calls.
> 
> I couldn't find any code which allocates parameters inside suspend. 

Me neighter :)

But on a general note, I wonder whether it's really worth discussing and
merging this patch. As I wrote in the cover letter, it's just a quick
and dirty solution that I copied from a very old BSP tree, and I know
that the file I'm patching here is going to be removed soon anyway.
Actually, the sooner the better.

(And the 'v3' in the subject is really my bad, sorry - I only sent one
version of this patch ever).

I can respin the patch on top of the proper driver once all the edma
bits have eventually been moved to drivers/dma. Is anyone continuing
Matt Porter's work on this?


Thanks,
Daniel
