From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [RFC] dmaengine: add new api for preparing simple slave transfer
Date: Fri, 10 Jun 2011 00:28:25 +0530
Message-ID: <BANLkTikvURS7aQEBax0xEfcFZMg3-cUPow@mail.gmail.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE2DED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35015 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab1FIS61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 14:58:27 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE2DED@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raju, Sundaram" <sundaram@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jun 9, 2011 at 6:09 PM, Raju, Sundaram <sundaram@ti.com> wrote:

> Generic buffer description:
> A generic buffer can be split into number of frames which contain num=
ber of chunks inside them. The frames need not be contiguous, nor do th=
e chunks inside a frame.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0------------------------------------------=
-------------------------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0| Chunk 0 |ICG| Chunk 1 |ICG| ... |ICG| Ch=
unk n | =C2=A0 =C2=A0 =C2=A0 Frame 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0------------------------------------------=
-------------------------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Inter Frame Gap =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0------------------------------------------=
-------------------------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0| Chunk 0 |ICG| Chunk 1 |ICG| ... |ICG| Ch=
unk n | =C2=A0 =C2=A0 =C2=A0 Frame 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0------------------------------------------=
-------------------------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Inter Frame Gap =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0------------------------------------------=
-------------------------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .......=
=2E =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> =C2=A0 =C2=A0 =C2=A0 =C2=A0------------------------------------------=
-------------------------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Inter Frame Gap =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0------------------------------------------=
-------------------------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0| Chunk 0 |ICG| Chunk 1 |ICG| ... |ICG| Ch=
unk n | =C2=A0 =C2=A0 =C2=A0 Frame m
> =C2=A0 =C2=A0 =C2=A0 =C2=A0------------------------------------------=
-------------------------

IIUC the above figure, the work done by DMA controller remains the
same, either by
passing this as a transfer of the new type or as a normal sg-list  - un=
less
the DMAC driver attempts to reorder the transfers or the DMAC h/w
natively supports
some form of sg-list.
=46or DMACs, that have no special support, different representation
wouldn't make a
difference.
And if the DMAC does support the kind of fancy scatter-gather, it
should be possible for
the dma api driver to analyze the submitted 'normal' sg-list and
program the transfers at one go.
Besides, it should be possible to have a 'template' sequence of
requests prepared
already because usually, for above mentioned scenario, the parameters
don't change across
items in a list.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
