From: Nick Krause <xerofoify@gmail.com>
Subject: Re: FIX ME in function ocpi_enable in file arch/arm/mach-omap1/opci.c
Date: Wed, 2 Jul 2014 21:04:58 -0400
Message-ID: <CAPDOMVi0E9vsfMsXfxM5SivnO8nDXaP+W+y0Nnuv32+WPQ05jg@mail.gmail.com>
References: <CAPDOMVgP83G4-znp=9kB-pBrfd2MUK+xvw1-_cRMXqi9P8hrww@mail.gmail.com>
	<20140702065531.GS28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140702065531.GS28884@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Therefore I will send it a patch removing this FIXME.
Cheers Nick

On Wed, Jul 2, 2014 at 2:55 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Nick Krause <xerofoify@gmail.com> [140701 15:51]:
>> Hey Tony and Russel ,
>> There is a FIX ME message in this function of the file stated in my
>> subject line.
>> I was wondering what locking is needed  here due to not having experience with
>> omap subsystem(s).
>
> Looks like the locking for ocpi_enable would be needed if
> it was called from multiple drivers. We are just enabling all
> access, so no locking neeed for the current usage.
>
> Regards,
>
> Tony
