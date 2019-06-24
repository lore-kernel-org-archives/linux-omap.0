From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 0/2] Add Mailbox support for TI K3 SoCs
Date: Mon, 24 Jun 2019 17:21:06 -0500
Message-ID: <CABb+yY0xOd_oJLg_BffKXuRtnpHeR-jg1EtKE4KVovy2u3MBuA@mail.gmail.com>
References: <20190604170146.12205-1-s-anna@ti.com> <47b8f278-85ff-18be-d5a0-fde9de6e17f2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <47b8f278-85ff-18be-d5a0-fde9de6e17f2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Devicetree List <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 24, 2019 at 3:39 PM Suman Anna <s-anna@ti.com> wrote:
>
> Hi Jassi,
>
> On 6/4/19 12:01 PM, Suman Anna wrote:
> > Hi Jassi,
> >
> > The following series adds the support for the Mailbox IP present
> > within the Main NavSS module on the newer TI K3 AM65x and J721E SoCs.
> >
> > The Mailbox IP is similar to the previous generation IP on OMAP SoCs
> > with a few differences:
> >  - Multiple IP instances from previous DRA7/AM57 family each form a
> >    cluster and are part of the same IP. The driver support will continue
> >    to be based on a cluster.
> >  - The IP is present within a Main NaVSS, and interrupts have to go
> >    through an Interrupt Router within Main NavSS before they reach the
> >    respective processor sub-system's interrupt controllers.
> >  - The register layout is mostly same, with difference in two registers
> >
> > Support is added by enhancing the existing OMAP Mailbox driver to
> > support the K3 IP using a new compatible. The driver also has to be
> > adjusted to deal with the 32-bit mailbox payloads vs the 64-bit
> > pointers used by the Mailbox API on these Arm v8 platforms.
> >
> > DT nodes will be posted separately once the binding is acked.
>
> Can you please pick this series up for 5.3 merge window if you do not
> have any comments.
>
I will. Usually I leave the code to cook in the open for as long as
possible, more so when no acks are coming.
Cheers!
