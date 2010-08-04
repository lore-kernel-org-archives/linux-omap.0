From: John Faith <jfaith7@gmail.com>
Subject: Re: SDMA, V4L2, and videobuf-dma-sg
Date: Wed, 4 Aug 2010 14:59:31 -0700
Message-ID: <AANLkTik+dR-EwAy5Q+80NsZyZf6zmGgs9REuwPW+em1Q@mail.gmail.com>
References: <4C570654.3050006@irobot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33753 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab0HDV7c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 17:59:32 -0400
Received: by pxi14 with SMTP id 14so2225028pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Aug 2010 14:59:31 -0700 (PDT)
In-Reply-To: <4C570654.3050006@irobot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adam Wozniak <awozniak@irobot.com>
Cc: linux-omap@vger.kernel.org

On Mon, Aug 2, 2010 at 10:54 AM, Adam Wozniak <awozniak@irobot.com> wro=
te:
> Hello,
>
> I'm working with an OMAP3530 based custom board. =A0The board has 4 c=
ameras
> attached to it,

<snip>

> The problem I'm running into (I think) is that omap34xxcam.c uses
> videobuf-dma-sg to do its allocation and the videobuf_buffer I get is=
 using
> a scatterlist, and the pages in the scatterlist are noncontiguous. =A0=
In other
> words, if I use videobuf_to_dma(vb), the videobuf_dmabuf I get back h=
as a
> vmalloc of null and a bus_addr of null; only the scatterlist and page=
s
> fields have valid values. =A0There's no contiguous memory pointer I c=
an grab
> onto there.
>
> How do I get a pointer suitable for SDMA? =A0Will anything map this
> scatterlist so it looks contiguous for SDMA?

Hi Adam,
Not sure if it will help you, but I use this trick, also on a 3530, to
get a contiguous block of memory by setting "mem=3D" in the bootloader =
:
http://elinux.org/Memory_Management#Reserving_.28and_accessing.29_the_t=
op_of_memory_on_startup

, then I use ioremap() in my driver and open("/dev/mem") in userspace
to point to the same memory.

,
John
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
