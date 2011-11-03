From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP: omap_device: Include linux/export.h
Date: Thu, 03 Nov 2011 10:48:44 -0700
Message-ID: <877h3hhzb7.fsf@ti.com>
References: <1320303638.17983.5.camel@phoenix> <87d3d9i8ni.fsf@ti.com>
	<4EB2A987.2040805@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4EB2A987.2040805@windriver.com> (Paul Gortmaker's message of
	"Thu, 3 Nov 2011 10:47:35 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> On 11-11-03 10:26 AM, Kevin Hilman wrote:
>> Axel Lin <axel.lin@gmail.com> writes:
>> 
>>> Include linux/export.h to fix below build warning:
>>>
>>>   CC      arch/arm/plat-omap/omap_device.o
>>> arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
>>> arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
>>> arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration
>>>
>>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>> 
>> Thanks, will queue as a fix for v3.2-rc
>
> It is probably better if I track this, since export.h won't
> exist until Linus pulls the module.h-split tree, and I'm
> guessing that will be closer to the end of the merge window.

OK, sounds good.  Feel free to add:

Acked-by: Kevin Hilman <khilman@ti.com>

Thanks,

Kevin
