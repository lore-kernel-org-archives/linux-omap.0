From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [next-20150119]regression (mm)?
Date: Tue, 20 Jan 2015 12:50:59 -0200
Message-ID: <CAOMZO5D-Z-FLPmQ4Yy3rxBa-FebLcnG9TSzg3F-MF-TFBBMrwQ@mail.gmail.com>
References: <54BD33DC.40200@ti.com>
	<20150119174317.GK20386@saruman>
	<20150120001643.7D15AA8@black.fi.intel.com>
	<20150120114555.GA11502@n2100.arm.linux.org.uk>
	<20150120140546.DDCB8D4@black.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:39230 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbbATOvB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 09:51:01 -0500
In-Reply-To: <20150120140546.DDCB8D4@black.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, linux-mm@kvack.org, linux-next <linux-next@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

On Tue, Jan 20, 2015 at 12:05 PM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> Russell King - ARM Linux wrote:
>> On Tue, Jan 20, 2015 at 02:16:43AM +0200, Kirill A. Shutemov wrote:
>> > Better option would be converting 2-lvl ARM configuration to
>> > <asm-generic/pgtable-nopmd.h>, but I'm not sure if it's possible.
>>
>> Well, IMHO the folded approach in asm-generic was done the wrong way
>> which barred ARM from ever using it.
>
> Okay, I see.
>
> Regarding the topic bug. Completely untested patch is below. Could anybody
> check if it helps?

Yes, it helps. Now I can boot mx6 running linux-next 20150120 with
your patch applied.
