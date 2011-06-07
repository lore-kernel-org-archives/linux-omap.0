From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 2/6] omap: iovmm: generic iommu api migration
Date: Tue, 7 Jun 2011 13:28:53 +0300
Message-ID: <BANLkTi=nJXSEfWRXqwnHys1b5i5rgLcYpw@mail.gmail.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
 <1307053663-24572-3-git-send-email-ohad@wizery.com> <201106071105.16262.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201106071105.16262.laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hiroshi.DOYU@nokia.com, arnd@arndb.de, davidb@codeaurora.org, Joerg.Roedel@amd.com
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On Tue, Jun 7, 2011 at 12:05 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> pgsz isn't used anymore, you can remove it.

Ok.

>> + =A0 =A0 =A0 =A0 =A0 =A0 order =3D get_order(bytes);
>
> Does iommu_map() handle offsets correctly, or does it expect pa to be=
 aligned
> to an order (or other) boundary ?

Right now we have a BUG_ON if pa is unaligned, but that can be changed
if needed (do we want it to handle offsets ?).

> As Russell pointed out, we should use sg->length instead of sg_dma_le=
ngth(sg).
> sg_dma_length(sg) is only valid after the scatter list has been DMA-m=
apped,
> which doesn't happen in the iovmm driver. This applies to all sg_dma_=
len(sg)
> calls.

I'll make sure I don't introduce such calls, but it sounds like a
separate patch should take care of the existing ones; pls tell me if
you want me to send one.

Thanks,
Ohad.
