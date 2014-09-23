From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/2] remoteproc: add support to handle internal memories
Date: Tue, 23 Sep 2014 11:42:45 -0500
Message-ID: <5421A305.1050509@ti.com>
References: <1404836521-59637-1-git-send-email-s-anna@ti.com> <1404836521-59637-3-git-send-email-s-anna@ti.com> <CAK=WgbY-WmcJdnLHDf1CSkJqNBUeUMPTLcEZyLGKnECbxH1OAQ@mail.gmail.com> <53D7F6F3.9020804@ti.com> <CAK=WgbZ+NhA5AAhURUOojwnCbi2wYkJ11i-C5e7-kpZL5vD_3g@mail.gmail.com> <54174082.4010008@ti.com> <CAK=WgbZanJYN7-vXW=wo0H40piauHGQHYPPppcCpc+6VapXmeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbZanJYN7-vXW=wo0H40piauHGQHYPPppcCpc+6VapXmeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Robert Tivy <rtivy@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On 09/23/2014 09:16 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Mon, Sep 15, 2014 at 10:39 PM, Suman Anna <s-anna@ti.com> wrote:
>> These processors need to use their internal RAM for loading, which is
>> not for generic usage by the kernel, so defining a CMA block for this
>> memory doesn't make sense.
> 
> Ok - so just to make sure I understand, this is physical memory you
> want to use, which belongs to the remote processor, and which isn't
> mapped normally by the kernel?

Yes, this is not the regular DDR that is mapped into kernel normally,
but is a RAM internal to the remote processor subsystem. The MPU can
access it through a bus address/

> 
>> Will it suffice to replace the memcpy() with memcpy_toio()?
> 
> Yes, memcpy_toio should be fine (and then you don't need to cast the
> cookie returned by ioremap).

I have posted v2, and have not modified for this. The memcpy portion is
actually present in the remoteproc_elf_loader.c, and looks like I need
to export some flags from rproc_va_to_da if I were to differentiate
this. Is that ok with you?

regards
Suman
