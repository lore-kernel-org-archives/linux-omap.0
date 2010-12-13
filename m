From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RESEND] [PATCH 1/2] OMAP1: allow reserving memory for camera
Date: Mon, 13 Dec 2010 15:52:20 +0000
Message-ID: <AANLkTimTVWVmVfppAWSosidqLmo6c+8rPhLg=oJAVoYH@mail.gmail.com>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl>
	<201012101159.21845.jkrzyszt@tis.icnet.pl>
	<201012101203.09441.jkrzyszt@tis.icnet.pl>
	<20101210170356.GA28472@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20101210170356.GA28472@n2100.arm.linux.org.uk>
Sender: linux-media-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10 December 2010 17:03, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 10, 2010 at 12:03:07PM +0100, Janusz Krzysztofik wrote:
>> =C2=A0void __init omap1_camera_init(void *info)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct platform_device *dev =3D &omap1_camera_d=
evice;
>> + =C2=A0 =C2=A0 dma_addr_t paddr =3D omap1_camera_phys_mempool_base;
>> + =C2=A0 =C2=A0 dma_addr_t size =3D omap1_camera_phys_mempool_size;
>> =C2=A0 =C2=A0 =C2=A0 int ret;
>>
>> =C2=A0 =C2=A0 =C2=A0 dev->dev.platform_data =3D info;
>>
>> + =C2=A0 =C2=A0 if (paddr) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dma_declare_coherent=
_memory(&dev->dev, paddr, paddr, size,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE))
>
> Although this works, you're ending up with SDRAM being mapped via
> ioremap, which uses MT_DEVICE - so what is SDRAM ends up being
> mapped as if it were a device.

BTW, does the generic dma_declare_coherent_memory() does the correct
thing in using ioremap()? Maybe some other function that takes a
pgprot_t would be better (ioremap_page_range) and could pass something
like pgprot_noncached (though ideally a pgprot_dmacoherent). Or just
an architecturally-defined function.

--=20
Catalin
