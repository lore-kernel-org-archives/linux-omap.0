From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [PATCH 0/3] OMAP MMU framework patches
Date: Mon, 5 Mar 2007 13:31:09 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA605EBFE54@dlee05.ent.ti.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429636DBF@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429636DBF@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Trilock, Toshihiro and Paul,

I need to enable camera-isp MMU in my 3430 project and hence am looking
at the MMU framework code posted by Trilock. There are a few questions
that I like to discuss with you.

- omap_mmu_exmap(): It either maps a physically contiguous buffer to a
virtually contiguous space (when type!=3DEXMAP_TYPE_MEM), or allocates a
set of 1M/64K/4K buffers and maps these buffers to a virtually
contiguous space (when type=3D=3DEXMAP_TYPE_MEM). It doesn't seem to me =
that
this API can map a set of dis-contiguous pages to a contiguous virtual
space. The typical camera use case is that we need to map a
scatter-gather list to a contiguous virtual space. I don't see this is
supported. Do I miss something here?

- The same API also checks the TLB. A mapping request is denied if TLB
is full. Camera MMU has only 8 TLB entries. TLB-only approach is almost
certainly impossible. Is the framework allowing the underlying MMU
driver to use table walking logic? This is not clear to me as the struct
omap_mmu_ops doesn't have enough comments.=20

- Can you send me the driver code that actually calls omap_mmu_register?
Knowing how a mmu driver should be written definitely helps
understanding this mmu framework.     =20


Regards,
Jian
=20
>=20
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
> Trilok Soni
> Sent: Tuesday, February 20, 2007 2:21 AM
> To: Hiroshi DOYU
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: [PATCH 0/3] OMAP MMU framework patches
>=20
> Doyu-San,
>=20
> On 2/20/07, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>=20
> > First off, though this code was enough tested with N800(omap2), it
can
> > _break_ omap1 compatibility. So we should make sure that this would
> work
> > fine with omap1, at least with some dspgw test programs, preferably
> N770.
>=20
> I don't have access to OMAP1 or N770. I only have H4, 2430 and soon
> OMAP3.
>=20
> >
> > Secondly, this MMU framework can be used with iva and camera
> > driver. So kernel config should be separated as CONFIG_OMAP_MMU_FRW
or
> > something.
>=20
> Yes, I am aware of this. It is on my TO-DO list, including seq_bit
> simplification.
>=20
> >
> > Thirdly, it's necessary to make sure that this can be compiled as
> > kernel module, along with dspgw and mailbox compiled as kernel
module.
>=20
> Yes, I wanted to push this drivers to mailing list so that others can
> start reviewing it, but again I am going to make it compile as module.
> So, expect patches on above items.
>=20
> >
> > For reference I've attached the patch for omap1, but I havn't had
> > enough time to test this with N770, probably something is still
> > missing.
>=20
> Thanx. Let's see what Tony suggest. If he wants to me to integrate all
> above changes and re-produce the patches OR submit them as incremental
> patches.
>=20
> --
> --Trilok Soni
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
