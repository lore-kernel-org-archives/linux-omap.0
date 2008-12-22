From: David Brownell <david-b@pacbell.net>
Subject: Re: DSP/IOMMU needs 128-byte alignment from user-space buffers?
Date: Sun, 21 Dec 2008 18:19:47 -0800
Message-ID: <200812211819.47692.david-b@pacbell.net>
References: <94a0d4530812170526x51aa7959r52c7583661c5a9da@mail.gmail.com> <8F7AF80515AF0D4D93307E594F3CB40E1A0CFAAB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:20273 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751874AbYLVCTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Dec 2008 21:19:49 -0500
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E1A0CFAAB@dlee03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On Wednesday 17 December 2008, Kanigeri, Hari wrote:
> When the DSP processes data, the DSP cache controller
> loads 128-Byte chunks (lines) from SDRAM and writes the
> data back in 128-Byte chunks.

In short:  it's the same kind of cache line sharing issue
that any other DMA-using software needs to be aware of,
except that (a) the lines are 128 bytes vs whatever ARM
uses, and (b) the other bus master is a CPU instead of
something relatively dumb.

Any software that runs on non-x86 hardware will likely
have had to deal with such issues already, since most
hardware other than x86 relies on software to prevent
cache coherency goofs:  no bus snooping, MOESI, etc.

- Dave



> If a DMM buffer does not start and end on a 128-Byte
> boundary, the data preceding the start address from
> the 128-Byte boundary to the Start Address and the
> data at addresses trailing the end address from the
> End Address to the next 128-Byte boundary will be
> loaded and written back as well.         


