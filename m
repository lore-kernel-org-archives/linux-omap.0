From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH 5/5] arm: omap: Proper cleanups for omap_device
Date: Wed, 07 Aug 2013 17:22:29 +0200
Message-ID: <52026635.1010602@ahsoftware.de>
References: <1375775624-12250-1-git-send-email-panto@antoniou-consulting.com> <1375775624-12250-6-git-send-email-panto@antoniou-consulting.com> <20130806093356.GA27889@kroah.com> <8C31ED90-E9EF-4264-858A-17CC2536B552@antoniou-consulting.com> <20130806101421.GA29283@kroah.com> <5200FC09.7080108@ahsoftware.de> <20130807055227.GB5304@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130807055227.GB5304@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?B?QmVub8OudCBDb3Vzc25v?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Sourav Poddar <sourav.poddar@ti.com>, Russ Dill <Russ.Dill@ti.com>, Felipe Balbi <balbi@ti.com>, Koen Kooi <koen@circuitco.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Am 07.08.2013 07:52, schrieb Greg Kroah-Hartman:
> On Tue, Aug 06, 2013 at 03:37:13PM +0200, Alexander Holler wrote:
>> Am 06.08.2013 12:14, schrieb Greg Kroah-Hartman:
>>
>>>> What exactly is a platform device anyway?
>>>
>>> Originally it was a "something that wasn't connected to a bus, but just
>>> had memory-mapped i/o."  Like the PS2 keyboard controller.
>>>
>>> Embedded systems got ahold of this and went to town, and made everything
>>> a platform device because they could, and no one was paying attention.
>>>
>>> Then OF came along and used it as well, and you know the rest...
>>>
>>> I think we need to get the ACPI and OF people, and me, in a room
>>> together at the kernel summit and not let us out until we have this all
>>> worked out.
>>
>> MFD uses platform devices too.
>
> Ugh, I've been avoiding looking at mfd for a long time now, and really
> don't want to start now...
>

I've just mentioned it to suggest that platform devices seem to be used 
all over the kernel as the generic (minimal) form of a device driver. At 
least that is the impression I've got.

Regards,

Alexander Holler
