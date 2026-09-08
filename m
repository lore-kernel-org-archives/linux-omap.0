Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403923B7B7D;
	Tue,  8 Sep 2026 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899827; cv=none; b=NOvXwq5seur9Tne0SbQvDbP/7cy8oR46VOTXPC4o5X+6X7YK6lOar1sS/ot2uPncRTIyLP5eC5hg+eSHLSXqGk11bfJp/xPIQcaGQkBa1V1GK5HKHVT7IzrCgAJbHQeh38+otf+IQ4AyNxMFbmYI3yfJPJOfh536dA6bnhTmX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899827; c=relaxed/simple;
	bh=sMPcXLuOphJeQMkameJw++rgwLy18Ig2Mso5jsVxFa0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RIkWxlK+SQ1XY7q0lUqDt+l556FGyQa+UJ8bPbMcLyip9v+ilU7lgUfhhgDXw9uDDRQcfjx+TWdkae1bAlnW+vzZgXtLTscjtkY6HZUHmKn6ALy2oMgb64Byr35zO3EVnz830tOv3GDMJIAmC82RW+2RzVgizjNc60CA9k64qAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=NAjOOp05; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYpK106Q; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="NAjOOp05";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYpK106Q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 2818A1380359;
	Tue,  8 Sep 2026 16:36:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 08 Sep 2026 16:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788899810; x=1788907010; bh=pqUYW0bsIz
	1MRJiTH8ODR5+Z5OztYYD4i1MgDVOm6Ak=; b=NAjOOp05FmBMCS7dxQLJgfE2hW
	w6TUKChriB4ipjT1C/6b0BkxUz1AY2TxoiMK+d0OLY6biHPKdiPdBG579O206u38
	iPIw4dV0h78BOX1zuO0RuqpPRDBQNCsV6w/MTx5tIfzkamPLDM/t/tPDF37ZBDR4
	+/cfV32omocYxL7PmrFeH6e1tiZAcFt37hoRzL45GTHl9iWDMD5biy9GYnsQ/f0X
	w2yb+XK5fyluUyuiotabWB3wyvO2bxmIyWULP/S/uIXUkrkLaOY4dByDPpWaUBQW
	vZs/hrvrpPxYyuDjLBBawucs6tvR21OnHV3dJteTR4E7Yr7Bh51VW46T7opw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788899810; x=1788907010; bh=pqUYW0bsIz1MRJiTH8ODR5+Z5OztYYD4i1M
	gDVOm6Ak=; b=MYpK106QXa7SHrHxJopUfAJ3PRzS3CSPQeayYizwMukJOIUp2SJ
	j7My+KWUA0Z6dapoxnefDkY3GvvElpd4ecqc8qd4vu0y5qCkecMfNwA3YV/BE6jS
	QLi4hnObup94Ibig4PI2E3gMVUbu07hS0u4LkRViEi0UJHan0jFRabKKXC+fIeXv
	qY+XgX/0cOCJTnsvOoGaZmuVCdy446zPJJPTtgVs/F3OrcFi1nWCXGWaD8yUbzde
	q+FkKqYDydkyGIvb4d/q2PsxXCneBiRMHaZCIE893hrfsTVkQMyDLBiwrwDC20f2
	YRlQaaCNjyDF3hRcHxkBIKBj/wkbnjY4VnA==
X-ME-Sender: <xms:4HGgakjZCQWsgjzAbw9qRaacMUe0u1aCRIhFBLtgS3WfryBwUd6LQA>
    <xme:4HGgaj-DFOER373OlHzSnoN6PGymM3MGxZeudJ6uBsweM2QGyvTU2yChzUIwSeqiM
    SrTVcjrQj81rxcLfNBinlCsQpGlFgTAWaFGyJNr5xpmfBVX120kOUg3>
X-ME-Received: <xmr:4HGgahOYgaXjAKpcyR5uN6U2IFqouCP-_dJdm8jxHuoOQEABmWk4jvjnez8z60Vg04pZjBVzzzkBFjrVWoMuvAzQdIuEKIxKchhBNC-HBRYtJdg>
X-ME-Proxy-Cause: dmFkZTE3ZM/SyJJA5f9HJ6ZEJfDxDBonK9o25olEG6PIQKs019YlNZrd9dn7Sc/XieHUcn
    5Kznh4bYlFFvrlgM0rAcn9kzln6yXI2mNyzRAv3J766/zGBxu4EMIY9kvp6oEkP+Q43sod
    NRBRo3shWtSAyJBu5giVwhJTG1SgAj27FXDUgKHLUqkLV4AFmVrdJg1JIm4AIKexghDbST
    j0bKh8CpkTqDHEMdT+eTdCx0gRj81FD3gckw52No1X4hJ5kYUwTEbtokIu9wVoyKsuCxUy
    7TJa9VU5nvtnhi1MXAPtmZ6eFaAbOPADYf/SrfNoscB8eOamERk90sczQcrmJPAHElTQPe
    N4NLzYtFM6Ocy827qv2x6TH+PHiOV6QRjeWUq0XAzRCiRcb4VNX4xrfpgq1i/xusCU4tOo
    N1vr/d8UiQv6r7ejvVBQln1fAqi9lDmu22+E4QR2QXeOLyv/sYPUrWysP66I6b99col9UY
    7nP7WiRIU/nktdjaMe19n7N5fB0JO0RbS1/XHt5wWUDaBONXrJCECjHiMPmSJpG773JZao
    EVvFvK8Q14ff3eSF47FCS+T+Q/U/5q8Z/WO3frif+A5JE1HI4WpeprpCNv8tp8YnUT+pAJ
    ZSvAg4V3uYrq++o5abUpSSu4H8jNuQhP0cnLHl3D2Xml56hamgJ+oFBSjlg3ydRbHKKMrZ
    Ml5wDHaY9nuRUxf+s0RsVxKVLn8WC+fBN5xc3C48pPk9TxrieEBX1ALdz56LDl82YWs1Lh
    5dzzw3dHXi+jSWIUAa8OScul/lZVZjeDMJ5HjBrYNRI/e6xKljI/vdTwES1CTshlRV624Q
    QV/DMuI+3f33/HZpkPWRM98YMW1kUseELroJpS5Xx9g6Uq8l/lm7OkWolrPmT446Ai0qHP
    QuDASXKYZuybgf7krhXXBunk7kOh1BFezUixmDmLP4fVIaLZuAamHMR2f22JSeoYQgvRmi
    ES+w7eN7p6H24NgVzrhSo3rapypGtyaZeOYvMG3jZvHPpmZKoUs
X-ME-Proxy: <xmx:4HGgappga0fjokIlZP2PofL_A1lDoDysqyEiXBvoQdmqORDmPG2j4A>
    <xmx:4HGgaheQ08CECSbOWZRgT4o9LL6E7j7w4JjMyRIZEG8nffIfq2sd1Q>
    <xmx:4HGgarg9PTwX8n5fj2g1f0aXKe0JlxseNd1BE7_98LIC3lqY-ols8w>
    <xmx:4HGgavPcAeQFqkzV6tcUUYjNpfnMdx_uA1HOKjw6pTulIn1UFbT1Pg>
    <xmx:4nGgarYu92IumWyYv0LxqnRqWstkwbXIsn3BLL8a2V5P0TVIA4uIVbwZ>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 16:36:47 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6504219268;
	Tue, 08 Sep 2026 16:36:47 -0400 (EDT)
Date: Tue, 8 Sep 2026 16:36:47 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@kernel.org>
cc: Krzysztof Kozlowski <krzk@kernel.org>,
     Alexandre Belloni <alexandre.belloni@bootlin.com>,
     Linus Walleij <linusw@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
     Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
     Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
     Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
     Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Frank Li <Frank.Li@nxp.com>,     Sascha Hauer <s.hauer@pengutronix.de>,
     Pengutronix Kernel Team <kernel@pengutronix.de>,
     Fabio Estevam <festevam@gmail.com>,
 Vladimir Zapolskiy <vz@mleia.com>,     Stefan Agner <stefan@agner.ch>,
     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
     Alexandre Torgue <alexandre.torgue@foss.st.com>,
     Aaro Koskinen <aaro.koskinen@iki.fi>,
     Andreas Kemnade <andreas@kemnade.info>,
     Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,     Tony Lindgren <tony@atomide.com>,
     Nicolas Ferre <nicolas.ferre@microchip.com>,
     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew@lunn.ch>,
     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
     Gregory Clement <gregory.clement@bootlin.com>,
     Robert Jarzmik <robert.jarzmik@free.fr>,
     Kristoffer Ericson <kristoffer.ericson@gmail.com>,
     Ethan Nelson-Moore <enelsonmoore@gmail.com>,
     Geert Uytterhoeven <geert@linux-m68k.org>,
     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
     Shawn Guo <shawnguo@kernel.org>,
 Karl Mehltretter <kmehltretter@gmail.com>,
     "David Hildenbrand (Arm)" <david@kernel.org>,
 linux-doc@vger.kernel.org,     linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,     devicetree@vger.kernel.org,
 imx@lists.linux.dev,     linux-stm32@st-md-mailman.stormreply.com,
 linux-omap@vger.kernel.org,     Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 01/13] ARM: remove sa1100 platform
In-Reply-To: <20260908152808.3928630-2-arnd@kernel.org>
Message-ID: <ccd58677-5e25-1f9f-2bb4-d1770fce8ac4@fluxnic.net>
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Sep 2026, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most sa1100 platforms were removed a few years, with the remaining
> ones left as a starting point for a conversion to devicetree.
> 
> Nothing ever happened on that front, so remove the rest now,
> including the sa1111 and locomo drivers that were once shared
> with pxa but are already sa1100-exclusive now.

The SA1100 was the starting point of my career. Feels strange how much 
time has passed.

I parted with such hardware a long time ago in any case.

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/arch/arm/index.rst              |    3 -
>  Documentation/arch/arm/sa1100/assabet.rst     |  301 ---
>  Documentation/arch/arm/sa1100/cerf.rst        |   35 -
>  Documentation/arch/arm/sa1100/index.rst       |   13 -
>  Documentation/arch/arm/sa1100/lart.rst        |   15 -
>  Documentation/arch/arm/sa1100/serial_uart.rst |   51 -
>  MAINTAINERS                                   |    8 -
>  arch/arm/Kconfig                              |   16 +-
>  arch/arm/Kconfig.debug                        |   13 +-
>  arch/arm/Makefile                             |    6 -
>  arch/arm/boot/bootp/Makefile                  |    1 -
>  arch/arm/boot/compressed/Makefile             |    4 -
>  arch/arm/boot/compressed/head-sa1100.S        |   45 -
>  arch/arm/boot/compressed/head.S               |    7 -
>  arch/arm/common/Kconfig                       |    7 -
>  arch/arm/common/Makefile                      |    2 -
>  arch/arm/common/locomo.c                      |  886 --------
>  arch/arm/common/sa1111.c                      | 1413 -------------
>  arch/arm/configs/assabet_defconfig            |   57 -
>  arch/arm/configs/collie_defconfig             |   87 -
>  arch/arm/configs/h3600_defconfig              |   63 -
>  arch/arm/configs/jornada720_defconfig         |   95 -
>  arch/arm/configs/neponset_defconfig           |   88 -
>  arch/arm/include/asm/cputype.h                |    4 -
>  arch/arm/include/asm/hardware/locomo.h        |  217 --
>  arch/arm/include/asm/hardware/sa1111.h        |  442 ----
>  arch/arm/include/asm/hardware/ssp.h           |   25 -
>  arch/arm/include/debug/sa1100.S               |   67 -
>  arch/arm/mach-sa1100/Kconfig                  |   92 -
>  arch/arm/mach-sa1100/Makefile                 |   20 -
>  arch/arm/mach-sa1100/assabet.c                |  770 -------
>  arch/arm/mach-sa1100/clock.c                  |  145 --
>  arch/arm/mach-sa1100/collie.c                 |  447 ----
>  arch/arm/mach-sa1100/generic.c                |  470 -----
>  arch/arm/mach-sa1100/generic.h                |   58 -
>  arch/arm/mach-sa1100/h3600.c                  |  134 --
>  arch/arm/mach-sa1100/h3xxx.c                  |  305 ---
>  arch/arm/mach-sa1100/include/mach/SA-1100.h   | 1798 -----------------
>  arch/arm/mach-sa1100/include/mach/assabet.h   |   99 -
>  arch/arm/mach-sa1100/include/mach/bitfield.h  |  113 --
>  arch/arm/mach-sa1100/include/mach/collie.h    |   94 -
>  arch/arm/mach-sa1100/include/mach/generic.h   |    1 -
>  arch/arm/mach-sa1100/include/mach/h3xxx.h     |   81 -
>  arch/arm/mach-sa1100/include/mach/hardware.h  |   56 -
>  arch/arm/mach-sa1100/include/mach/irqs.h      |  101 -
>  .../arm/mach-sa1100/include/mach/jornada720.h |   28 -
>  arch/arm/mach-sa1100/include/mach/memory.h    |   37 -
>  arch/arm/mach-sa1100/include/mach/mtd-xip.h   |   23 -
>  arch/arm/mach-sa1100/include/mach/neponset.h  |   31 -
>  arch/arm/mach-sa1100/include/mach/reset.h     |   18 -
>  .../arm/mach-sa1100/include/mach/uncompress.h |   52 -
>  arch/arm/mach-sa1100/jornada720.c             |  380 ----
>  arch/arm/mach-sa1100/jornada720_ssp.c         |  202 --
>  arch/arm/mach-sa1100/neponset.c               |  438 ----
>  arch/arm/mach-sa1100/pm.c                     |  128 --
>  arch/arm/mach-sa1100/sleep.S                  |  143 --
>  arch/arm/mach-sa1100/ssp.c                    |  240 ---
>  arch/arm/mm/init.c                            |    5 -
>  arch/arm/mm/mmu.c                             |    8 -
>  drivers/rtc/Kconfig                           |    4 +-
>  drivers/rtc/rtc-sa1100.c                      |   16 +-
>  drivers/watchdog/Kconfig                      |   12 +-
>  62 files changed, 19 insertions(+), 10501 deletions(-)
>  delete mode 100644 Documentation/arch/arm/sa1100/assabet.rst
>  delete mode 100644 Documentation/arch/arm/sa1100/cerf.rst
>  delete mode 100644 Documentation/arch/arm/sa1100/index.rst
>  delete mode 100644 Documentation/arch/arm/sa1100/lart.rst
>  delete mode 100644 Documentation/arch/arm/sa1100/serial_uart.rst
>  delete mode 100644 arch/arm/boot/compressed/head-sa1100.S
>  delete mode 100644 arch/arm/common/locomo.c
>  delete mode 100644 arch/arm/common/sa1111.c
>  delete mode 100644 arch/arm/configs/assabet_defconfig
>  delete mode 100644 arch/arm/configs/collie_defconfig
>  delete mode 100644 arch/arm/configs/h3600_defconfig
>  delete mode 100644 arch/arm/configs/jornada720_defconfig
>  delete mode 100644 arch/arm/configs/neponset_defconfig
>  delete mode 100644 arch/arm/include/asm/hardware/locomo.h
>  delete mode 100644 arch/arm/include/asm/hardware/sa1111.h
>  delete mode 100644 arch/arm/include/asm/hardware/ssp.h
>  delete mode 100644 arch/arm/include/debug/sa1100.S
>  delete mode 100644 arch/arm/mach-sa1100/Kconfig
>  delete mode 100644 arch/arm/mach-sa1100/Makefile
>  delete mode 100644 arch/arm/mach-sa1100/assabet.c
>  delete mode 100644 arch/arm/mach-sa1100/clock.c
>  delete mode 100644 arch/arm/mach-sa1100/collie.c
>  delete mode 100644 arch/arm/mach-sa1100/generic.c
>  delete mode 100644 arch/arm/mach-sa1100/generic.h
>  delete mode 100644 arch/arm/mach-sa1100/h3600.c
>  delete mode 100644 arch/arm/mach-sa1100/h3xxx.c
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/SA-1100.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/assabet.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/bitfield.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/collie.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/generic.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/h3xxx.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/hardware.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/irqs.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/jornada720.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/memory.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/mtd-xip.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/neponset.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/reset.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/uncompress.h
>  delete mode 100644 arch/arm/mach-sa1100/jornada720.c
>  delete mode 100644 arch/arm/mach-sa1100/jornada720_ssp.c
>  delete mode 100644 arch/arm/mach-sa1100/neponset.c
>  delete mode 100644 arch/arm/mach-sa1100/pm.c
>  delete mode 100644 arch/arm/mach-sa1100/sleep.S
>  delete mode 100644 arch/arm/mach-sa1100/ssp.c
> 
> diff --git a/Documentation/arch/arm/index.rst b/Documentation/arch/arm/index.rst
> index b15621093f7a..a292b8ac41ce 100644
> --- a/Documentation/arch/arm/index.rst
> +++ b/Documentation/arch/arm/index.rst
> @@ -48,9 +48,6 @@ SoC-specific documents
>  
>     pxa/mfp
>  
> -
> -   sa1100/index
> -
>     stm32/stm32f746-overview
>     stm32/overview
>     stm32/stm32h743-overview
> diff --git a/Documentation/arch/arm/sa1100/assabet.rst b/Documentation/arch/arm/sa1100/assabet.rst
> deleted file mode 100644
> index a761e128fb08..000000000000
> --- a/Documentation/arch/arm/sa1100/assabet.rst
> +++ /dev/null
> @@ -1,301 +0,0 @@
> -============================================
> -The Intel Assabet (SA-1110 evaluation) board
> -============================================
> -
> -Please see:
> -http://developer.intel.com
> -
> -Also some notes from John G Dorsey <jd5q@andrew.cmu.edu>:
> -http://www.cs.cmu.edu/~wearable/software/assabet.html
> -
> -
> -Building the kernel
> --------------------
> -
> -To build the kernel with current defaults::
> -
> -	make assabet_defconfig
> -	make oldconfig
> -	make zImage
> -
> -The resulting kernel image should be available in linux/arch/arm/boot/zImage.
> -
> -
> -Installing a bootloader
> ------------------------
> -
> -A couple of bootloaders able to boot Linux on Assabet are available:
> -
> -BLOB (http://www.lartmaker.nl/lartware/blob/)
> -
> -   BLOB is a bootloader used within the LART project.  Some contributed
> -   patches were merged into BLOB to add support for Assabet.
> -
> -Compaq's Bootldr + John Dorsey's patch for Assabet support
> -(http://www.handhelds.org/Compaq/bootldr.html)
> -(http://www.wearablegroup.org/software/bootldr/)
> -
> -   Bootldr is the bootloader developed by Compaq for the iPAQ Pocket PC.
> -   John Dorsey has produced add-on patches to add support for Assabet and
> -   the JFFS filesystem.
> -
> -RedBoot (http://sources.redhat.com/redboot/)
> -
> -   RedBoot is a bootloader developed by Red Hat based on the eCos RTOS
> -   hardware abstraction layer.  It supports Assabet amongst many other
> -   hardware platforms.
> -
> -RedBoot is currently the recommended choice since it's the only one to have
> -networking support, and is the most actively maintained.
> -
> -Brief examples on how to boot Linux with RedBoot are shown below.  But first
> -you need to have RedBoot installed in your flash memory.  A known to work
> -precompiled RedBoot binary is available from the following location:
> -
> -- ftp://ftp.netwinder.org/users/n/nico/
> -- ftp://ftp.arm.linux.org.uk/pub/linux/arm/people/nico/
> -- ftp://ftp.handhelds.org/pub/linux/arm/sa-1100-patches/
> -
> -Look for redboot-assabet*.tgz.  Some installation infos are provided in
> -redboot-assabet*.txt.
> -
> -
> -Initial RedBoot configuration
> ------------------------------
> -
> -The commands used here are explained in The RedBoot User's Guide available
> -on-line at http://sources.redhat.com/ecos/docs.html.
> -Please refer to it for explanations.
> -
> -If you have a CF network card (my Assabet kit contained a CF+ LP-E from
> -Socket Communications Inc.), you should strongly consider using it for TFTP
> -file transfers.  You must insert it before RedBoot runs since it can't detect
> -it dynamically.
> -
> -To initialize the flash directory::
> -
> -	fis init -f
> -
> -To initialize the non-volatile settings, like whether you want to use BOOTP or
> -a static IP address, etc, use this command::
> -
> -	fconfig -i
> -
> -
> -Writing a kernel image into flash
> ----------------------------------
> -
> -First, the kernel image must be loaded into RAM.  If you have the zImage file
> -available on a TFTP server::
> -
> -	load zImage -r -b 0x100000
> -
> -If you rather want to use Y-Modem upload over the serial port::
> -
> -	load -m ymodem -r -b 0x100000
> -
> -To write it to flash::
> -
> -	fis create "Linux kernel" -b 0x100000 -l 0xc0000
> -
> -
> -Booting the kernel
> -------------------
> -
> -The kernel still requires a filesystem to boot.  A ramdisk image can be loaded
> -as follows::
> -
> -	load ramdisk_image.gz -r -b 0x800000
> -
> -Again, Y-Modem upload can be used instead of TFTP by replacing the file name
> -by '-y ymodem'.
> -
> -Now the kernel can be retrieved from flash like this::
> -
> -	fis load "Linux kernel"
> -
> -or loaded as described previously.  To boot the kernel::
> -
> -	exec -b 0x100000 -l 0xc0000
> -
> -The ramdisk image could be stored into flash as well, but there are better
> -solutions for on-flash filesystems as mentioned below.
> -
> -
> -Using JFFS2
> ------------
> -
> -Using JFFS2 (the Second Journalling Flash File System) is probably the most
> -convenient way to store a writable filesystem into flash.  JFFS2 is used in
> -conjunction with the MTD layer which is responsible for low-level flash
> -management.  More information on the Linux MTD can be found on-line at:
> -http://www.linux-mtd.infradead.org/.  A JFFS howto with some infos about
> -creating JFFS/JFFS2 images is available from the same site.
> -
> -For instance, a sample JFFS2 image can be retrieved from the same FTP sites
> -mentioned below for the precompiled RedBoot image.
> -
> -To load this file::
> -
> -	load sample_img.jffs2 -r -b 0x100000
> -
> -The result should look like::
> -
> -	RedBoot> load sample_img.jffs2 -r -b 0x100000
> -	Raw file loaded 0x00100000-0x00377424
> -
> -Now we must know the size of the unallocated flash::
> -
> -	fis free
> -
> -Result::
> -
> -	RedBoot> fis free
> -	  0x500E0000 .. 0x503C0000
> -
> -The values above may be different depending on the size of the filesystem and
> -the type of flash.  See their usage below as an example and take care of
> -substituting yours appropriately.
> -
> -We must determine some values::
> -
> -	size of unallocated flash:	0x503c0000 - 0x500e0000 = 0x2e0000
> -	size of the filesystem image:	0x00377424 - 0x00100000 = 0x277424
> -
> -We want to fit the filesystem image of course, but we also want to give it all
> -the remaining flash space as well.  To write it::
> -
> -	fis unlock -f 0x500E0000 -l 0x2e0000
> -	fis erase -f 0x500E0000 -l 0x2e0000
> -	fis write -b 0x100000 -l 0x277424 -f 0x500E0000
> -	fis create "JFFS2" -n -f 0x500E0000 -l 0x2e0000
> -
> -Now the filesystem is associated to a MTD "partition" once Linux has discovered
> -what they are in the boot process.  From Redboot, the 'fis list' command
> -displays them::
> -
> -	RedBoot> fis list
> -	Name              FLASH addr  Mem addr    Length      Entry point
> -	RedBoot           0x50000000  0x50000000  0x00020000  0x00000000
> -	RedBoot config    0x503C0000  0x503C0000  0x00020000  0x00000000
> -	FIS directory     0x503E0000  0x503E0000  0x00020000  0x00000000
> -	Linux kernel      0x50020000  0x00100000  0x000C0000  0x00000000
> -	JFFS2             0x500E0000  0x500E0000  0x002E0000  0x00000000
> -
> -However Linux should display something like::
> -
> -	SA1100 flash: probing 32-bit flash bus
> -	SA1100 flash: Found 2 x16 devices at 0x0 in 32-bit mode
> -	Using RedBoot partition definition
> -	Creating 5 MTD partitions on "SA1100 flash":
> -	0x00000000-0x00020000 : "RedBoot"
> -	0x00020000-0x000e0000 : "Linux kernel"
> -	0x000e0000-0x003c0000 : "JFFS2"
> -	0x003c0000-0x003e0000 : "RedBoot config"
> -	0x003e0000-0x00400000 : "FIS directory"
> -
> -What's important here is the position of the partition we are interested in,
> -which is the third one.  Within Linux, this correspond to /dev/mtdblock2.
> -Therefore to boot Linux with the kernel and its root filesystem in flash, we
> -need this RedBoot command::
> -
> -	fis load "Linux kernel"
> -	exec -b 0x100000 -l 0xc0000 -c "root=/dev/mtdblock2"
> -
> -Of course other filesystems than JFFS might be used, like cramfs for example.
> -You might want to boot with a root filesystem over NFS, etc.  It is also
> -possible, and sometimes more convenient, to flash a filesystem directly from
> -within Linux while booted from a ramdisk or NFS.  The Linux MTD repository has
> -many tools to deal with flash memory as well, to erase it for example.  JFFS2
> -can then be mounted directly on a freshly erased partition and files can be
> -copied over directly.  Etc...
> -
> -
> -RedBoot scripting
> ------------------
> -
> -All the commands above aren't so useful if they have to be typed in every
> -time the Assabet is rebooted.  Therefore it's possible to automate the boot
> -process using RedBoot's scripting capability.
> -
> -For example, I use this to boot Linux with both the kernel and the ramdisk
> -images retrieved from a TFTP server on the network::
> -
> -	RedBoot> fconfig
> -	Run script at boot: false true
> -	Boot script:
> -	Enter script, terminate with empty line
> -	>> load zImage -r -b 0x100000
> -	>> load ramdisk_ks.gz -r -b 0x800000
> -	>> exec -b 0x100000 -l 0xc0000
> -	>>
> -	Boot script timeout (1000ms resolution): 3
> -	Use BOOTP for network configuration: true
> -	GDB connection port: 9000
> -	Network debug at boot time: false
> -	Update RedBoot non-volatile configuration - are you sure (y/n)? y
> -
> -Then, rebooting the Assabet is just a matter of waiting for the login prompt.
> -
> -
> -
> -Nicolas Pitre
> -nico@fluxnic.net
> -
> -June 12, 2001
> -
> -
> -Status of peripherals in -rmk tree (updated 14/10/2001)
> --------------------------------------------------------
> -
> -Assabet:
> - Serial ports:
> -  Radio:		TX, RX, CTS, DSR, DCD, RI
> -   - PM:		Not tested.
> -   - COM:		TX, RX, CTS, DSR, DCD, RTS, DTR, PM
> -   - PM:		Not tested.
> -   - I2C:		Implemented, not fully tested.
> -   - L3:		Fully tested, pass.
> -   - PM:		Not tested.
> -
> - Video:
> -  - LCD:		Fully tested.  PM
> -
> -   (LCD doesn't like being blanked with neponset connected)
> -
> -  - Video out:		Not fully
> -
> - Audio:
> -  UDA1341:
> -  -  Playback:		Fully tested, pass.
> -  -  Record:		Implemented, not tested.
> -  -  PM:			Not tested.
> -
> -  UCB1200:
> -  -  Audio play:	Implemented, not heavily tested.
> -  -  Audio rec:		Implemented, not heavily tested.
> -  -  Telco audio play:	Implemented, not heavily tested.
> -  -  Telco audio rec:	Implemented, not heavily tested.
> -  -  POTS control:	No
> -  -  Touchscreen:	Yes
> -  -  PM:		Not tested.
> -
> - Other:
> -  - PCMCIA:
> -  - LPE:		Fully tested, pass.
> -  - USB:		No
> -  - IRDA:
> -  - SIR:		Fully tested, pass.
> -  - FIR:		Fully tested, pass.
> -  - PM:			Not tested.
> -
> -Neponset:
> - Serial ports:
> -  - COM1,2:		TX, RX, CTS, DSR, DCD, RTS, DTR
> -  - PM:			Not tested.
> -  - USB:		Implemented, not heavily tested.
> -  - PCMCIA:		Implemented, not heavily tested.
> -  - CF:			Implemented, not heavily tested.
> -  - PM:			Not tested.
> -
> -More stuff can be found in the -np (Nicolas Pitre's) tree.
> diff --git a/Documentation/arch/arm/sa1100/cerf.rst b/Documentation/arch/arm/sa1100/cerf.rst
> deleted file mode 100644
> index 7fa71b609bf9..000000000000
> --- a/Documentation/arch/arm/sa1100/cerf.rst
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -==============
> -CerfBoard/Cube
> -==============
> -
> -*** The StrongARM version of the CerfBoard/Cube has been discontinued ***
> -
> -The Intrinsyc CerfBoard is a StrongARM 1110-based computer on a board
> -that measures approximately 2" square. It includes an Ethernet
> -controller, an RS232-compatible serial port, a USB function port, and
> -one CompactFlash+ slot on the back. Pictures can be found at the
> -Intrinsyc website, http://www.intrinsyc.com.
> -
> -This document describes the support in the Linux kernel for the
> -Intrinsyc CerfBoard.
> -
> -Supported in this version
> -=========================
> -
> -   - CompactFlash+ slot (select PCMCIA in General Setup and any options
> -     that may be required)
> -   - Onboard Crystal CS8900 Ethernet controller (Cerf CS8900A support in
> -     Network Devices)
> -   - Serial ports with a serial console (hardcoded to 38400 8N1)
> -
> -In order to get this kernel onto your Cerf, you need a server that runs
> -both BOOTP and TFTP. Detailed instructions should have come with your
> -evaluation kit on how to use the bootloader. This series of commands
> -will suffice::
> -
> -   make ARCH=arm CROSS_COMPILE=arm-linux- cerfcube_defconfig
> -   make ARCH=arm CROSS_COMPILE=arm-linux- zImage
> -   make ARCH=arm CROSS_COMPILE=arm-linux- modules
> -   cp arch/arm/boot/zImage <TFTP directory>
> -
> -support@intrinsyc.com
> diff --git a/Documentation/arch/arm/sa1100/index.rst b/Documentation/arch/arm/sa1100/index.rst
> deleted file mode 100644
> index c9aed43280ff..000000000000
> --- a/Documentation/arch/arm/sa1100/index.rst
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -====================
> -Intel StrongARM 1100
> -====================
> -
> -.. toctree::
> -    :maxdepth: 1
> -
> -    assabet
> -    cerf
> -    lart
> -    serial_uart
> diff --git a/Documentation/arch/arm/sa1100/lart.rst b/Documentation/arch/arm/sa1100/lart.rst
> deleted file mode 100644
> index 94c0568d1095..000000000000
> --- a/Documentation/arch/arm/sa1100/lart.rst
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -====================================
> -Linux Advanced Radio Terminal (LART)
> -====================================
> -
> -The LART is a small (7.5 x 10cm) SA-1100 board, designed for embedded
> -applications. It has 32 MB DRAM, 4MB Flash ROM, double RS232 and all
> -other StrongARM-gadgets. Almost all SA signals are directly accessible
> -through a number of connectors. The powersupply accepts voltages
> -between 3.5V and 16V and is overdimensioned to support a range of
> -daughterboards. A quad Ethernet / IDE / PS2 / sound daughterboard
> -is under development, with plenty of others in different stages of
> -planning.
> -
> -The hardware designs for this board have been released under an open license;
> -see the LART page at http://www.lartmaker.nl/ for more information.
> diff --git a/Documentation/arch/arm/sa1100/serial_uart.rst b/Documentation/arch/arm/sa1100/serial_uart.rst
> deleted file mode 100644
> index ea983642b9be..000000000000
> --- a/Documentation/arch/arm/sa1100/serial_uart.rst
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -==================
> -SA1100 serial port
> -==================
> -
> -The SA1100 serial port had its major/minor numbers officially assigned::
> -
> -  > Date: Sun, 24 Sep 2000 21:40:27 -0700
> -  > From: H. Peter Anvin <hpa@transmeta.com>
> -  > To: Nicolas Pitre <nico@CAM.ORG>
> -  > Cc: Device List Maintainer <device@lanana.org>
> -  > Subject: Re: device
> -  >
> -  > Okay.  Note that device numbers 204 and 205 are used for "low density
> -  > serial devices", so you will have a range of minors on those majors (the
> -  > tty device layer handles this just fine, so you don't have to worry about
> -  > doing anything special.)
> -  >
> -  > So your assignments are:
> -  >
> -  > 204 char        Low-density serial ports
> -  >                   5 = /dev/ttySA0               SA1100 builtin serial port 0
> -  >                   6 = /dev/ttySA1               SA1100 builtin serial port 1
> -  >                   7 = /dev/ttySA2               SA1100 builtin serial port 2
> -  >
> -  > 205 char        Low-density serial ports (alternate device)
> -  >                   5 = /dev/cusa0                Callout device for ttySA0
> -  >                   6 = /dev/cusa1                Callout device for ttySA1
> -  >                   7 = /dev/cusa2                Callout device for ttySA2
> -  >
> -
> -You must create those inodes in /dev on the root filesystem used
> -by your SA1100-based device::
> -
> -	mknod ttySA0 c 204 5
> -	mknod ttySA1 c 204 6
> -	mknod ttySA2 c 204 7
> -	mknod cusa0 c 205 5
> -	mknod cusa1 c 205 6
> -	mknod cusa2 c 205 7
> -
> -In addition to the creation of the appropriate device nodes above, you
> -must ensure your user space applications make use of the correct device
> -name. The classic example is the content of the /etc/inittab file where
> -you might have a getty process started on ttyS0.
> -
> -In this case:
> -
> -- replace occurrences of ttyS0 with ttySA0, ttyS1 with ttySA1, etc.
> -
> -- don't forget to add 'ttySA0', 'console', or the appropriate tty name
> -  in /etc/securetty for root to be allowed to login as well.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6215fcb07770..fd213c4bc257 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2977,14 +2977,6 @@ F:	arch/arm/boot/dts/hisilicon/
>  F:	arch/arm/mach-hisi/
>  F:	arch/arm64/boot/dts/hisilicon/
>  
> -ARM/HP JORNADA 7XX MACHINE SUPPORT
> -M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
> -S:	Maintained
> -W:	www.jlime.com
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kristoffer/linux-hpc.git
> -F:	arch/arm/mach-sa1100/include/mach/jornada720.h
> -F:	arch/arm/mach-sa1100/jornada720.c
> -
>  ARM/HPE GXP ARCHITECTURE
>  M:	Jean-Marie Verdun <verdun@hpe.com>
>  M:	Nick Hawkins <nick.hawkins@hpe.com>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ffbc7f386131..7f4c2973d630 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -161,7 +161,7 @@ config ARM
>  	select TIMER_OF if OF
>  	select HAVE_ARCH_VMAP_STACK if MMU && ARM_HAS_GROUP_RELOCS
>  	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
> -	select USE_OF if !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
> +	select USE_OF if !(ARCH_FOOTBRIDGE || ARCH_RPC)
>  	# Above selects are sorted alphabetically; please add new ones
>  	# according to that.  Thanks.
>  	help
> @@ -261,9 +261,6 @@ config GENERIC_ISA_DMA
>  config FIQ
>  	bool
>  
> -config ARCH_MTD_XIP
> -	bool
> -
>  config ARM_PATCH_PHYS_VIRT
>  	bool "Patch physical to virtual translations at runtime" if !ARCH_MULTIPLATFORM
>  	default y
> @@ -301,7 +298,7 @@ config PHYS_OFFSET
>  	default 0x00000000 if ARCH_FOOTBRIDGE
>  	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
>  	default 0xa0000000 if ARCH_PXA
> -	default 0xc0000000 if ARCH_EP93XX || ARCH_SA1100
> +	default 0xc0000000 if ARCH_EP93XX
>  	default 0
>  	help
>  	  Please provide the physical address corresponding to the
> @@ -341,7 +338,7 @@ config ARCH_MMAP_RND_BITS_MAX
>  
>  config ARCH_MULTIPLATFORM
>  	bool "Require kernel to be portable to multiple machines" if EXPERT
> -	depends on MMU && !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
> +	depends on MMU && !(ARCH_FOOTBRIDGE || ARCH_RPC)
>  	default y
>  	help
>  	  In general, all Arm machines can be supported in a single
> @@ -445,8 +442,6 @@ source "arch/arm/mach-s3c/Kconfig"
>  
>  source "arch/arm/mach-s5pv210/Kconfig"
>  
> -source "arch/arm/mach-sa1100/Kconfig"
> -
>  source "arch/arm/mach-shmobile/Kconfig"
>  
>  source "arch/arm/mach-socfpga/Kconfig"
> @@ -1201,7 +1196,7 @@ config ARCH_SELECT_MEMORY_MODEL
>  	def_bool y
>  
>  config ARCH_FLATMEM_ENABLE
> -	def_bool !(ARCH_RPC || ARCH_SA1100)
> +	def_bool !ARCH_RPC
>  
>  config ARCH_SPARSEMEM_ENABLE
>  	def_bool !ARCH_FOOTBRIDGE
> @@ -1293,7 +1288,6 @@ config ARM_MODULE_PLTS
>  config ARCH_FORCE_MAX_ORDER
>  	int "Order of maximal physically contiguous allocations"
>  	default "11" if SOC_AM33XX
> -	default "8" if SA1111
>  	default "10"
>  	help
>  	  The kernel page allocator limits the size of maximal physically
> @@ -1605,7 +1599,7 @@ config ARCH_DEFAULT_CRASH_DUMP
>  
>  config AUTO_ZRELADDR
>  	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
> -	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
> +	default !(ARCH_FOOTBRIDGE || ARCH_RPC)
>  	help
>  	  ZRELADDR is the physical address where the decompressed kernel
>  	  image will be placed. If AUTO_ZRELADDR is selected, the address
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 366f162e147d..ad0feced4369 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1048,14 +1048,6 @@ choice
>  		  their output to UART 3. The port must have been initialised
>  		  by the boot-loader before use.
>  
> -	config DEBUG_SA1100
> -		depends on ARCH_SA1100
> -		bool "Use SA1100 UARTs for low-level debug"
> -		help
> -		  Say Y here if you want kernel low-level debugging support
> -		  on SA-11x0 UART ports. The kernel will check for the first
> -		  enabled UART in a sequence 3-1-2.
> -
>  	config DEBUG_SD5203_UART
>  		bool "Hisilicon SD5203 Debug UART"
>  		depends on ARCH_SD5203
> @@ -1479,7 +1471,6 @@ config DEBUG_UART_FLOW_CONTROL
>  
>  config DEBUG_LL_INCLUDE
>  	string
> -	default "debug/sa1100.S" if DEBUG_SA1100
>  	default "debug/palmchip.S" if DEBUG_UART_8250_PALMCHIP
>  	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
>  	default "debug/at91.S" if DEBUG_AT91_UART
> @@ -1807,7 +1798,7 @@ config DEBUG_UART_8250_PALMCHIP
>  config DEBUG_UNCOMPRESS
>  	bool "Enable decompressor debugging via DEBUG_LL output"
>  	depends on !ARCH_MULTIPLATFORM
> -	depends on !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
> +	depends on !(ARCH_FOOTBRIDGE || ARCH_RPC)
>  	depends on DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
>  		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
>  		     !DEBUG_BRCMSTB_UART && !DEBUG_SEMIHOSTING
> @@ -1817,7 +1808,7 @@ config DEBUG_UNCOMPRESS
>  
>  config UNCOMPRESS_INCLUDE
>  	string
> -	default "mach/uncompress.h" if ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100
> +	default "mach/uncompress.h" if ARCH_FOOTBRIDGE || ARCH_RPC
>  	default "debug/uncompress.h"
>  
>  config EARLY_PRINTK
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 573813ef5e77..ea3da21202c8 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -162,10 +162,6 @@ CHECKFLAGS	+= -D__arm__
>  textofs-y	:= 0x00008000
>  # RTD1195 has Boot ROM at start of address space
>  textofs-$(CONFIG_ARCH_REALTEK)  := 0x00108000
> -# SA1111 DMA bug: we don't want the kernel to live in precious DMA-able memory
> -ifeq ($(CONFIG_ARCH_SA1100),y)
> -textofs-$(CONFIG_SA1111) := 0x00208000
> -endif
>  textofs-$(CONFIG_ARCH_QCOM_RESERVE_SMEM) := 0x00208000
>  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
>  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
> @@ -214,7 +210,6 @@ machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
>  machine-$(CONFIG_ARCH_RPC)		+= rpc
>  machine-$(CONFIG_PLAT_SAMSUNG)		+= s3c
>  machine-$(CONFIG_ARCH_S5PV210)		+= s5pv210
> -machine-$(CONFIG_ARCH_SA1100)		+= sa1100
>  machine-$(CONFIG_ARCH_RENESAS)	 	+= shmobile
>  machine-$(CONFIG_ARCH_INTEL_SOCFPGA)	+= socfpga
>  machine-$(CONFIG_ARCH_STI)		+= sti
> @@ -232,7 +227,6 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
>  # these three are mutually exclusive
>  machdirs-$(CONFIG_ARCH_FOOTBRIDGE)	+= arch/arm/mach-footbridge
>  machdirs-$(CONFIG_ARCH_RPC)		+= arch/arm/mach-rpc
> -machdirs-$(CONFIG_ARCH_SA1100)		+= arch/arm/mach-sa1100
>  KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%/include,$(machdirs-y))
>  
>  # The byte offset of the kernel image in RAM from the start of RAM.
> diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
> index f3443f7d7b02..a1a1f4bec783 100644
> --- a/arch/arm/boot/bootp/Makefile
> +++ b/arch/arm/boot/bootp/Makefile
> @@ -20,7 +20,6 @@ PARAMS_PHYS := $(call add_hex, $(PHYS_OFFSET), 0x100)
>  
>  # guess an initrd location if possible
>  initrd_offset-$(CONFIG_ARCH_FOOTBRIDGE)	+= 0x00800000
> -initrd_offset-$(CONFIG_ARCH_SA1100)	+= 0x00800000
>  initrd_offset-$(CONFIG_ARCH_RPC)	+= 0x08000000
>  INITRD_OFFSET := $(initrd_offset-y)
>  ifdef INITRD_OFFSET
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index e3f550d62857..d8d81ba741a2 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -29,10 +29,6 @@ ifeq ($(CONFIG_ARCH_ACORN),y)
>  OBJS		+= ll_char_wr.o font.o
>  endif
>  
> -ifeq ($(CONFIG_ARCH_SA1100),y)
> -OBJS		+= head-sa1100.o
> -endif
> -
>  ifeq ($(CONFIG_CPU_XSCALE),y)
>  OBJS		+= head-xscale.o
>  endif
> diff --git a/arch/arm/boot/compressed/head-sa1100.S b/arch/arm/boot/compressed/head-sa1100.S
> deleted file mode 100644
> index 23eae1a65064..000000000000
> --- a/arch/arm/boot/compressed/head-sa1100.S
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* 
> - * linux/arch/arm/boot/compressed/head-sa1100.S
> - * 
> - * Copyright (C) 1999 Nicolas Pitre <nico@fluxnic.net>
> - * 
> - * SA1100 specific tweaks.  This is merged into head.S by the linker.
> - *
> - */
> -
> -#include <linux/linkage.h>
> -#include <asm/mach-types.h>
> -
> -		.section        ".start", "ax"
> -		.arch	armv4
> -
> -__SA1100_start:
> -
> -		@ Preserve r8/r7 i.e. kernel entry values
> -#ifdef CONFIG_SA1100_COLLIE
> -		mov	r7, #MACH_TYPE_COLLIE
> -#endif
> -		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
> -		ands	r0, r0, #0x0d
> -		beq	99f
> -
> -		@ Data cache might be active.
> -		@ Be sure to flush kernel binary out of the cache,
> -		@ whatever state it is, before it is turned off.
> -		@ This is done by fetching through currently executed
> -		@ memory to be sure we hit the same cache.
> -		bic	r2, pc, #0x1f
> -		add	r3, r2, #0x4000		@ 16 kb is quite enough...
> -1:		ldr	r0, [r2], #32
> -		teq	r2, r3
> -		bne	1b
> -		mcr	p15, 0, r0, c7, c10, 4	@ drain WB
> -		mcr	p15, 0, r0, c7, c7, 0	@ flush I & D caches
> -
> -		@ disabling MMU and caches
> -		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
> -		bic	r0, r0, #0x0d		@ clear WB, DC, MMU
> -		bic	r0, r0, #0x1000		@ clear Icache
> -		mcr	p15, 0, r0, c1, c0, 0
> -99:
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 9f406e9c0ea6..845abffbc2d6 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -64,17 +64,10 @@
>  		busyuart \tmp, \rb
>  		.endm
>  
> -#if defined(CONFIG_ARCH_SA1100)
> -		.macro	loadsp, rb, tmp1, tmp2
> -		mov	\rb, #0x80000000	@ physical base address
> -		add	\rb, \rb, #0x00010000	@ Ser1
> -		.endm
> -#else
>  		.macro	loadsp,	rb, tmp1, tmp2
>  		addruart \rb, \tmp1, \tmp2
>  		.endm
>  #endif
> -#endif
>  #endif
>  
>  		.macro	kputc,val
> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index d2fdb1796f48..d72dccf6f3c2 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -1,14 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> -config SA1111
> -	bool
> -	select ZONE_DMA if ARCH_SA1100
> -
>  config KRAIT_L2_ACCESSORS
>  	bool
>  
> -config SHARP_LOCOMO
> -	bool
> -
>  config SHARP_PARAM
>  	bool
>  
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index 9733381074e0..e1bcc250874f 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -5,9 +5,7 @@
>  
>  obj-y				+= firmware.o
>  
> -obj-$(CONFIG_SA1111)		+= sa1111.o
>  obj-$(CONFIG_KRAIT_L2_ACCESSORS) += krait-l2-accessors.o
> -obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
>  obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
>  obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
>  obj-$(CONFIG_CPU_V7)		+= secure_cntvoff.o
> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> deleted file mode 100644
> index 55e360452828..000000000000
> --- a/arch/arm/common/locomo.c
> +++ /dev/null
> @@ -1,886 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * linux/arch/arm/common/locomo.c
> - *
> - * Sharp LoCoMo support
> - *
> - * This file contains all generic LoCoMo support.
> - *
> - * All initialization functions provided here are intended to be called
> - * from machine specific code with proper arguments when required.
> - *
> - * Based on sa1111.c
> - */
> -
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/delay.h>
> -#include <linux/errno.h>
> -#include <linux/ioport.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -#include <linux/spinlock.h>
> -#include <linux/io.h>
> -
> -#include <asm/irq.h>
> -#include <asm/mach/irq.h>
> -
> -#include <asm/hardware/locomo.h>
> -
> -/* LoCoMo Interrupts */
> -#define IRQ_LOCOMO_KEY		(0)
> -#define IRQ_LOCOMO_GPIO		(1)
> -#define IRQ_LOCOMO_LT		(2)
> -#define IRQ_LOCOMO_SPI		(3)
> -
> -/* M62332 output channel selection */
> -#define M62332_EVR_CH	1	/* M62332 volume channel number  */
> -				/*   0 : CH.1 , 1 : CH. 2        */
> -/* DAC send data */
> -#define	M62332_SLAVE_ADDR	0x4e	/* Slave address  */
> -#define	M62332_W_BIT		0x00	/* W bit (0 only) */
> -#define	M62332_SUB_ADDR		0x00	/* Sub address    */
> -#define	M62332_A_BIT		0x00	/* A bit (0 only) */
> -
> -/* DAC setup and hold times (expressed in us) */
> -#define DAC_BUS_FREE_TIME	5	/*   4.7 us */
> -#define DAC_START_SETUP_TIME	5	/*   4.7 us */
> -#define DAC_STOP_SETUP_TIME	4	/*   4.0 us */
> -#define DAC_START_HOLD_TIME	5	/*   4.7 us */
> -#define DAC_SCL_LOW_HOLD_TIME	5	/*   4.7 us */
> -#define DAC_SCL_HIGH_HOLD_TIME	4	/*   4.0 us */
> -#define DAC_DATA_SETUP_TIME	1	/*   250 ns */
> -#define DAC_DATA_HOLD_TIME	1	/*   300 ns */
> -#define DAC_LOW_SETUP_TIME	1	/*   300 ns */
> -#define DAC_HIGH_SETUP_TIME	1	/*  1000 ns */
> -
> -/* the following is the overall data for the locomo chip */
> -struct locomo {
> -	struct device *dev;
> -	unsigned long phys;
> -	unsigned int irq;
> -	int irq_base;
> -	spinlock_t lock;
> -	void __iomem *base;
> -#ifdef CONFIG_PM
> -	void *saved_state;
> -#endif
> -};
> -
> -static const struct bus_type locomo_bus_type;
> -
> -struct locomo_dev_info {
> -	unsigned long	offset;
> -	unsigned long	length;
> -	unsigned int	devid;
> -	unsigned int	irq[1];
> -	const char *	name;
> -};
> -
> -/* All the locomo devices.  If offset is non-zero, the mapbase for the
> - * locomo_dev will be set to the chip base plus offset.  If offset is
> - * zero, then the mapbase for the locomo_dev will be set to zero.  An
> - * offset of zero means the device only uses GPIOs or other helper
> - * functions inside this file */
> -static struct locomo_dev_info locomo_devices[] = {
> -	{
> -		.devid 		= LOCOMO_DEVID_KEYBOARD,
> -		.irq		= { IRQ_LOCOMO_KEY },
> -		.name		= "locomo-keyboard",
> -		.offset		= LOCOMO_KEYBOARD,
> -		.length		= 16,
> -	},
> -	{
> -		.devid		= LOCOMO_DEVID_FRONTLIGHT,
> -		.irq		= {},
> -		.name		= "locomo-frontlight",
> -		.offset		= LOCOMO_FRONTLIGHT,
> -		.length		= 8,
> -
> -	},
> -	{
> -		.devid		= LOCOMO_DEVID_BACKLIGHT,
> -		.irq		= {},
> -		.name		= "locomo-backlight",
> -		.offset		= LOCOMO_BACKLIGHT,
> -		.length		= 8,
> -	},
> -	{
> -		.devid		= LOCOMO_DEVID_AUDIO,
> -		.irq		= {},
> -		.name		= "locomo-audio",
> -		.offset		= LOCOMO_AUDIO,
> -		.length		= 4,
> -	},
> -	{
> -		.devid		= LOCOMO_DEVID_LED,
> -		.irq 		= {},
> -		.name		= "locomo-led",
> -		.offset		= LOCOMO_LED,
> -		.length		= 8,
> -	},
> -	{
> -		.devid		= LOCOMO_DEVID_UART,
> -		.irq		= {},
> -		.name		= "locomo-uart",
> -		.offset		= 0,
> -		.length		= 0,
> -	},
> -	{
> -		.devid		= LOCOMO_DEVID_SPI,
> -		.irq		= {},
> -		.name		= "locomo-spi",
> -		.offset		= LOCOMO_SPI,
> -		.length		= 0x30,
> -	},
> -};
> -
> -static void locomo_handler(struct irq_desc *desc)
> -{
> -	struct locomo *lchip = irq_desc_get_handler_data(desc);
> -	int req, i;
> -
> -	/* Acknowledge the parent IRQ */
> -	desc->irq_data.chip->irq_ack(&desc->irq_data);
> -
> -	/* check why this interrupt was generated */
> -	req = locomo_readl(lchip->base + LOCOMO_ICR) & 0x0f00;
> -
> -	if (req) {
> -		unsigned int irq;
> -
> -		/* generate the next interrupt(s) */
> -		irq = lchip->irq_base;
> -		for (i = 0; i <= 3; i++, irq++) {
> -			if (req & (0x0100 << i)) {
> -				generic_handle_irq(irq);
> -			}
> -
> -		}
> -	}
> -}
> -
> -static void locomo_ack_irq(struct irq_data *d)
> -{
> -}
> -
> -static void locomo_mask_irq(struct irq_data *d)
> -{
> -	struct locomo *lchip = irq_data_get_irq_chip_data(d);
> -	unsigned int r;
> -	r = locomo_readl(lchip->base + LOCOMO_ICR);
> -	r &= ~(0x0010 << (d->irq - lchip->irq_base));
> -	locomo_writel(r, lchip->base + LOCOMO_ICR);
> -}
> -
> -static void locomo_unmask_irq(struct irq_data *d)
> -{
> -	struct locomo *lchip = irq_data_get_irq_chip_data(d);
> -	unsigned int r;
> -	r = locomo_readl(lchip->base + LOCOMO_ICR);
> -	r |= (0x0010 << (d->irq - lchip->irq_base));
> -	locomo_writel(r, lchip->base + LOCOMO_ICR);
> -}
> -
> -static struct irq_chip locomo_chip = {
> -	.name		= "LOCOMO",
> -	.irq_ack	= locomo_ack_irq,
> -	.irq_mask	= locomo_mask_irq,
> -	.irq_unmask	= locomo_unmask_irq,
> -};
> -
> -static void locomo_setup_irq(struct locomo *lchip)
> -{
> -	int irq = lchip->irq_base;
> -
> -	/*
> -	 * Install handler for IRQ_LOCOMO_HW.
> -	 */
> -	irq_set_irq_type(lchip->irq, IRQ_TYPE_EDGE_FALLING);
> -	irq_set_chained_handler_and_data(lchip->irq, locomo_handler, lchip);
> -
> -	/* Install handlers for IRQ_LOCOMO_* */
> -	for ( ; irq <= lchip->irq_base + 3; irq++) {
> -		irq_set_chip_and_handler(irq, &locomo_chip, handle_level_irq);
> -		irq_set_chip_data(irq, lchip);
> -		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
> -	}
> -}
> -
> -
> -static void locomo_dev_release(struct device *_dev)
> -{
> -	struct locomo_dev *dev = LOCOMO_DEV(_dev);
> -
> -	kfree(dev);
> -}
> -
> -static int
> -locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
> -{
> -	struct locomo_dev *dev;
> -	int ret;
> -
> -	dev = kzalloc_obj(struct locomo_dev);
> -	if (!dev) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	/*
> -	 * If the parent device has a DMA mask associated with it,
> -	 * propagate it down to the children.
> -	 */
> -	if (lchip->dev->dma_mask) {
> -		dev->dma_mask = *lchip->dev->dma_mask;
> -		dev->dev.dma_mask = &dev->dma_mask;
> -	}
> -
> -	dev_set_name(&dev->dev, "%s", info->name);
> -	dev->devid	 = info->devid;
> -	dev->dev.parent  = lchip->dev;
> -	dev->dev.bus     = &locomo_bus_type;
> -	dev->dev.release = locomo_dev_release;
> -	dev->dev.coherent_dma_mask = lchip->dev->coherent_dma_mask;
> -
> -	if (info->offset)
> -		dev->mapbase = lchip->base + info->offset;
> -	else
> -		dev->mapbase = 0;
> -	dev->length = info->length;
> -
> -	dev->irq[0] = (lchip->irq_base == NO_IRQ) ?
> -			NO_IRQ : lchip->irq_base + info->irq[0];
> -
> -	ret = device_register(&dev->dev);
> -	if (ret) {
> - out:
> -		kfree(dev);
> -	}
> -	return ret;
> -}
> -
> -#ifdef CONFIG_PM
> -
> -struct locomo_save_data {
> -	u16	LCM_GPO;
> -	u16	LCM_SPICT;
> -	u16	LCM_GPE;
> -	u16	LCM_ASD;
> -	u16	LCM_SPIMD;
> -};
> -
> -static int locomo_suspend(struct platform_device *dev, pm_message_t state)
> -{
> -	struct locomo *lchip = platform_get_drvdata(dev);
> -	struct locomo_save_data *save;
> -	unsigned long flags;
> -
> -	save = kmalloc_obj(struct locomo_save_data);
> -	if (!save)
> -		return -ENOMEM;
> -
> -	lchip->saved_state = save;
> -
> -	spin_lock_irqsave(&lchip->lock, flags);
> -
> -	save->LCM_GPO     = locomo_readl(lchip->base + LOCOMO_GPO);	/* GPIO */
> -	locomo_writel(0x00, lchip->base + LOCOMO_GPO);
> -	save->LCM_SPICT   = locomo_readl(lchip->base + LOCOMO_SPI + LOCOMO_SPICT);	/* SPI */
> -	locomo_writel(0x40, lchip->base + LOCOMO_SPI + LOCOMO_SPICT);
> -	save->LCM_GPE     = locomo_readl(lchip->base + LOCOMO_GPE);	/* GPIO */
> -	locomo_writel(0x00, lchip->base + LOCOMO_GPE);
> -	save->LCM_ASD     = locomo_readl(lchip->base + LOCOMO_ASD);	/* ADSTART */
> -	locomo_writel(0x00, lchip->base + LOCOMO_ASD);
> -	save->LCM_SPIMD   = locomo_readl(lchip->base + LOCOMO_SPI + LOCOMO_SPIMD);	/* SPI */
> -	locomo_writel(0x3C14, lchip->base + LOCOMO_SPI + LOCOMO_SPIMD);
> -
> -	locomo_writel(0x00, lchip->base + LOCOMO_PAIF);
> -	locomo_writel(0x00, lchip->base + LOCOMO_DAC);
> -	locomo_writel(0x00, lchip->base + LOCOMO_BACKLIGHT + LOCOMO_TC);
> -
> -	if ((locomo_readl(lchip->base + LOCOMO_LED + LOCOMO_LPT0) & 0x88) && (locomo_readl(lchip->base + LOCOMO_LED + LOCOMO_LPT1) & 0x88))
> -		locomo_writel(0x00, lchip->base + LOCOMO_C32K); 	/* CLK32 off */
> -	else
> -		/* 18MHz already enabled, so no wait */
> -		locomo_writel(0xc1, lchip->base + LOCOMO_C32K); 	/* CLK32 on */
> -
> -	locomo_writel(0x00, lchip->base + LOCOMO_TADC);		/* 18MHz clock off*/
> -	locomo_writel(0x00, lchip->base + LOCOMO_AUDIO + LOCOMO_ACC);			/* 22MHz/24MHz clock off */
> -	locomo_writel(0x00, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);			/* FL */
> -
> -	spin_unlock_irqrestore(&lchip->lock, flags);
> -
> -	return 0;
> -}
> -
> -static int locomo_resume(struct platform_device *dev)
> -{
> -	struct locomo *lchip = platform_get_drvdata(dev);
> -	struct locomo_save_data *save;
> -	unsigned long r;
> -	unsigned long flags;
> -
> -	save = lchip->saved_state;
> -	if (!save)
> -		return 0;
> -
> -	spin_lock_irqsave(&lchip->lock, flags);
> -
> -	locomo_writel(save->LCM_GPO, lchip->base + LOCOMO_GPO);
> -	locomo_writel(save->LCM_SPICT, lchip->base + LOCOMO_SPI + LOCOMO_SPICT);
> -	locomo_writel(save->LCM_GPE, lchip->base + LOCOMO_GPE);
> -	locomo_writel(save->LCM_ASD, lchip->base + LOCOMO_ASD);
> -	locomo_writel(save->LCM_SPIMD, lchip->base + LOCOMO_SPI + LOCOMO_SPIMD);
> -
> -	locomo_writel(0x00, lchip->base + LOCOMO_C32K);
> -	locomo_writel(0x90, lchip->base + LOCOMO_TADC);
> -
> -	locomo_writel(0, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KSC);
> -	r = locomo_readl(lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
> -	r &= 0xFEFF;
> -	locomo_writel(r, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
> -	locomo_writel(0x1, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KCMD);
> -
> -	spin_unlock_irqrestore(&lchip->lock, flags);
> -
> -	lchip->saved_state = NULL;
> -	kfree(save);
> -
> -	return 0;
> -}
> -#endif
> -
> -static int
> -__locomo_probe(struct device *me, struct resource *mem, int irq)
> -{
> -	struct locomo_platform_data *pdata = me->platform_data;
> -	struct locomo *lchip;
> -	unsigned long r;
> -	int i, ret = -ENODEV;
> -
> -	lchip = kzalloc_obj(struct locomo);
> -	if (!lchip)
> -		return -ENOMEM;
> -
> -	spin_lock_init(&lchip->lock);
> -
> -	lchip->dev = me;
> -	dev_set_drvdata(lchip->dev, lchip);
> -
> -	lchip->phys = mem->start;
> -	lchip->irq = irq;
> -	lchip->irq_base = (pdata) ? pdata->irq_base : NO_IRQ;
> -
> -	/*
> -	 * Map the whole region.  This also maps the
> -	 * registers for our children.
> -	 */
> -	lchip->base = ioremap(mem->start, PAGE_SIZE);
> -	if (!lchip->base) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	/* locomo initialize */
> -	locomo_writel(0, lchip->base + LOCOMO_ICR);
> -	/* KEYBOARD */
> -	locomo_writel(0, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
> -
> -	/* GPIO */
> -	locomo_writel(0, lchip->base + LOCOMO_GPO);
> -	locomo_writel((LOCOMO_GPIO(1) | LOCOMO_GPIO(2) | LOCOMO_GPIO(13) | LOCOMO_GPIO(14))
> -			, lchip->base + LOCOMO_GPE);
> -	locomo_writel((LOCOMO_GPIO(1) | LOCOMO_GPIO(2) | LOCOMO_GPIO(13) | LOCOMO_GPIO(14))
> -			, lchip->base + LOCOMO_GPD);
> -	locomo_writel(0, lchip->base + LOCOMO_GIE);
> -
> -	/* Frontlight */
> -	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
> -	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
> -
> -	/* Longtime timer */
> -	locomo_writel(0, lchip->base + LOCOMO_LTINT);
> -	/* SPI */
> -	locomo_writel(0, lchip->base + LOCOMO_SPI + LOCOMO_SPIIE);
> -
> -	locomo_writel(6 + 8 + 320 + 30 - 10, lchip->base + LOCOMO_ASD);
> -	r = locomo_readl(lchip->base + LOCOMO_ASD);
> -	r |= 0x8000;
> -	locomo_writel(r, lchip->base + LOCOMO_ASD);
> -
> -	locomo_writel(6 + 8 + 320 + 30 - 10 - 128 + 4, lchip->base + LOCOMO_HSD);
> -	r = locomo_readl(lchip->base + LOCOMO_HSD);
> -	r |= 0x8000;
> -	locomo_writel(r, lchip->base + LOCOMO_HSD);
> -
> -	locomo_writel(128 / 8, lchip->base + LOCOMO_HSC);
> -
> -	/* XON */
> -	locomo_writel(0x80, lchip->base + LOCOMO_TADC);
> -	udelay(1000);
> -	/* CLK9MEN */
> -	r = locomo_readl(lchip->base + LOCOMO_TADC);
> -	r |= 0x10;
> -	locomo_writel(r, lchip->base + LOCOMO_TADC);
> -	udelay(100);
> -
> -	/* init DAC */
> -	r = locomo_readl(lchip->base + LOCOMO_DAC);
> -	r |= LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
> -	locomo_writel(r, lchip->base + LOCOMO_DAC);
> -
> -	r = locomo_readl(lchip->base + LOCOMO_VER);
> -	printk(KERN_INFO "LoCoMo Chip: %lu%lu\n", (r >> 8), (r & 0xff));
> -
> -	/*
> -	 * The interrupt controller must be initialised before any
> -	 * other device to ensure that the interrupts are available.
> -	 */
> -	if (lchip->irq != NO_IRQ && lchip->irq_base != NO_IRQ)
> -		locomo_setup_irq(lchip);
> -
> -	for (i = 0; i < ARRAY_SIZE(locomo_devices); i++)
> -		locomo_init_one_child(lchip, &locomo_devices[i]);
> -	return 0;
> -
> - out:
> -	kfree(lchip);
> -	return ret;
> -}
> -
> -static int locomo_remove_child(struct device *dev, void *data)
> -{
> -	device_unregister(dev);
> -	return 0;
> -} 
> -
> -static void __locomo_remove(struct locomo *lchip)
> -{
> -	device_for_each_child(lchip->dev, NULL, locomo_remove_child);
> -
> -	if (lchip->irq != NO_IRQ) {
> -		irq_set_chained_handler_and_data(lchip->irq, NULL, NULL);
> -	}
> -
> -	iounmap(lchip->base);
> -	kfree(lchip);
> -}
> -
> -/**
> - *	locomo_probe - probe for a single LoCoMo chip.
> - *	@dev: platform device
> - *
> - *	Probe for a LoCoMo chip.  This must be called
> - *	before any other locomo-specific code.
> - *
> - *	Returns:
> - *	* %-EINVAL	- device's IORESOURCE_MEM not found
> - *	* %-ENXIO	- could not allocate an IRQ for the device
> - *	* %-ENODEV	- device not found.
> - *	* %-EBUSY	- physical address already marked in-use.
> - *	* %-ENOMEM	- could not allocate or iomap memory.
> - *	* %0		- successful.
> - */
> -static int locomo_probe(struct platform_device *dev)
> -{
> -	struct resource *mem;
> -	int irq;
> -
> -	mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
> -	if (!mem)
> -		return -EINVAL;
> -	irq = platform_get_irq(dev, 0);
> -	if (irq < 0)
> -		return -ENXIO;
> -
> -	return __locomo_probe(&dev->dev, mem, irq);
> -}
> -
> -static void locomo_remove(struct platform_device *dev)
> -{
> -	struct locomo *lchip = platform_get_drvdata(dev);
> -
> -	if (lchip) {
> -		__locomo_remove(lchip);
> -		platform_set_drvdata(dev, NULL);
> -	}
> -}
> -
> -/*
> - *	Not sure if this should be on the system bus or not yet.
> - *	We really want some way to register a system device at
> - *	the per-machine level, and then have this driver pick
> - *	up the registered devices.
> - */
> -static struct platform_driver locomo_device_driver = {
> -	.probe		= locomo_probe,
> -	.remove		= locomo_remove,
> -#ifdef CONFIG_PM
> -	.suspend	= locomo_suspend,
> -	.resume		= locomo_resume,
> -#endif
> -	.driver		= {
> -		.name	= "locomo",
> -	},
> -};
> -
> -/*
> - *	Get the parent device driver (us) structure
> - *	from a child function device
> - */
> -static inline struct locomo *locomo_chip_driver(struct locomo_dev *ldev)
> -{
> -	return (struct locomo *)dev_get_drvdata(ldev->dev.parent);
> -}
> -
> -void locomo_gpio_set_dir(struct device *dev, unsigned int bits, unsigned int dir)
> -{
> -	struct locomo *lchip = dev_get_drvdata(dev);
> -	unsigned long flags;
> -	unsigned int r;
> -
> -	if (!lchip)
> -		return;
> -
> -	spin_lock_irqsave(&lchip->lock, flags);
> -
> -	r = locomo_readl(lchip->base + LOCOMO_GPD);
> -	if (dir)
> -		r |= bits;
> -	else
> -		r &= ~bits;
> -	locomo_writel(r, lchip->base + LOCOMO_GPD);
> -
> -	r = locomo_readl(lchip->base + LOCOMO_GPE);
> -	if (dir)
> -		r |= bits;
> -	else
> -		r &= ~bits;
> -	locomo_writel(r, lchip->base + LOCOMO_GPE);
> -
> -	spin_unlock_irqrestore(&lchip->lock, flags);
> -}
> -EXPORT_SYMBOL(locomo_gpio_set_dir);
> -
> -int locomo_gpio_read_level(struct device *dev, unsigned int bits)
> -{
> -	struct locomo *lchip = dev_get_drvdata(dev);
> -	unsigned long flags;
> -	unsigned int ret;
> -
> -	if (!lchip)
> -		return -ENODEV;
> -
> -	spin_lock_irqsave(&lchip->lock, flags);
> -	ret = locomo_readl(lchip->base + LOCOMO_GPL);
> -	spin_unlock_irqrestore(&lchip->lock, flags);
> -
> -	ret &= bits;
> -	return ret;
> -}
> -EXPORT_SYMBOL(locomo_gpio_read_level);
> -
> -int locomo_gpio_read_output(struct device *dev, unsigned int bits)
> -{
> -	struct locomo *lchip = dev_get_drvdata(dev);
> -	unsigned long flags;
> -	unsigned int ret;
> -
> -	if (!lchip)
> -		return -ENODEV;
> -
> -	spin_lock_irqsave(&lchip->lock, flags);
> -	ret = locomo_readl(lchip->base + LOCOMO_GPO);
> -	spin_unlock_irqrestore(&lchip->lock, flags);
> -
> -	ret &= bits;
> -	return ret;
> -}
> -EXPORT_SYMBOL(locomo_gpio_read_output);
> -
> -void locomo_gpio_write(struct device *dev, unsigned int bits, unsigned int set)
> -{
> -	struct locomo *lchip = dev_get_drvdata(dev);
> -	unsigned long flags;
> -	unsigned int r;
> -
> -	if (!lchip)
> -		return;
> -
> -	spin_lock_irqsave(&lchip->lock, flags);
> -
> -	r = locomo_readl(lchip->base + LOCOMO_GPO);
> -	if (set)
> -		r |= bits;
> -	else
> -		r &= ~bits;
> -	locomo_writel(r, lchip->base + LOCOMO_GPO);
> -
> -	spin_unlock_irqrestore(&lchip->lock, flags);
> -}
> -EXPORT_SYMBOL(locomo_gpio_write);
> -
> -static void locomo_m62332_sendbit(void *mapbase, int bit)
> -{
> -	unsigned int r;
> -
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r &=  ~(LOCOMO_DAC_SCLOEB);
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
> -	udelay(DAC_DATA_HOLD_TIME);	/* 300 nsec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r &=  ~(LOCOMO_DAC_SCLOEB);
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
> -	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
> -
> -	if (bit & 1) {
> -		r = locomo_readl(mapbase + LOCOMO_DAC);
> -		r |=  LOCOMO_DAC_SDAOEB;
> -		locomo_writel(r, mapbase + LOCOMO_DAC);
> -		udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
> -	} else {
> -		r = locomo_readl(mapbase + LOCOMO_DAC);
> -		r &=  ~(LOCOMO_DAC_SDAOEB);
> -		locomo_writel(r, mapbase + LOCOMO_DAC);
> -		udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
> -	}
> -
> -	udelay(DAC_DATA_SETUP_TIME);	/* 250 nsec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r |=  LOCOMO_DAC_SCLOEB;
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
> -	udelay(DAC_SCL_HIGH_HOLD_TIME);	/*  4.0 usec */
> -}
> -
> -void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int channel)
> -{
> -	struct locomo *lchip = locomo_chip_driver(ldev);
> -	int i;
> -	unsigned char data;
> -	unsigned int r;
> -	void *mapbase = lchip->base;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&lchip->lock, flags);
> -
> -	/* Start */
> -	udelay(DAC_BUS_FREE_TIME);	/* 5.0 usec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r |=  LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
> -	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.0 usec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r &=  ~(LOCOMO_DAC_SDAOEB);
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_START_HOLD_TIME);	/* 5.0 usec */
> -	udelay(DAC_DATA_HOLD_TIME);	/* 300 nsec */
> -
> -	/* Send slave address and W bit (LSB is W bit) */
> -	data = (M62332_SLAVE_ADDR << 1) | M62332_W_BIT;
> -	for (i = 1; i <= 8; i++) {
> -		locomo_m62332_sendbit(mapbase, data >> (8 - i));
> -	}
> -
> -	/* Check A bit */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r &=  ~(LOCOMO_DAC_SCLOEB);
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
> -	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r &=  ~(LOCOMO_DAC_SDAOEB);
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r |=  LOCOMO_DAC_SCLOEB;
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
> -	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
> -	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
> -		printk(KERN_WARNING "locomo: m62332_senddata Error 1\n");
> -		goto out;
> -	}
> -
> -	/* Send Sub address (LSB is channel select) */
> -	/*    channel = 0 : ch1 select              */
> -	/*            = 1 : ch2 select              */
> -	data = M62332_SUB_ADDR + channel;
> -	for (i = 1; i <= 8; i++) {
> -		locomo_m62332_sendbit(mapbase, data >> (8 - i));
> -	}
> -
> -	/* Check A bit */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r &=  ~(LOCOMO_DAC_SCLOEB);
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
> -	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r &=  ~(LOCOMO_DAC_SDAOEB);
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r |=  LOCOMO_DAC_SCLOEB;
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
> -	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
> -	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
> -		printk(KERN_WARNING "locomo: m62332_senddata Error 2\n");
> -		goto out;
> -	}
> -
> -	/* Send DAC data */
> -	for (i = 1; i <= 8; i++) {
> -		locomo_m62332_sendbit(mapbase, dac_data >> (8 - i));
> -	}
> -
> -	/* Check A bit */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r &=  ~(LOCOMO_DAC_SCLOEB);
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
> -	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r &=  ~(LOCOMO_DAC_SDAOEB);
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r |=  LOCOMO_DAC_SCLOEB;
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
> -	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
> -	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
> -		printk(KERN_WARNING "locomo: m62332_senddata Error 3\n");
> -	}
> -
> -out:
> -	/* stop */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r &=  ~(LOCOMO_DAC_SCLOEB);
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_LOW_SETUP_TIME);	/* 300 nsec */
> -	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r |=  LOCOMO_DAC_SCLOEB;
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
> -	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4 usec */
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r |=  LOCOMO_DAC_SDAOEB;
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_HIGH_SETUP_TIME);	/* 1000 nsec */
> -	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4 usec */
> -
> -	r = locomo_readl(mapbase + LOCOMO_DAC);
> -	r |=  LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
> -	locomo_writel(r, mapbase + LOCOMO_DAC);
> -	udelay(DAC_LOW_SETUP_TIME);	/* 1000 nsec */
> -	udelay(DAC_SCL_LOW_HOLD_TIME);	/* 4.7 usec */
> -
> -	spin_unlock_irqrestore(&lchip->lock, flags);
> -}
> -EXPORT_SYMBOL(locomo_m62332_senddata);
> -
> -/*
> - *	Frontlight control
> - */
> -
> -void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf)
> -{
> -	unsigned long flags;
> -	struct locomo *lchip = locomo_chip_driver(dev);
> -
> -	if (vr)
> -		locomo_gpio_write(dev->dev.parent, LOCOMO_GPIO_FL_VR, 1);
> -	else
> -		locomo_gpio_write(dev->dev.parent, LOCOMO_GPIO_FL_VR, 0);
> -
> -	spin_lock_irqsave(&lchip->lock, flags);
> -	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
> -	udelay(100);
> -	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
> -	locomo_writel(bpwf | LOCOMO_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
> -	spin_unlock_irqrestore(&lchip->lock, flags);
> -}
> -EXPORT_SYMBOL(locomo_frontlight_set);
> -
> -/*
> - *	LoCoMo "Register Access Bus."
> - *
> - *	We model this as a regular bus type, and hang devices directly
> - *	off this.
> - */
> -static int locomo_match(struct device *_dev, const struct device_driver *_drv)
> -{
> -	struct locomo_dev *dev = LOCOMO_DEV(_dev);
> -	const struct locomo_driver *drv = LOCOMO_DRV(_drv);
> -
> -	return dev->devid == drv->devid;
> -}
> -
> -static int locomo_bus_probe(struct device *dev)
> -{
> -	struct locomo_dev *ldev = LOCOMO_DEV(dev);
> -	struct locomo_driver *drv = LOCOMO_DRV(dev->driver);
> -	int ret = -ENODEV;
> -
> -	if (drv->probe)
> -		ret = drv->probe(ldev);
> -	return ret;
> -}
> -
> -static void locomo_bus_remove(struct device *dev)
> -{
> -	struct locomo_dev *ldev = LOCOMO_DEV(dev);
> -	struct locomo_driver *drv = LOCOMO_DRV(dev->driver);
> -
> -	if (drv->remove)
> -		drv->remove(ldev);
> -}
> -
> -static const struct bus_type locomo_bus_type = {
> -	.name		= "locomo-bus",
> -	.match		= locomo_match,
> -	.probe		= locomo_bus_probe,
> -	.remove		= locomo_bus_remove,
> -};
> -
> -int locomo_driver_register(struct locomo_driver *driver)
> -{
> -	driver->drv.bus = &locomo_bus_type;
> -	return driver_register(&driver->drv);
> -}
> -EXPORT_SYMBOL(locomo_driver_register);
> -
> -void locomo_driver_unregister(struct locomo_driver *driver)
> -{
> -	driver_unregister(&driver->drv);
> -}
> -EXPORT_SYMBOL(locomo_driver_unregister);
> -
> -static int __init locomo_init(void)
> -{
> -	int ret = bus_register(&locomo_bus_type);
> -	if (ret == 0)
> -		platform_driver_register(&locomo_device_driver);
> -	return ret;
> -}
> -
> -static void __exit locomo_exit(void)
> -{
> -	platform_driver_unregister(&locomo_device_driver);
> -	bus_unregister(&locomo_bus_type);
> -}
> -
> -module_init(locomo_init);
> -module_exit(locomo_exit);
> -
> -MODULE_DESCRIPTION("Sharp LoCoMo core driver");
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> deleted file mode 100644
> index a0f854cf4748..000000000000
> --- a/arch/arm/common/sa1111.c
> +++ /dev/null
> @@ -1,1413 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * linux/arch/arm/common/sa1111.c
> - *
> - * SA1111 support
> - *
> - * Original code by John Dorsey
> - *
> - * This file contains all generic SA1111 support.
> - *
> - * All initialization functions provided here are intended to be called
> - * from machine specific code with proper arguments when required.
> - */
> -#include <linux/module.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/init.h>
> -#include <linux/irq.h>
> -#include <linux/kernel.h>
> -#include <linux/delay.h>
> -#include <linux/errno.h>
> -#include <linux/ioport.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -#include <linux/spinlock.h>
> -#include <linux/dma-map-ops.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
> -
> -#include <asm/mach/irq.h>
> -#include <asm/mach-types.h>
> -#include <linux/sizes.h>
> -
> -#include <asm/hardware/sa1111.h>
> -
> -#ifdef CONFIG_ARCH_SA1100
> -#include <mach/hardware.h>
> -#endif
> -
> -/* SA1111 IRQs */
> -#define IRQ_GPAIN0		(0)
> -#define IRQ_GPAIN1		(1)
> -#define IRQ_GPAIN2		(2)
> -#define IRQ_GPAIN3		(3)
> -#define IRQ_GPBIN0		(4)
> -#define IRQ_GPBIN1		(5)
> -#define IRQ_GPBIN2		(6)
> -#define IRQ_GPBIN3		(7)
> -#define IRQ_GPBIN4		(8)
> -#define IRQ_GPBIN5		(9)
> -#define IRQ_GPCIN0		(10)
> -#define IRQ_GPCIN1		(11)
> -#define IRQ_GPCIN2		(12)
> -#define IRQ_GPCIN3		(13)
> -#define IRQ_GPCIN4		(14)
> -#define IRQ_GPCIN5		(15)
> -#define IRQ_GPCIN6		(16)
> -#define IRQ_GPCIN7		(17)
> -#define IRQ_MSTXINT		(18)
> -#define IRQ_MSRXINT		(19)
> -#define IRQ_MSSTOPERRINT	(20)
> -#define IRQ_TPTXINT		(21)
> -#define IRQ_TPRXINT		(22)
> -#define IRQ_TPSTOPERRINT	(23)
> -#define SSPXMTINT		(24)
> -#define SSPRCVINT		(25)
> -#define SSPROR			(26)
> -#define AUDXMTDMADONEA		(32)
> -#define AUDRCVDMADONEA		(33)
> -#define AUDXMTDMADONEB		(34)
> -#define AUDRCVDMADONEB		(35)
> -#define AUDTFSR			(36)
> -#define AUDRFSR			(37)
> -#define AUDTUR			(38)
> -#define AUDROR			(39)
> -#define AUDDTS			(40)
> -#define AUDRDD			(41)
> -#define AUDSTO			(42)
> -#define IRQ_USBPWR		(43)
> -#define IRQ_HCIM		(44)
> -#define IRQ_HCIBUFFACC		(45)
> -#define IRQ_HCIRMTWKP		(46)
> -#define IRQ_NHCIMFCIR		(47)
> -#define IRQ_USB_PORT_RESUME	(48)
> -#define IRQ_S0_READY_NINT	(49)
> -#define IRQ_S1_READY_NINT	(50)
> -#define IRQ_S0_CD_VALID		(51)
> -#define IRQ_S1_CD_VALID		(52)
> -#define IRQ_S0_BVD1_STSCHG	(53)
> -#define IRQ_S1_BVD1_STSCHG	(54)
> -#define SA1111_IRQ_NR		(55)
> -
> -extern void sa1110_mb_enable(void);
> -extern void sa1110_mb_disable(void);
> -
> -/*
> - * We keep the following data for the overall SA1111.  Note that the
> - * struct device and struct resource are "fake"; they should be supplied
> - * by the bus above us.  However, in the interests of getting all SA1111
> - * drivers converted over to the device model, we provide this as an
> - * anchor point for all the other drivers.
> - */
> -struct sa1111 {
> -	struct device	*dev;
> -	struct clk	*clk;
> -	unsigned long	phys;
> -	int		irq;
> -	int		irq_base;	/* base for cascaded on-chip IRQs */
> -	spinlock_t	lock;
> -	void __iomem	*base;
> -	struct sa1111_platform_data *pdata;
> -	struct irq_domain *irqdomain;
> -	struct gpio_chip gc;
> -#ifdef CONFIG_PM
> -	void		*saved_state;
> -#endif
> -};
> -
> -/*
> - * We _really_ need to eliminate this.  Its only users
> - * are the PWM and DMA checking code.
> - */
> -static struct sa1111 *g_sa1111;
> -
> -struct sa1111_dev_info {
> -	unsigned long	offset;
> -	unsigned long	skpcr_mask;
> -	bool		dma;
> -	unsigned int	devid;
> -	unsigned int	hwirq[6];
> -};
> -
> -static struct sa1111_dev_info sa1111_devices[] = {
> -	{
> -		.offset		= SA1111_USB,
> -		.skpcr_mask	= SKPCR_UCLKEN,
> -		.dma		= true,
> -		.devid		= SA1111_DEVID_USB,
> -		.hwirq = {
> -			IRQ_USBPWR,
> -			IRQ_HCIM,
> -			IRQ_HCIBUFFACC,
> -			IRQ_HCIRMTWKP,
> -			IRQ_NHCIMFCIR,
> -			IRQ_USB_PORT_RESUME
> -		},
> -	},
> -	{
> -		.offset		= 0x0600,
> -		.skpcr_mask	= SKPCR_I2SCLKEN | SKPCR_L3CLKEN,
> -		.dma		= true,
> -		.devid		= SA1111_DEVID_SAC,
> -		.hwirq = {
> -			AUDXMTDMADONEA,
> -			AUDXMTDMADONEB,
> -			AUDRCVDMADONEA,
> -			AUDRCVDMADONEB
> -		},
> -	},
> -	{
> -		.offset		= 0x0800,
> -		.skpcr_mask	= SKPCR_SCLKEN,
> -		.devid		= SA1111_DEVID_SSP,
> -	},
> -	{
> -		.offset		= SA1111_KBD,
> -		.skpcr_mask	= SKPCR_PTCLKEN,
> -		.devid		= SA1111_DEVID_PS2_KBD,
> -		.hwirq = {
> -			IRQ_TPRXINT,
> -			IRQ_TPTXINT
> -		},
> -	},
> -	{
> -		.offset		= SA1111_MSE,
> -		.skpcr_mask	= SKPCR_PMCLKEN,
> -		.devid		= SA1111_DEVID_PS2_MSE,
> -		.hwirq = {
> -			IRQ_MSRXINT,
> -			IRQ_MSTXINT
> -		},
> -	},
> -	{
> -		.offset		= 0x1800,
> -		.skpcr_mask	= 0,
> -		.devid		= SA1111_DEVID_PCMCIA,
> -		.hwirq = {
> -			IRQ_S0_READY_NINT,
> -			IRQ_S0_CD_VALID,
> -			IRQ_S0_BVD1_STSCHG,
> -			IRQ_S1_READY_NINT,
> -			IRQ_S1_CD_VALID,
> -			IRQ_S1_BVD1_STSCHG,
> -		},
> -	},
> -};
> -
> -static int sa1111_map_irq(struct sa1111 *sachip, irq_hw_number_t hwirq)
> -{
> -	return irq_create_mapping(sachip->irqdomain, hwirq);
> -}
> -
> -/*
> - * SA1111 interrupt support.  Since clearing an IRQ while there are
> - * active IRQs causes the interrupt output to pulse, the upper levels
> - * will call us again if there are more interrupts to process.
> - */
> -static void sa1111_irq_handler(struct irq_desc *desc)
> -{
> -	unsigned int stat0, stat1, i;
> -	struct sa1111 *sachip = irq_desc_get_handler_data(desc);
> -	struct irq_domain *irqdomain;
> -	void __iomem *mapbase = sachip->base + SA1111_INTC;
> -
> -	stat0 = readl_relaxed(mapbase + SA1111_INTSTATCLR0);
> -	stat1 = readl_relaxed(mapbase + SA1111_INTSTATCLR1);
> -
> -	writel_relaxed(stat0, mapbase + SA1111_INTSTATCLR0);
> -
> -	desc->irq_data.chip->irq_ack(&desc->irq_data);
> -
> -	writel_relaxed(stat1, mapbase + SA1111_INTSTATCLR1);
> -
> -	if (stat0 == 0 && stat1 == 0) {
> -		handle_bad_irq(desc);
> -		return;
> -	}
> -
> -	irqdomain = sachip->irqdomain;
> -
> -	for (i = 0; stat0; i++, stat0 >>= 1)
> -		if (stat0 & 1)
> -			generic_handle_domain_irq(irqdomain, i);
> -
> -	for (i = 32; stat1; i++, stat1 >>= 1)
> -		if (stat1 & 1)
> -			generic_handle_domain_irq(irqdomain, i);
> -
> -	/* For level-based interrupts */
> -	desc->irq_data.chip->irq_unmask(&desc->irq_data);
> -}
> -
> -static u32 sa1111_irqmask(struct irq_data *d)
> -{
> -	return BIT(irqd_to_hwirq(d) & 31);
> -}
> -
> -static int sa1111_irqbank(struct irq_data *d)
> -{
> -	return (irqd_to_hwirq(d) / 32) * 4;
> -}
> -
> -static void sa1111_ack_irq(struct irq_data *d)
> -{
> -}
> -
> -static void sa1111_mask_irq(struct irq_data *d)
> -{
> -	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
> -	void __iomem *mapbase = sachip->base + SA1111_INTC + sa1111_irqbank(d);
> -	u32 ie;
> -
> -	ie = readl_relaxed(mapbase + SA1111_INTEN0);
> -	ie &= ~sa1111_irqmask(d);
> -	writel(ie, mapbase + SA1111_INTEN0);
> -}
> -
> -static void sa1111_unmask_irq(struct irq_data *d)
> -{
> -	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
> -	void __iomem *mapbase = sachip->base + SA1111_INTC + sa1111_irqbank(d);
> -	u32 ie;
> -
> -	ie = readl_relaxed(mapbase + SA1111_INTEN0);
> -	ie |= sa1111_irqmask(d);
> -	writel_relaxed(ie, mapbase + SA1111_INTEN0);
> -}
> -
> -/*
> - * Attempt to re-trigger the interrupt.  The SA1111 contains a register
> - * (INTSET) which claims to do this.  However, in practice no amount of
> - * manipulation of INTEN and INTSET guarantees that the interrupt will
> - * be triggered.  In fact, its very difficult, if not impossible to get
> - * INTSET to re-trigger the interrupt.
> - */
> -static int sa1111_retrigger_irq(struct irq_data *d)
> -{
> -	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
> -	void __iomem *mapbase = sachip->base + SA1111_INTC + sa1111_irqbank(d);
> -	u32 ip, mask = sa1111_irqmask(d);
> -	int i;
> -
> -	ip = readl_relaxed(mapbase + SA1111_INTPOL0);
> -	for (i = 0; i < 8; i++) {
> -		writel_relaxed(ip ^ mask, mapbase + SA1111_INTPOL0);
> -		writel_relaxed(ip, mapbase + SA1111_INTPOL0);
> -		if (readl_relaxed(mapbase + SA1111_INTSTATCLR0) & mask)
> -			break;
> -	}
> -
> -	if (i == 8) {
> -		pr_err("Danger Will Robinson: failed to re-trigger IRQ%d\n",
> -		       d->irq);
> -		return 0;
> -	}
> -
> -	return 1;
> -}
> -
> -static int sa1111_type_irq(struct irq_data *d, unsigned int flags)
> -{
> -	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
> -	void __iomem *mapbase = sachip->base + SA1111_INTC + sa1111_irqbank(d);
> -	u32 ip, mask = sa1111_irqmask(d);
> -
> -	if (flags == IRQ_TYPE_PROBE)
> -		return 0;
> -
> -	if ((!(flags & IRQ_TYPE_EDGE_RISING) ^ !(flags & IRQ_TYPE_EDGE_FALLING)) == 0)
> -		return -EINVAL;
> -
> -	ip = readl_relaxed(mapbase + SA1111_INTPOL0);
> -	if (flags & IRQ_TYPE_EDGE_RISING)
> -		ip &= ~mask;
> -	else
> -		ip |= mask;
> -	writel_relaxed(ip, mapbase + SA1111_INTPOL0);
> -	writel_relaxed(ip, mapbase + SA1111_WAKEPOL0);
> -
> -	return 0;
> -}
> -
> -static int sa1111_wake_irq(struct irq_data *d, unsigned int on)
> -{
> -	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
> -	void __iomem *mapbase = sachip->base + SA1111_INTC + sa1111_irqbank(d);
> -	u32 we, mask = sa1111_irqmask(d);
> -
> -	we = readl_relaxed(mapbase + SA1111_WAKEEN0);
> -	if (on)
> -		we |= mask;
> -	else
> -		we &= ~mask;
> -	writel_relaxed(we, mapbase + SA1111_WAKEEN0);
> -
> -	return 0;
> -}
> -
> -static struct irq_chip sa1111_irq_chip = {
> -	.name		= "SA1111",
> -	.irq_ack	= sa1111_ack_irq,
> -	.irq_mask	= sa1111_mask_irq,
> -	.irq_unmask	= sa1111_unmask_irq,
> -	.irq_retrigger	= sa1111_retrigger_irq,
> -	.irq_set_type	= sa1111_type_irq,
> -	.irq_set_wake	= sa1111_wake_irq,
> -};
> -
> -static int sa1111_irqdomain_map(struct irq_domain *d, unsigned int irq,
> -	irq_hw_number_t hwirq)
> -{
> -	struct sa1111 *sachip = d->host_data;
> -
> -	/* Disallow unavailable interrupts */
> -	if (hwirq > SSPROR && hwirq < AUDXMTDMADONEA)
> -		return -EINVAL;
> -
> -	irq_set_chip_data(irq, sachip);
> -	irq_set_chip_and_handler(irq, &sa1111_irq_chip, handle_edge_irq);
> -	irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
> -
> -	return 0;
> -}
> -
> -static const struct irq_domain_ops sa1111_irqdomain_ops = {
> -	.map = sa1111_irqdomain_map,
> -	.xlate = irq_domain_xlate_twocell,
> -};
> -
> -static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
> -{
> -	void __iomem *irqbase = sachip->base + SA1111_INTC;
> -	int ret;
> -
> -	/*
> -	 * We're guaranteed that this region hasn't been taken.
> -	 */
> -	request_mem_region(sachip->phys + SA1111_INTC, 512, "irq");
> -
> -	ret = irq_alloc_descs(-1, irq_base, SA1111_IRQ_NR, -1);
> -	if (ret <= 0) {
> -		dev_err(sachip->dev, "unable to allocate %u irqs: %d\n",
> -			SA1111_IRQ_NR, ret);
> -		if (ret == 0)
> -			ret = -EINVAL;
> -		return ret;
> -	}
> -
> -	sachip->irq_base = ret;
> -
> -	/* disable all IRQs */
> -	writel_relaxed(0, irqbase + SA1111_INTEN0);
> -	writel_relaxed(0, irqbase + SA1111_INTEN1);
> -	writel_relaxed(0, irqbase + SA1111_WAKEEN0);
> -	writel_relaxed(0, irqbase + SA1111_WAKEEN1);
> -
> -	/*
> -	 * detect on rising edge.  Note: Feb 2001 Errata for SA1111
> -	 * specifies that S0ReadyInt and S1ReadyInt should be '1'.
> -	 */
> -	writel_relaxed(0, irqbase + SA1111_INTPOL0);
> -	writel_relaxed(BIT(IRQ_S0_READY_NINT & 31) |
> -		       BIT(IRQ_S1_READY_NINT & 31),
> -		       irqbase + SA1111_INTPOL1);
> -
> -	/* clear all IRQs */
> -	writel_relaxed(~0, irqbase + SA1111_INTSTATCLR0);
> -	writel_relaxed(~0, irqbase + SA1111_INTSTATCLR1);
> -
> -	sachip->irqdomain = irq_domain_create_linear(NULL, SA1111_IRQ_NR,
> -						     &sa1111_irqdomain_ops,
> -						     sachip);
> -	if (!sachip->irqdomain) {
> -		irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
> -		return -ENOMEM;
> -	}
> -
> -	irq_domain_associate_many(sachip->irqdomain,
> -				  sachip->irq_base + IRQ_GPAIN0,
> -				  IRQ_GPAIN0, SSPROR + 1 - IRQ_GPAIN0);
> -	irq_domain_associate_many(sachip->irqdomain,
> -				  sachip->irq_base + AUDXMTDMADONEA,
> -				  AUDXMTDMADONEA,
> -				  IRQ_S1_BVD1_STSCHG + 1 - AUDXMTDMADONEA);
> -
> -	/*
> -	 * Register SA1111 interrupt
> -	 */
> -	irq_set_irq_type(sachip->irq, IRQ_TYPE_EDGE_RISING);
> -	irq_set_chained_handler_and_data(sachip->irq, sa1111_irq_handler,
> -					 sachip);
> -
> -	dev_info(sachip->dev, "Providing IRQ%u-%u\n",
> -		sachip->irq_base, sachip->irq_base + SA1111_IRQ_NR - 1);
> -
> -	return 0;
> -}
> -
> -static void sa1111_remove_irq(struct sa1111 *sachip)
> -{
> -	struct irq_domain *domain = sachip->irqdomain;
> -	void __iomem *irqbase = sachip->base + SA1111_INTC;
> -	int i;
> -
> -	/* disable all IRQs */
> -	writel_relaxed(0, irqbase + SA1111_INTEN0);
> -	writel_relaxed(0, irqbase + SA1111_INTEN1);
> -	writel_relaxed(0, irqbase + SA1111_WAKEEN0);
> -	writel_relaxed(0, irqbase + SA1111_WAKEEN1);
> -
> -	irq_set_chained_handler_and_data(sachip->irq, NULL, NULL);
> -	for (i = 0; i < SA1111_IRQ_NR; i++)
> -		irq_dispose_mapping(irq_find_mapping(domain, i));
> -	irq_domain_remove(domain);
> -
> -	release_mem_region(sachip->phys + SA1111_INTC, 512);
> -}
> -
> -enum {
> -	SA1111_GPIO_PXDDR = (SA1111_GPIO_PADDR - SA1111_GPIO_PADDR),
> -	SA1111_GPIO_PXDRR = (SA1111_GPIO_PADRR - SA1111_GPIO_PADDR),
> -	SA1111_GPIO_PXDWR = (SA1111_GPIO_PADWR - SA1111_GPIO_PADDR),
> -	SA1111_GPIO_PXSDR = (SA1111_GPIO_PASDR - SA1111_GPIO_PADDR),
> -	SA1111_GPIO_PXSSR = (SA1111_GPIO_PASSR - SA1111_GPIO_PADDR),
> -};
> -
> -static struct sa1111 *gc_to_sa1111(struct gpio_chip *gc)
> -{
> -	return container_of(gc, struct sa1111, gc);
> -}
> -
> -static void __iomem *sa1111_gpio_map_reg(struct sa1111 *sachip, unsigned offset)
> -{
> -	void __iomem *reg = sachip->base + SA1111_GPIO;
> -
> -	if (offset < 4)
> -		return reg + SA1111_GPIO_PADDR;
> -	if (offset < 10)
> -		return reg + SA1111_GPIO_PBDDR;
> -	if (offset < 18)
> -		return reg + SA1111_GPIO_PCDDR;
> -	return NULL;
> -}
> -
> -static u32 sa1111_gpio_map_bit(unsigned offset)
> -{
> -	if (offset < 4)
> -		return BIT(offset);
> -	if (offset < 10)
> -		return BIT(offset - 4);
> -	if (offset < 18)
> -		return BIT(offset - 10);
> -	return 0;
> -}
> -
> -static void sa1111_gpio_modify(void __iomem *reg, u32 mask, u32 set)
> -{
> -	u32 val;
> -
> -	val = readl_relaxed(reg);
> -	val &= ~mask;
> -	val |= mask & set;
> -	writel_relaxed(val, reg);
> -}
> -
> -static int sa1111_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
> -{
> -	struct sa1111 *sachip = gc_to_sa1111(gc);
> -	void __iomem *reg = sa1111_gpio_map_reg(sachip, offset);
> -	u32 mask = sa1111_gpio_map_bit(offset);
> -
> -	return !!(readl_relaxed(reg + SA1111_GPIO_PXDDR) & mask);
> -}
> -
> -static int sa1111_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
> -{
> -	struct sa1111 *sachip = gc_to_sa1111(gc);
> -	unsigned long flags;
> -	void __iomem *reg = sa1111_gpio_map_reg(sachip, offset);
> -	u32 mask = sa1111_gpio_map_bit(offset);
> -
> -	spin_lock_irqsave(&sachip->lock, flags);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PXDDR, mask, mask);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PXSDR, mask, mask);
> -	spin_unlock_irqrestore(&sachip->lock, flags);
> -
> -	return 0;
> -}
> -
> -static int sa1111_gpio_direction_output(struct gpio_chip *gc, unsigned offset,
> -	int value)
> -{
> -	struct sa1111 *sachip = gc_to_sa1111(gc);
> -	unsigned long flags;
> -	void __iomem *reg = sa1111_gpio_map_reg(sachip, offset);
> -	u32 mask = sa1111_gpio_map_bit(offset);
> -
> -	spin_lock_irqsave(&sachip->lock, flags);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PXDWR, mask, value ? mask : 0);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PXSSR, mask, value ? mask : 0);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PXDDR, mask, 0);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PXSDR, mask, 0);
> -	spin_unlock_irqrestore(&sachip->lock, flags);
> -
> -	return 0;
> -}
> -
> -static int sa1111_gpio_get(struct gpio_chip *gc, unsigned offset)
> -{
> -	struct sa1111 *sachip = gc_to_sa1111(gc);
> -	void __iomem *reg = sa1111_gpio_map_reg(sachip, offset);
> -	u32 mask = sa1111_gpio_map_bit(offset);
> -
> -	return !!(readl_relaxed(reg + SA1111_GPIO_PXDRR) & mask);
> -}
> -
> -static int sa1111_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
> -{
> -	struct sa1111 *sachip = gc_to_sa1111(gc);
> -	unsigned long flags;
> -	void __iomem *reg = sa1111_gpio_map_reg(sachip, offset);
> -	u32 mask = sa1111_gpio_map_bit(offset);
> -
> -	spin_lock_irqsave(&sachip->lock, flags);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PXDWR, mask, value ? mask : 0);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PXSSR, mask, value ? mask : 0);
> -	spin_unlock_irqrestore(&sachip->lock, flags);
> -
> -	return 0;
> -}
> -
> -static int sa1111_gpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> -				    unsigned long *bits)
> -{
> -	struct sa1111 *sachip = gc_to_sa1111(gc);
> -	unsigned long flags;
> -	void __iomem *reg = sachip->base + SA1111_GPIO;
> -	u32 msk, val;
> -
> -	msk = *mask;
> -	val = *bits;
> -
> -	spin_lock_irqsave(&sachip->lock, flags);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PADWR, msk & 15, val);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PASSR, msk & 15, val);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PBDWR, (msk >> 4) & 255, val >> 4);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PBSSR, (msk >> 4) & 255, val >> 4);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PCDWR, (msk >> 12) & 255, val >> 12);
> -	sa1111_gpio_modify(reg + SA1111_GPIO_PCSSR, (msk >> 12) & 255, val >> 12);
> -	spin_unlock_irqrestore(&sachip->lock, flags);
> -
> -	return 0;
> -}
> -
> -static int sa1111_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
> -{
> -	struct sa1111 *sachip = gc_to_sa1111(gc);
> -
> -	return sa1111_map_irq(sachip, offset);
> -}
> -
> -static int sa1111_setup_gpios(struct sa1111 *sachip)
> -{
> -	sachip->gc.label = "sa1111";
> -	sachip->gc.parent = sachip->dev;
> -	sachip->gc.owner = THIS_MODULE;
> -	sachip->gc.get_direction = sa1111_gpio_get_direction;
> -	sachip->gc.direction_input = sa1111_gpio_direction_input;
> -	sachip->gc.direction_output = sa1111_gpio_direction_output;
> -	sachip->gc.get = sa1111_gpio_get;
> -	sachip->gc.set = sa1111_gpio_set;
> -	sachip->gc.set_multiple = sa1111_gpio_set_multiple;
> -	sachip->gc.to_irq = sa1111_gpio_to_irq;
> -	sachip->gc.base = -1;
> -	sachip->gc.ngpio = 18;
> -
> -	return devm_gpiochip_add_data(sachip->dev, &sachip->gc, sachip);
> -}
> -
> -/*
> - * Bring the SA1111 out of reset.  This requires a set procedure:
> - *  1. nRESET asserted (by hardware)
> - *  2. CLK turned on from SA1110
> - *  3. nRESET deasserted
> - *  4. VCO turned on, PLL_BYPASS turned off
> - *  5. Wait lock time, then assert RCLKEn
> - *  7. PCR set to allow clocking of individual functions
> - *
> - * Until we've done this, the only registers we can access are:
> - *   SBI_SKCR
> - *   SBI_SMCR
> - *   SBI_SKID
> - */
> -static void sa1111_wake(struct sa1111 *sachip)
> -{
> -	unsigned long flags, r;
> -
> -	spin_lock_irqsave(&sachip->lock, flags);
> -
> -	clk_enable(sachip->clk);
> -
> -	/*
> -	 * Turn VCO on, and disable PLL Bypass.
> -	 */
> -	r = readl_relaxed(sachip->base + SA1111_SKCR);
> -	r &= ~SKCR_VCO_OFF;
> -	writel_relaxed(r, sachip->base + SA1111_SKCR);
> -	r |= SKCR_PLL_BYPASS | SKCR_OE_EN;
> -	writel_relaxed(r, sachip->base + SA1111_SKCR);
> -
> -	/*
> -	 * Wait lock time.  SA1111 manual _doesn't_
> -	 * specify a figure for this!  We choose 100us.
> -	 */
> -	udelay(100);
> -
> -	/*
> -	 * Enable RCLK.  We also ensure that RDYEN is set.
> -	 */
> -	r |= SKCR_RCLKEN | SKCR_RDYEN;
> -	writel_relaxed(r, sachip->base + SA1111_SKCR);
> -
> -	/*
> -	 * Wait 14 RCLK cycles for the chip to finish coming out
> -	 * of reset. (RCLK=24MHz).  This is 590ns.
> -	 */
> -	udelay(1);
> -
> -	/*
> -	 * Ensure all clocks are initially off.
> -	 */
> -	writel_relaxed(0, sachip->base + SA1111_SKPCR);
> -
> -	spin_unlock_irqrestore(&sachip->lock, flags);
> -}
> -
> -#ifdef CONFIG_ARCH_SA1100
> -
> -static u32 sa1111_dma_mask[] = {
> -	~0,
> -	~(1 << 20),
> -	~(1 << 23),
> -	~(1 << 24),
> -	~(1 << 25),
> -	~(1 << 20),
> -	~(1 << 20),
> -	0,
> -};
> -
> -/*
> - * Configure the SA1111 shared memory controller.
> - */
> -static void
> -sa1111_configure_smc(struct sa1111 *sachip, int sdram, unsigned int drac,
> -		     unsigned int cas_latency)
> -{
> -	unsigned int smcr = SMCR_DTIM | SMCR_MBGE | FInsrt(drac, SMCR_DRAC);
> -
> -	if (cas_latency == 3)
> -		smcr |= SMCR_CLAT;
> -
> -	writel_relaxed(smcr, sachip->base + SA1111_SMCR);
> -
> -	/*
> -	 * Now clear the bits in the DMA mask to work around the SA1111
> -	 * DMA erratum (Intel StrongARM SA-1111 Microprocessor Companion
> -	 * Chip Specification Update, June 2000, Erratum #7).
> -	 */
> -	if (sachip->dev->dma_mask)
> -		*sachip->dev->dma_mask &= sa1111_dma_mask[drac >> 2];
> -
> -	sachip->dev->coherent_dma_mask &= sa1111_dma_mask[drac >> 2];
> -}
> -#endif
> -
> -static void sa1111_dev_release(struct device *_dev)
> -{
> -	struct sa1111_dev *dev = to_sa1111_device(_dev);
> -
> -	kfree(dev);
> -}
> -
> -static int
> -sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
> -		      struct sa1111_dev_info *info)
> -{
> -	struct sa1111_dev *dev;
> -	unsigned i;
> -	int ret;
> -
> -	dev = kzalloc_obj(struct sa1111_dev);
> -	if (!dev) {
> -		ret = -ENOMEM;
> -		goto err_alloc;
> -	}
> -
> -	device_initialize(&dev->dev);
> -	dev_set_name(&dev->dev, "%4.4lx", info->offset);
> -	dev->devid	 = info->devid;
> -	dev->dev.parent  = sachip->dev;
> -	dev->dev.bus     = &sa1111_bus_type;
> -	dev->dev.release = sa1111_dev_release;
> -	dev->res.start   = sachip->phys + info->offset;
> -	dev->res.end     = dev->res.start + 511;
> -	dev->res.name    = dev_name(&dev->dev);
> -	dev->res.flags   = IORESOURCE_MEM;
> -	dev->mapbase     = sachip->base + info->offset;
> -	dev->skpcr_mask  = info->skpcr_mask;
> -
> -	for (i = 0; i < ARRAY_SIZE(info->hwirq); i++)
> -		dev->hwirq[i] = info->hwirq[i];
> -
> -	/*
> -	 * If the parent device has a DMA mask associated with it, and
> -	 * this child supports DMA, propagate it down to the children.
> -	 */
> -	if (info->dma && sachip->dev->dma_mask) {
> -		dev->dma_mask = *sachip->dev->dma_mask;
> -		dev->dev.dma_mask = &dev->dma_mask;
> -		dev->dev.coherent_dma_mask = sachip->dev->coherent_dma_mask;
> -	}
> -
> -	ret = request_resource(parent, &dev->res);
> -	if (ret) {
> -		dev_err(sachip->dev, "failed to allocate resource for %s\n",
> -			dev->res.name);
> -		goto err_resource;
> -	}
> -
> -	ret = device_add(&dev->dev);
> -	if (ret)
> -		goto err_add;
> -	return 0;
> -
> - err_add:
> -	release_resource(&dev->res);
> - err_resource:
> -	put_device(&dev->dev);
> - err_alloc:
> -	return ret;
> -}
> -
> -static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
> -{
> -	struct sa1111_platform_data *pd = me->platform_data;
> -	struct sa1111 *sachip;
> -	unsigned long id;
> -	unsigned int has_devs;
> -	int i, ret = -ENODEV;
> -
> -	if (!pd)
> -		return -EINVAL;
> -
> -	sachip = devm_kzalloc(me, sizeof(struct sa1111), GFP_KERNEL);
> -	if (!sachip)
> -		return -ENOMEM;
> -
> -	sachip->clk = devm_clk_get(me, "SA1111_CLK");
> -	if (IS_ERR(sachip->clk))
> -		return PTR_ERR(sachip->clk);
> -
> -	ret = clk_prepare(sachip->clk);
> -	if (ret)
> -		return ret;
> -
> -	spin_lock_init(&sachip->lock);
> -
> -	sachip->dev = me;
> -	dev_set_drvdata(sachip->dev, sachip);
> -
> -	sachip->pdata = pd;
> -	sachip->phys = mem->start;
> -	sachip->irq = irq;
> -
> -	/*
> -	 * Map the whole region.  This also maps the
> -	 * registers for our children.
> -	 */
> -	sachip->base = ioremap(mem->start, PAGE_SIZE * 2);
> -	if (!sachip->base) {
> -		ret = -ENOMEM;
> -		goto err_clk_unprep;
> -	}
> -
> -	/*
> -	 * Probe for the chip.  Only touch the SBI registers.
> -	 */
> -	id = readl_relaxed(sachip->base + SA1111_SKID);
> -	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
> -		printk(KERN_DEBUG "SA1111 not detected: ID = %08lx\n", id);
> -		ret = -ENODEV;
> -		goto err_unmap;
> -	}
> -
> -	pr_info("SA1111 Microprocessor Companion Chip: silicon revision %lx, metal revision %lx\n",
> -		(id & SKID_SIREV_MASK) >> 4, id & SKID_MTREV_MASK);
> -
> -	/*
> -	 * We found it.  Wake the chip up, and initialise.
> -	 */
> -	sa1111_wake(sachip);
> -
> -	/*
> -	 * The interrupt controller must be initialised before any
> -	 * other device to ensure that the interrupts are available.
> -	 */
> -	ret = sa1111_setup_irq(sachip, pd->irq_base);
> -	if (ret)
> -		goto err_clk;
> -
> -	/* Setup the GPIOs - should really be done after the IRQ setup */
> -	ret = sa1111_setup_gpios(sachip);
> -	if (ret)
> -		goto err_irq;
> -
> -#ifdef CONFIG_ARCH_SA1100
> -	{
> -	unsigned int val;
> -
> -	/*
> -	 * The SDRAM configuration of the SA1110 and the SA1111 must
> -	 * match.  This is very important to ensure that SA1111 accesses
> -	 * don't corrupt the SDRAM.  Note that this ungates the SA1111's
> -	 * MBGNT signal, so we must have called sa1110_mb_disable()
> -	 * beforehand.
> -	 */
> -	sa1111_configure_smc(sachip, 1,
> -			     FExtr(MDCNFG, MDCNFG_SA1110_DRAC0),
> -			     FExtr(MDCNFG, MDCNFG_SA1110_TDL0));
> -
> -	/*
> -	 * We only need to turn on DCLK whenever we want to use the
> -	 * DMA.  It can otherwise be held firmly in the off position.
> -	 * (currently, we always enable it.)
> -	 */
> -	val = readl_relaxed(sachip->base + SA1111_SKPCR);
> -	writel_relaxed(val | SKPCR_DCLKEN, sachip->base + SA1111_SKPCR);
> -
> -	/*
> -	 * Enable the SA1110 memory bus request and grant signals.
> -	 */
> -	sa1110_mb_enable();
> -	}
> -#endif
> -
> -	g_sa1111 = sachip;
> -
> -	has_devs = ~0;
> -	if (pd)
> -		has_devs &= ~pd->disable_devs;
> -
> -	for (i = 0; i < ARRAY_SIZE(sa1111_devices); i++)
> -		if (sa1111_devices[i].devid & has_devs)
> -			sa1111_init_one_child(sachip, mem, &sa1111_devices[i]);
> -
> -	return 0;
> -
> - err_irq:
> -	sa1111_remove_irq(sachip);
> - err_clk:
> -	clk_disable(sachip->clk);
> - err_unmap:
> -	iounmap(sachip->base);
> - err_clk_unprep:
> -	clk_unprepare(sachip->clk);
> -	return ret;
> -}
> -
> -static int sa1111_remove_one(struct device *dev, void *data)
> -{
> -	struct sa1111_dev *sadev = to_sa1111_device(dev);
> -	if (dev->bus != &sa1111_bus_type)
> -		return 0;
> -	device_del(&sadev->dev);
> -	release_resource(&sadev->res);
> -	put_device(&sadev->dev);
> -	return 0;
> -}
> -
> -static void __sa1111_remove(struct sa1111 *sachip)
> -{
> -	device_for_each_child(sachip->dev, NULL, sa1111_remove_one);
> -
> -	sa1111_remove_irq(sachip);
> -
> -	clk_disable(sachip->clk);
> -	clk_unprepare(sachip->clk);
> -
> -	iounmap(sachip->base);
> -}
> -
> -struct sa1111_save_data {
> -	unsigned int	skcr;
> -	unsigned int	skpcr;
> -	unsigned int	skcdr;
> -	unsigned char	skaud;
> -	unsigned char	skpwm0;
> -	unsigned char	skpwm1;
> -
> -	/*
> -	 * Interrupt controller
> -	 */
> -	unsigned int	intpol0;
> -	unsigned int	intpol1;
> -	unsigned int	inten0;
> -	unsigned int	inten1;
> -	unsigned int	wakepol0;
> -	unsigned int	wakepol1;
> -	unsigned int	wakeen0;
> -	unsigned int	wakeen1;
> -};
> -
> -#ifdef CONFIG_PM
> -
> -static int sa1111_suspend_noirq(struct device *dev)
> -{
> -	struct sa1111 *sachip = dev_get_drvdata(dev);
> -	struct sa1111_save_data *save;
> -	unsigned long flags;
> -	unsigned int val;
> -	void __iomem *base;
> -
> -	save = kmalloc_obj(struct sa1111_save_data);
> -	if (!save)
> -		return -ENOMEM;
> -	sachip->saved_state = save;
> -
> -	spin_lock_irqsave(&sachip->lock, flags);
> -
> -	/*
> -	 * Save state.
> -	 */
> -	base = sachip->base;
> -	save->skcr     = readl_relaxed(base + SA1111_SKCR);
> -	save->skpcr    = readl_relaxed(base + SA1111_SKPCR);
> -	save->skcdr    = readl_relaxed(base + SA1111_SKCDR);
> -	save->skaud    = readl_relaxed(base + SA1111_SKAUD);
> -	save->skpwm0   = readl_relaxed(base + SA1111_SKPWM0);
> -	save->skpwm1   = readl_relaxed(base + SA1111_SKPWM1);
> -
> -	writel_relaxed(0, sachip->base + SA1111_SKPWM0);
> -	writel_relaxed(0, sachip->base + SA1111_SKPWM1);
> -
> -	base = sachip->base + SA1111_INTC;
> -	save->intpol0  = readl_relaxed(base + SA1111_INTPOL0);
> -	save->intpol1  = readl_relaxed(base + SA1111_INTPOL1);
> -	save->inten0   = readl_relaxed(base + SA1111_INTEN0);
> -	save->inten1   = readl_relaxed(base + SA1111_INTEN1);
> -	save->wakepol0 = readl_relaxed(base + SA1111_WAKEPOL0);
> -	save->wakepol1 = readl_relaxed(base + SA1111_WAKEPOL1);
> -	save->wakeen0  = readl_relaxed(base + SA1111_WAKEEN0);
> -	save->wakeen1  = readl_relaxed(base + SA1111_WAKEEN1);
> -
> -	/*
> -	 * Disable.
> -	 */
> -	val = readl_relaxed(sachip->base + SA1111_SKCR);
> -	writel_relaxed(val | SKCR_SLEEP, sachip->base + SA1111_SKCR);
> -
> -	clk_disable(sachip->clk);
> -
> -	spin_unlock_irqrestore(&sachip->lock, flags);
> -
> -#ifdef CONFIG_ARCH_SA1100
> -	sa1110_mb_disable();
> -#endif
> -
> -	return 0;
> -}
> -
> -/*
> - *	sa1111_resume - Restore the SA1111 device state.
> - *	@dev: device to restore
> - *
> - *	Restore the general state of the SA1111; clock control and
> - *	interrupt controller.  Other parts of the SA1111 must be
> - *	restored by their respective drivers, and must be called
> - *	via LDM after this function.
> - */
> -static int sa1111_resume_noirq(struct device *dev)
> -{
> -	struct sa1111 *sachip = dev_get_drvdata(dev);
> -	struct sa1111_save_data *save;
> -	unsigned long flags, id;
> -	void __iomem *base;
> -
> -	save = sachip->saved_state;
> -	if (!save)
> -		return 0;
> -
> -	/*
> -	 * Ensure that the SA1111 is still here.
> -	 * FIXME: shouldn't do this here.
> -	 */
> -	id = readl_relaxed(sachip->base + SA1111_SKID);
> -	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
> -		__sa1111_remove(sachip);
> -		dev_set_drvdata(dev, NULL);
> -		kfree(save);
> -		return 0;
> -	}
> -
> -	/*
> -	 * First of all, wake up the chip.
> -	 */
> -	sa1111_wake(sachip);
> -
> -#ifdef CONFIG_ARCH_SA1100
> -	/* Enable the memory bus request/grant signals */
> -	sa1110_mb_enable();
> -#endif
> -
> -	/*
> -	 * Only lock for write ops. Also, sa1111_wake must be called with
> -	 * released spinlock!
> -	 */
> -	spin_lock_irqsave(&sachip->lock, flags);
> -
> -	writel_relaxed(0, sachip->base + SA1111_INTC + SA1111_INTEN0);
> -	writel_relaxed(0, sachip->base + SA1111_INTC + SA1111_INTEN1);
> -
> -	base = sachip->base;
> -	writel_relaxed(save->skcr,     base + SA1111_SKCR);
> -	writel_relaxed(save->skpcr,    base + SA1111_SKPCR);
> -	writel_relaxed(save->skcdr,    base + SA1111_SKCDR);
> -	writel_relaxed(save->skaud,    base + SA1111_SKAUD);
> -	writel_relaxed(save->skpwm0,   base + SA1111_SKPWM0);
> -	writel_relaxed(save->skpwm1,   base + SA1111_SKPWM1);
> -
> -	base = sachip->base + SA1111_INTC;
> -	writel_relaxed(save->intpol0,  base + SA1111_INTPOL0);
> -	writel_relaxed(save->intpol1,  base + SA1111_INTPOL1);
> -	writel_relaxed(save->inten0,   base + SA1111_INTEN0);
> -	writel_relaxed(save->inten1,   base + SA1111_INTEN1);
> -	writel_relaxed(save->wakepol0, base + SA1111_WAKEPOL0);
> -	writel_relaxed(save->wakepol1, base + SA1111_WAKEPOL1);
> -	writel_relaxed(save->wakeen0,  base + SA1111_WAKEEN0);
> -	writel_relaxed(save->wakeen1,  base + SA1111_WAKEEN1);
> -
> -	spin_unlock_irqrestore(&sachip->lock, flags);
> -
> -	sachip->saved_state = NULL;
> -	kfree(save);
> -
> -	return 0;
> -}
> -
> -#else
> -#define sa1111_suspend_noirq NULL
> -#define sa1111_resume_noirq  NULL
> -#endif
> -
> -/**
> - *	sa1111_probe - probe for a single SA1111 chip.
> - *	@pdev: platform device.
> - *
> - *	Probe for a SA1111 chip.  This must be called
> - *	before any other SA1111-specific code.
> - *
> - *	Returns:
> - *	* %-ENODEV	- device not found.
> - *	* %-ENOMEM	- memory allocation failure.
> - *	* %-EBUSY	- physical address already marked in-use.
> - *	* %-EINVAL	- no platform data passed
> - *	* %0		- successful.
> - */
> -static int sa1111_probe(struct platform_device *pdev)
> -{
> -	struct resource *mem;
> -	int irq;
> -
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!mem)
> -		return -EINVAL;
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> -
> -	return __sa1111_probe(&pdev->dev, mem, irq);
> -}
> -
> -static void sa1111_remove(struct platform_device *pdev)
> -{
> -	struct sa1111 *sachip = platform_get_drvdata(pdev);
> -
> -	if (sachip) {
> -#ifdef CONFIG_PM
> -		kfree(sachip->saved_state);
> -		sachip->saved_state = NULL;
> -#endif
> -		__sa1111_remove(sachip);
> -		platform_set_drvdata(pdev, NULL);
> -	}
> -}
> -
> -static struct dev_pm_ops sa1111_pm_ops = {
> -	.suspend_noirq = sa1111_suspend_noirq,
> -	.resume_noirq = sa1111_resume_noirq,
> -};
> -
> -/*
> - *	Not sure if this should be on the system bus or not yet.
> - *	We really want some way to register a system device at
> - *	the per-machine level, and then have this driver pick
> - *	up the registered devices.
> - *
> - *	We also need to handle the SDRAM configuration for
> - *	PXA250/SA1110 machine classes.
> - */
> -static struct platform_driver sa1111_device_driver = {
> -	.probe		= sa1111_probe,
> -	.remove		= sa1111_remove,
> -	.driver		= {
> -		.name	= "sa1111",
> -		.pm	= &sa1111_pm_ops,
> -	},
> -};
> -
> -/*
> - *	Get the parent device driver (us) structure
> - *	from a child function device
> - */
> -static inline struct sa1111 *sa1111_chip_driver(struct sa1111_dev *sadev)
> -{
> -	return (struct sa1111 *)dev_get_drvdata(sadev->dev.parent);
> -}
> -
> -/*
> - * The bits in the opdiv field are non-linear.
> - */
> -static unsigned char opdiv_table[] = { 1, 4, 2, 8 };
> -
> -static unsigned int __sa1111_pll_clock(struct sa1111 *sachip)
> -{
> -	unsigned int skcdr, fbdiv, ipdiv, opdiv;
> -
> -	skcdr = readl_relaxed(sachip->base + SA1111_SKCDR);
> -
> -	fbdiv = (skcdr & 0x007f) + 2;
> -	ipdiv = ((skcdr & 0x0f80) >> 7) + 2;
> -	opdiv = opdiv_table[(skcdr & 0x3000) >> 12];
> -
> -	return 3686400 * fbdiv / (ipdiv * opdiv);
> -}
> -
> -/**
> - *	sa1111_pll_clock - return the current PLL clock frequency.
> - *	@sadev: SA1111 function block
> - *
> - *	BUG: we should look at SKCR.  We also blindly believe that
> - *	the chip is being fed with the 3.6864MHz clock.
> - *
> - *	Returns the PLL clock in Hz.
> - */
> -unsigned int sa1111_pll_clock(struct sa1111_dev *sadev)
> -{
> -	struct sa1111 *sachip = sa1111_chip_driver(sadev);
> -
> -	return __sa1111_pll_clock(sachip);
> -}
> -EXPORT_SYMBOL(sa1111_pll_clock);
> -
> -/**
> - *	sa1111_select_audio_mode - select I2S or AC link mode
> - *	@sadev: SA1111 function block
> - *	@mode: One of %SA1111_AUDIO_ACLINK or %SA1111_AUDIO_I2S
> - *
> - *	Frob the SKCR to select AC Link mode or I2S mode for
> - *	the audio block.
> - */
> -void sa1111_select_audio_mode(struct sa1111_dev *sadev, int mode)
> -{
> -	struct sa1111 *sachip = sa1111_chip_driver(sadev);
> -	unsigned long flags;
> -	unsigned int val;
> -
> -	spin_lock_irqsave(&sachip->lock, flags);
> -
> -	val = readl_relaxed(sachip->base + SA1111_SKCR);
> -	if (mode == SA1111_AUDIO_I2S) {
> -		val &= ~SKCR_SELAC;
> -	} else {
> -		val |= SKCR_SELAC;
> -	}
> -	writel_relaxed(val, sachip->base + SA1111_SKCR);
> -
> -	spin_unlock_irqrestore(&sachip->lock, flags);
> -}
> -EXPORT_SYMBOL(sa1111_select_audio_mode);
> -
> -/**
> - *	sa1111_set_audio_rate - set the audio sample rate
> - *	@sadev: SA1111 SAC function block
> - *	@rate: sample rate to select
> - */
> -int sa1111_set_audio_rate(struct sa1111_dev *sadev, int rate)
> -{
> -	struct sa1111 *sachip = sa1111_chip_driver(sadev);
> -	unsigned int div;
> -
> -	if (sadev->devid != SA1111_DEVID_SAC)
> -		return -EINVAL;
> -
> -	div = (__sa1111_pll_clock(sachip) / 256 + rate / 2) / rate;
> -	if (div == 0)
> -		div = 1;
> -	if (div > 128)
> -		div = 128;
> -
> -	writel_relaxed(div - 1, sachip->base + SA1111_SKAUD);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(sa1111_set_audio_rate);
> -
> -/**
> - *	sa1111_get_audio_rate - get the audio sample rate
> - *	@sadev: SA1111 SAC function block device
> - */
> -int sa1111_get_audio_rate(struct sa1111_dev *sadev)
> -{
> -	struct sa1111 *sachip = sa1111_chip_driver(sadev);
> -	unsigned long div;
> -
> -	if (sadev->devid != SA1111_DEVID_SAC)
> -		return -EINVAL;
> -
> -	div = readl_relaxed(sachip->base + SA1111_SKAUD) + 1;
> -
> -	return __sa1111_pll_clock(sachip) / (256 * div);
> -}
> -EXPORT_SYMBOL(sa1111_get_audio_rate);
> -
> -/*
> - * Individual device operations.
> - */
> -
> -/**
> - *	sa1111_enable_device - enable an on-chip SA1111 function block
> - *	@sadev: SA1111 function block device to enable
> - */
> -int sa1111_enable_device(struct sa1111_dev *sadev)
> -{
> -	struct sa1111 *sachip = sa1111_chip_driver(sadev);
> -	unsigned long flags;
> -	unsigned int val;
> -	int ret = 0;
> -
> -	if (sachip->pdata && sachip->pdata->enable)
> -		ret = sachip->pdata->enable(sachip->pdata->data, sadev->devid);
> -
> -	if (ret == 0) {
> -		spin_lock_irqsave(&sachip->lock, flags);
> -		val = readl_relaxed(sachip->base + SA1111_SKPCR);
> -		writel_relaxed(val | sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
> -		spin_unlock_irqrestore(&sachip->lock, flags);
> -	}
> -	return ret;
> -}
> -EXPORT_SYMBOL(sa1111_enable_device);
> -
> -/**
> - *	sa1111_disable_device - disable an on-chip SA1111 function block
> - *	@sadev: SA1111 function block device to disable
> - */
> -void sa1111_disable_device(struct sa1111_dev *sadev)
> -{
> -	struct sa1111 *sachip = sa1111_chip_driver(sadev);
> -	unsigned long flags;
> -	unsigned int val;
> -
> -	spin_lock_irqsave(&sachip->lock, flags);
> -	val = readl_relaxed(sachip->base + SA1111_SKPCR);
> -	writel_relaxed(val & ~sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
> -	spin_unlock_irqrestore(&sachip->lock, flags);
> -
> -	if (sachip->pdata && sachip->pdata->disable)
> -		sachip->pdata->disable(sachip->pdata->data, sadev->devid);
> -}
> -EXPORT_SYMBOL(sa1111_disable_device);
> -
> -int sa1111_get_irq(struct sa1111_dev *sadev, unsigned num)
> -{
> -	struct sa1111 *sachip = sa1111_chip_driver(sadev);
> -	if (num >= ARRAY_SIZE(sadev->hwirq))
> -		return -EINVAL;
> -	return sa1111_map_irq(sachip, sadev->hwirq[num]);
> -}
> -EXPORT_SYMBOL_GPL(sa1111_get_irq);
> -
> -/*
> - *	SA1111 "Register Access Bus."
> - *
> - *	We model this as a regular bus type, and hang devices directly
> - *	off this.
> - */
> -static int sa1111_match(struct device *_dev, const struct device_driver *_drv)
> -{
> -	struct sa1111_dev *dev = to_sa1111_device(_dev);
> -	const struct sa1111_driver *drv = SA1111_DRV(_drv);
> -
> -	return !!(dev->devid & drv->devid);
> -}
> -
> -static int sa1111_bus_probe(struct device *dev)
> -{
> -	struct sa1111_dev *sadev = to_sa1111_device(dev);
> -	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
> -	int ret = -ENODEV;
> -
> -	if (drv->probe)
> -		ret = drv->probe(sadev);
> -	return ret;
> -}
> -
> -static void sa1111_bus_remove(struct device *dev)
> -{
> -	struct sa1111_dev *sadev = to_sa1111_device(dev);
> -	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
> -
> -	if (drv->remove)
> -		drv->remove(sadev);
> -}
> -
> -const struct bus_type sa1111_bus_type = {
> -	.name		= "sa1111-rab",
> -	.match		= sa1111_match,
> -	.probe		= sa1111_bus_probe,
> -	.remove		= sa1111_bus_remove,
> -};
> -EXPORT_SYMBOL(sa1111_bus_type);
> -
> -int sa1111_driver_register(struct sa1111_driver *driver)
> -{
> -	driver->drv.bus = &sa1111_bus_type;
> -	return driver_register(&driver->drv);
> -}
> -EXPORT_SYMBOL(sa1111_driver_register);
> -
> -void sa1111_driver_unregister(struct sa1111_driver *driver)
> -{
> -	driver_unregister(&driver->drv);
> -}
> -EXPORT_SYMBOL(sa1111_driver_unregister);
> -
> -static int __init sa1111_init(void)
> -{
> -	int ret = bus_register(&sa1111_bus_type);
> -	if (ret == 0)
> -		platform_driver_register(&sa1111_device_driver);
> -	return ret;
> -}
> -
> -static void __exit sa1111_exit(void)
> -{
> -	platform_driver_unregister(&sa1111_device_driver);
> -	bus_unregister(&sa1111_bus_type);
> -}
> -
> -subsys_initcall(sa1111_init);
> -module_exit(sa1111_exit);
> -
> -MODULE_DESCRIPTION("Intel Corporation SA1111 core driver");
> -MODULE_LICENSE("GPL");
> diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
> deleted file mode 100644
> index e4264fdac2e5..000000000000
> --- a/arch/arm/configs/assabet_defconfig
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -CONFIG_SYSVIPC=y
> -CONFIG_LOG_BUF_SHIFT=14
> -CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EXPERT=y
> -CONFIG_ARCH_MULTI_V4=y
> -# CONFIG_ARCH_MULTI_V7 is not set
> -CONFIG_ARCH_SA1100=y
> -CONFIG_SA1100_ASSABET=y
> -# CONFIG_AEABI is not set
> -CONFIG_ATAGS=y
> -CONFIG_CMDLINE="mem=32M console=ttySA0,38400n8 initrd=0xc0800000,3M root=/dev/ram"
> -CONFIG_FPE_NWFPE=y
> -CONFIG_PM=y
> -CONFIG_MODULES=y
> -CONFIG_PARTITION_ADVANCED=y
> -CONFIG_NET=y
> -CONFIG_UNIX=y
> -CONFIG_INET=y
> -# CONFIG_IPV6 is not set
> -CONFIG_PCCARD=y
> -CONFIG_PCMCIA_SA1100=y
> -CONFIG_MTD=y
> -CONFIG_MTD_REDBOOT_PARTS=y
> -CONFIG_MTD_BLOCK=y
> -CONFIG_MTD_CFI=y
> -CONFIG_MTD_CFI_ADV_OPTIONS=y
> -CONFIG_MTD_CFI_GEOMETRY=y
> -# CONFIG_MTD_CFI_I1 is not set
> -CONFIG_MTD_CFI_INTELEXT=y
> -CONFIG_MTD_SA1100=y
> -CONFIG_BLK_DEV_LOOP=m
> -CONFIG_BLK_DEV_RAM=y
> -CONFIG_NETDEVICES=y
> -CONFIG_NET_PCMCIA=y
> -CONFIG_PCMCIA_PCNET=y
> -CONFIG_INPUT_EVDEV=y
> -# CONFIG_INPUT_KEYBOARD is not set
> -# CONFIG_INPUT_MOUSE is not set
> -# CONFIG_SERIO is not set
> -CONFIG_SERIAL_8250=m
> -CONFIG_SERIAL_SA1100=y
> -CONFIG_SERIAL_SA1100_CONSOLE=y
> -CONFIG_FB=y
> -CONFIG_FB_SA1100=y
> -# CONFIG_VGA_CONSOLE is not set
> -CONFIG_SOUND=y
> -CONFIG_NEW_LEDS=y
> -CONFIG_LEDS_CLASS=y
> -CONFIG_LEDS_TRIGGERS=y
> -CONFIG_LEDS_TRIGGER_CPU=y
> -CONFIG_EXT2_FS=y
> -CONFIG_MSDOS_FS=y
> -CONFIG_TMPFS=y
> -CONFIG_JFFS2_FS=y
> -CONFIG_NFS_FS=y
> -CONFIG_NLS_CODEPAGE_437=y
> -CONFIG_DEBUG_USER=y
> diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
> deleted file mode 100644
> index 570a5f8bc57b..000000000000
> --- a/arch/arm/configs/collie_defconfig
> +++ /dev/null
> @@ -1,87 +0,0 @@
> -CONFIG_SYSVIPC=y
> -CONFIG_LOG_BUF_SHIFT=14
> -CONFIG_BLK_DEV_INITRD=y
> -# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> -CONFIG_EXPERT=y
> -CONFIG_BASE_SMALL=y
> -# CONFIG_EPOLL is not set
> -CONFIG_ARCH_MULTI_V4=y
> -# CONFIG_ARCH_MULTI_V7 is not set
> -CONFIG_ARCH_SA1100=y
> -CONFIG_SA1100_COLLIE=y
> -CONFIG_ATAGS=y
> -CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
> -CONFIG_PM=y
> -# CONFIG_SWAP is not set
> -CONFIG_SLUB_TINY=y
> -CONFIG_NET=y
> -CONFIG_PACKET=y
> -CONFIG_UNIX=y
> -CONFIG_INET=y
> -# CONFIG_IPV6 is not set
> -CONFIG_PCCARD=y
> -CONFIG_PCMCIA_SA1100=y
> -CONFIG_PCMCIA_DEBUG=y
> -CONFIG_MTD=y
> -CONFIG_MTD_BLOCK=y
> -CONFIG_MTD_CFI=y
> -CONFIG_MTD_JEDECPROBE=y
> -CONFIG_MTD_CFI_ADV_OPTIONS=y
> -CONFIG_MTD_CFI_GEOMETRY=y
> -# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
> -# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
> -# CONFIG_MTD_CFI_I1 is not set
> -# CONFIG_MTD_CFI_I2 is not set
> -CONFIG_MTD_CFI_I4=y
> -CONFIG_MTD_CFI_INTELEXT=y
> -CONFIG_MTD_SA1100=y
> -CONFIG_BLK_DEV_LOOP=y
> -CONFIG_BLK_DEV_RAM=y
> -CONFIG_BLK_DEV_RAM_SIZE=1024
> -CONFIG_BLK_DEV_SD=y
> -CONFIG_ATA=y
> -CONFIG_PATA_PCMCIA=y
> -# CONFIG_INPUT_MOUSEDEV is not set
> -CONFIG_INPUT_EVDEV=y
> -# CONFIG_KEYBOARD_ATKBD is not set
> -CONFIG_KEYBOARD_LOCOMO=y
> -# CONFIG_INPUT_MOUSE is not set
> -CONFIG_INPUT_TOUCHSCREEN=y
> -# CONFIG_SERIO_SERPORT is not set
> -# CONFIG_LEGACY_PTYS is not set
> -CONFIG_SERIAL_8250=y
> -CONFIG_SERIAL_8250_CS=y
> -CONFIG_SERIAL_8250_EXTENDED=y
> -CONFIG_SERIAL_SA1100=y
> -CONFIG_SERIAL_SA1100_CONSOLE=y
> -# CONFIG_HWMON is not set
> -CONFIG_MCP_SA11X0=y
> -CONFIG_MCP_UCB1200=y
> -CONFIG_MCP_UCB1200_TS=y
> -CONFIG_FB=y
> -CONFIG_FB_SA1100=y
> -# CONFIG_VGA_CONSOLE is not set
> -CONFIG_FB_MODE_HELPERS=y
> -CONFIG_FRAMEBUFFER_CONSOLE=y
> -CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> -CONFIG_NEW_LEDS=y
> -CONFIG_LEDS_CLASS=y
> -CONFIG_LEDS_LOCOMO=y
> -CONFIG_LEDS_TRIGGERS=y
> -CONFIG_LEDS_TRIGGER_TIMER=y
> -CONFIG_LEDS_TRIGGER_DISK=y
> -# CONFIG_DNOTIFY is not set
> -CONFIG_VFAT_FS=y
> -CONFIG_TMPFS=y
> -CONFIG_JFFS2_FS=y
> -CONFIG_ROMFS_FS=y
> -CONFIG_NLS_DEFAULT="cp437"
> -CONFIG_NLS_CODEPAGE_437=y
> -CONFIG_NLS_ISO8859_1=y
> -CONFIG_FONTS=y
> -CONFIG_FONT_MINI_4x6=y
> -# CONFIG_DEBUG_BUGVERBOSE is not set
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_DEBUG_KERNEL=y
> -# CONFIG_DETECT_SOFTLOCKUP is not set
> -CONFIG_DEBUG_MUTEXES=y
> diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
> deleted file mode 100644
> index 3e8da62d959d..000000000000
> --- a/arch/arm/configs/h3600_defconfig
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -CONFIG_SYSVIPC=y
> -CONFIG_NO_HZ_IDLE=y
> -CONFIG_HIGH_RES_TIMERS=y
> -CONFIG_PREEMPT=y
> -CONFIG_LOG_BUF_SHIFT=14
> -CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EXPERT=y
> -CONFIG_ARCH_MULTI_V4=y
> -# CONFIG_ARCH_MULTI_V7 is not set
> -CONFIG_ARCH_SA1100=y
> -CONFIG_SA1100_H3600=y
> -# CONFIG_CPU_FREQ_STAT is not set
> -CONFIG_ATAGS=y
> -CONFIG_MODULES=y
> -CONFIG_NET=y
> -CONFIG_UNIX=y
> -CONFIG_INET=y
> -# CONFIG_IPV6 is not set
> -# CONFIG_WIRELESS is not set
> -CONFIG_PCCARD=y
> -CONFIG_PCMCIA_SA1100=y
> -CONFIG_MTD=y
> -CONFIG_MTD_REDBOOT_PARTS=y
> -CONFIG_MTD_BLOCK=y
> -CONFIG_MTD_CFI=y
> -CONFIG_MTD_CFI_ADV_OPTIONS=y
> -CONFIG_MTD_CFI_GEOMETRY=y
> -# CONFIG_MTD_CFI_I1 is not set
> -CONFIG_MTD_CFI_INTELEXT=y
> -CONFIG_MTD_SA1100=y
> -CONFIG_BLK_DEV_LOOP=m
> -CONFIG_BLK_DEV_RAM=y
> -CONFIG_BLK_DEV_RAM_SIZE=8192
> -CONFIG_BLK_DEV_SD=y
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_ATA=y
> -CONFIG_PATA_PCMCIA=y
> -CONFIG_NETDEVICES=y
> -CONFIG_PCMCIA_PCNET=y
> -CONFIG_PPP=m
> -CONFIG_PPP_BSDCOMP=m
> -CONFIG_PPP_DEFLATE=m
> -CONFIG_PPP_ASYNC=m
> -# CONFIG_WLAN is not set
> -# CONFIG_KEYBOARD_ATKBD is not set
> -CONFIG_KEYBOARD_GPIO=y
> -# CONFIG_INPUT_MOUSE is not set
> -# CONFIG_SERIO is not set
> -CONFIG_SERIAL_SA1100=y
> -CONFIG_SERIAL_SA1100_CONSOLE=y
> -# CONFIG_HW_RANDOM is not set
> -# CONFIG_HWMON is not set
> -CONFIG_FB=y
> -CONFIG_FB_SA1100=y
> -# CONFIG_USB_SUPPORT is not set
> -CONFIG_EXT2_FS=y
> -CONFIG_MSDOS_FS=m
> -CONFIG_VFAT_FS=m
> -CONFIG_JFFS2_FS=y
> -CONFIG_CRAMFS=m
> -CONFIG_NFS_FS=y
> -CONFIG_NFSD=m
> -CONFIG_NLS=y
> diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
> deleted file mode 100644
> index a96cfb81aba5..000000000000
> --- a/arch/arm/configs/jornada720_defconfig
> +++ /dev/null
> @@ -1,95 +0,0 @@
> -CONFIG_SYSVIPC=y
> -CONFIG_LOG_BUF_SHIFT=14
> -CONFIG_EXPERT=y
> -CONFIG_ARCH_MULTI_V4=y
> -# CONFIG_ARCH_MULTI_V7 is not set
> -CONFIG_ARCH_SA1100=y
> -CONFIG_SA1100_JORNADA720=y
> -CONFIG_SA1100_JORNADA720_SSP=y
> -CONFIG_PM=y
> -CONFIG_ATAGS=y
> -CONFIG_MODULES=y
> -CONFIG_NET=y
> -CONFIG_PACKET=y
> -CONFIG_UNIX=y
> -CONFIG_INET=y
> -CONFIG_IP_MULTICAST=y
> -# CONFIG_IPV6 is not set
> -CONFIG_NETFILTER=y
> -CONFIG_PCCARD=y
> -CONFIG_PCMCIA_SA1100=y
> -CONFIG_BLK_DEV_LOOP=y
> -CONFIG_BLK_DEV_NBD=y
> -CONFIG_BLK_DEV_SD=y
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_ATA=y
> -CONFIG_PATA_PCMCIA=y
> -CONFIG_NETDEVICES=y
> -CONFIG_DUMMY=y
> -CONFIG_NET_PCMCIA=y
> -CONFIG_INPUT_MOUSEDEV_SCREEN_X=640
> -CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
> -# CONFIG_KEYBOARD_ATKBD is not set
> -CONFIG_KEYBOARD_HP7XX=y
> -# CONFIG_INPUT_MOUSE is not set
> -CONFIG_INPUT_TOUCHSCREEN=y
> -CONFIG_TOUCHSCREEN_HP7XX=y
> -CONFIG_LEGACY_PTY_COUNT=32
> -CONFIG_SERIAL_SA1100=y
> -CONFIG_SERIAL_SA1100_CONSOLE=y
> -# CONFIG_HWMON is not set
> -CONFIG_FB=y
> -CONFIG_FB_S1D13XXX=y
> -CONFIG_LCD_CLASS_DEVICE=y
> -CONFIG_BACKLIGHT_CLASS_DEVICE=y
> -# CONFIG_VGA_CONSOLE is not set
> -CONFIG_FRAMEBUFFER_CONSOLE=y
> -CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> -# CONFIG_USB_SUPPORT is not set
> -CONFIG_RTC_CLASS=y
> -CONFIG_RTC_DRV_SA1100=y
> -CONFIG_EXT2_FS=y
> -CONFIG_MSDOS_FS=y
> -CONFIG_VFAT_FS=y
> -# CONFIG_NETWORK_FILESYSTEMS is not set
> -CONFIG_NLS_CODEPAGE_437=m
> -CONFIG_NLS_CODEPAGE_737=m
> -CONFIG_NLS_CODEPAGE_775=m
> -CONFIG_NLS_CODEPAGE_850=m
> -CONFIG_NLS_CODEPAGE_852=m
> -CONFIG_NLS_CODEPAGE_855=m
> -CONFIG_NLS_CODEPAGE_857=m
> -CONFIG_NLS_CODEPAGE_860=m
> -CONFIG_NLS_CODEPAGE_861=m
> -CONFIG_NLS_CODEPAGE_862=m
> -CONFIG_NLS_CODEPAGE_863=m
> -CONFIG_NLS_CODEPAGE_864=m
> -CONFIG_NLS_CODEPAGE_865=m
> -CONFIG_NLS_CODEPAGE_866=m
> -CONFIG_NLS_CODEPAGE_869=m
> -CONFIG_NLS_CODEPAGE_936=m
> -CONFIG_NLS_CODEPAGE_950=m
> -CONFIG_NLS_CODEPAGE_932=m
> -CONFIG_NLS_CODEPAGE_949=m
> -CONFIG_NLS_CODEPAGE_874=m
> -CONFIG_NLS_ISO8859_8=m
> -CONFIG_NLS_CODEPAGE_1250=m
> -CONFIG_NLS_CODEPAGE_1251=m
> -CONFIG_NLS_ASCII=m
> -CONFIG_NLS_ISO8859_1=m
> -CONFIG_NLS_ISO8859_2=m
> -CONFIG_NLS_ISO8859_3=m
> -CONFIG_NLS_ISO8859_4=m
> -CONFIG_NLS_ISO8859_5=m
> -CONFIG_NLS_ISO8859_6=m
> -CONFIG_NLS_ISO8859_7=m
> -CONFIG_NLS_ISO8859_9=m
> -CONFIG_NLS_ISO8859_13=m
> -CONFIG_NLS_ISO8859_14=m
> -CONFIG_NLS_ISO8859_15=m
> -CONFIG_NLS_KOI8_R=m
> -CONFIG_NLS_KOI8_U=m
> -CONFIG_NLS_UTF8=m
> -CONFIG_DEBUG_KERNEL=y
> -# CONFIG_FTRACE is not set
> -CONFIG_DEBUG_LL=y
> diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
> deleted file mode 100644
> index 164643f1b6c0..000000000000
> --- a/arch/arm/configs/neponset_defconfig
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -CONFIG_SYSVIPC=y
> -CONFIG_LOG_BUF_SHIFT=14
> -CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EXPERT=y
> -CONFIG_ARCH_MULTI_V4=y
> -# CONFIG_ARCH_MULTI_V7 is not set
> -CONFIG_ARCH_SA1100=y
> -CONFIG_SA1100_ASSABET=y
> -CONFIG_ASSABET_NEPONSET=y
> -CONFIG_ATAGS=y
> -CONFIG_ZBOOT_ROM_TEXT=0x80000
> -CONFIG_ZBOOT_ROM_BSS=0xc1000000
> -CONFIG_ZBOOT_ROM=y
> -CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) mem=32M noinitrd initrd=0xc0800000,3M"
> -CONFIG_FPE_NWFPE=y
> -# CONFIG_AEABI is not set
> -CONFIG_PM=y
> -CONFIG_MODULES=y
> -CONFIG_MODULE_UNLOAD=y
> -CONFIG_PARTITION_ADVANCED=y
> -# CONFIG_MSDOS_PARTITION is not set
> -CONFIG_NET=y
> -CONFIG_PACKET=y
> -CONFIG_UNIX=y
> -CONFIG_INET=y
> -# CONFIG_IPV6 is not set
> -CONFIG_PCCARD=y
> -CONFIG_PCMCIA_SA1100=y
> -CONFIG_PCMCIA_SA1111=y
> -CONFIG_MTD=y
> -CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_REDBOOT_PARTS=y
> -CONFIG_MTD_BLOCK=y
> -CONFIG_MTD_CFI=y
> -CONFIG_MTD_CFI_ADV_OPTIONS=y
> -CONFIG_MTD_CFI_INTELEXT=y
> -CONFIG_MTD_RAM=y
> -CONFIG_MTD_SA1100=y
> -CONFIG_BLK_DEV_RAM=y
> -CONFIG_BLK_DEV_RAM_SIZE=8192
> -CONFIG_SCSI=m
> -CONFIG_BLK_DEV_SD=m
> -CONFIG_NETDEVICES=y
> -CONFIG_NET_VENDOR_SMC=y
> -CONFIG_PCMCIA_PCNET=y
> -CONFIG_SMC91X=y
> -CONFIG_NET_PCMCIA=y
> -# CONFIG_INPUT_MOUSE is not set
> -CONFIG_INPUT_TOUCHSCREEN=y
> -CONFIG_SERIO_SERPORT=m
> -CONFIG_SERIO_SA1111=y
> -CONFIG_LEGACY_PTY_COUNT=64
> -CONFIG_SERIAL_8250=y
> -CONFIG_SERIAL_8250_CS=y
> -CONFIG_SERIAL_SA1100=y
> -CONFIG_SERIAL_SA1100_CONSOLE=y
> -CONFIG_SERIAL_NONSTANDARD=y
> -CONFIG_I2C=y
> -CONFIG_I2C_CHARDEV=y
> -CONFIG_WATCHDOG=y
> -CONFIG_SA1100_WATCHDOG=m
> -CONFIG_FB=y
> -CONFIG_FB_SA1100=y
> -# CONFIG_VGA_CONSOLE is not set
> -CONFIG_FRAMEBUFFER_CONSOLE=y
> -CONFIG_SOUND=y
> -CONFIG_SOUND_PRIME=y
> -# CONFIG_USB_HID is not set
> -CONFIG_USB=m
> -CONFIG_USB_MON=m
> -CONFIG_USB_OHCI_HCD=m
> -CONFIG_USB_STORAGE=m
> -CONFIG_NEW_LEDS=y
> -CONFIG_LEDS_CLASS=y
> -CONFIG_LEDS_TRIGGERS=y
> -CONFIG_LEDS_TRIGGER_CPU=y
> -CONFIG_EXT2_FS=y
> -CONFIG_MSDOS_FS=m
> -CONFIG_VFAT_FS=m
> -CONFIG_JFFS2_FS=y
> -CONFIG_NFS_FS=y
> -CONFIG_NLS=y
> -CONFIG_NLS_CODEPAGE_437=m
> -CONFIG_NLS_ISO8859_1=m
> -CONFIG_DEBUG_KERNEL=y
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_DEBUG_USER=y
> -CONFIG_DEBUG_LL=y
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 0163c3e78a67..d58f6b5c4c35 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -262,10 +262,6 @@ static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
>  	return read_cpuid(CPUID_MPIDR);
>  }
>  
> -/* StrongARM-11x0 CPUs */
> -#define cpu_is_sa1100() (read_cpuid_part() == ARM_CPU_PART_SA1100)
> -#define cpu_is_sa1110() (read_cpuid_part() == ARM_CPU_PART_SA1110)
> -
>  /*
>   * Intel's XScale3 core supports some v6 features (supersections, L2)
>   * but advertises itself as v5 as it does not support the v6 ISA.  For
> diff --git a/arch/arm/include/asm/hardware/locomo.h b/arch/arm/include/asm/hardware/locomo.h
> deleted file mode 100644
> index 3190e1e5067a..000000000000
> --- a/arch/arm/include/asm/hardware/locomo.h
> +++ /dev/null
> @@ -1,217 +0,0 @@
> -/*
> - * arch/arm/include/asm/hardware/locomo.h
> - *
> - * This file contains the definitions for the LoCoMo G/A Chip
> - *
> - * (C) Copyright 2004 John Lenz
> - *
> - * May be copied or modified under the terms of the GNU General Public
> - * License.  See linux/COPYING for more information.
> - *
> - * Based on sa1111.h
> - */
> -#ifndef _ASM_ARCH_LOCOMO
> -#define _ASM_ARCH_LOCOMO
> -
> -#define locomo_writel(val,addr)	({ *(volatile u16 *)(addr) = (val); })
> -#define locomo_readl(addr)	(*(volatile u16 *)(addr))
> -
> -/* LOCOMO version */
> -#define LOCOMO_VER	0x00
> -
> -/* Pin status */
> -#define LOCOMO_ST	0x04
> -
> -/* Pin status */
> -#define LOCOMO_C32K	0x08
> -
> -/* Interrupt controller */
> -#define LOCOMO_ICR	0x0C
> -
> -/* MCS decoder for boot selecting */
> -#define LOCOMO_MCSX0	0x10
> -#define LOCOMO_MCSX1	0x14
> -#define LOCOMO_MCSX2	0x18
> -#define LOCOMO_MCSX3	0x1c
> -
> -/* Touch panel controller */
> -#define LOCOMO_ASD	0x20		/* AD start delay */
> -#define LOCOMO_HSD	0x28		/* HSYS delay */
> -#define LOCOMO_HSC	0x2c		/* HSYS period */
> -#define LOCOMO_TADC	0x30		/* tablet ADC clock */
> -
> -
> -/* Long time timer */
> -#define LOCOMO_LTC	0xd8		/* LTC interrupt setting */
> -#define LOCOMO_LTINT	0xdc		/* LTC interrupt */
> -
> -/* DAC control signal for LCD (COMADJ ) */
> -#define LOCOMO_DAC		0xe0
> -/* DAC control */
> -#define	LOCOMO_DAC_SCLOEB	0x08	/* SCL pin output data       */
> -#define	LOCOMO_DAC_TEST		0x04	/* Test bit                  */
> -#define	LOCOMO_DAC_SDA		0x02	/* SDA pin level (read-only) */
> -#define	LOCOMO_DAC_SDAOEB	0x01	/* SDA pin output data       */
> -
> -/* SPI interface */
> -#define LOCOMO_SPI	0x60
> -#define LOCOMO_SPIMD	0x00		/* SPI mode setting */
> -#define LOCOMO_SPICT	0x04		/* SPI mode control */
> -#define LOCOMO_SPIST	0x08		/* SPI status */
> -#define	LOCOMO_SPI_TEND	(1 << 3)	/* Transfer end bit */
> -#define	LOCOMO_SPI_REND	(1 << 2)	/* Receive end bit */
> -#define	LOCOMO_SPI_RFW	(1 << 1)	/* write buffer bit */
> -#define	LOCOMO_SPI_RFR	(1)		/* read buffer bit */
> -
> -#define LOCOMO_SPIIS	0x10		/* SPI interrupt status */
> -#define LOCOMO_SPIWE	0x14		/* SPI interrupt status write enable */
> -#define LOCOMO_SPIIE	0x18		/* SPI interrupt enable */
> -#define LOCOMO_SPIIR	0x1c		/* SPI interrupt request */
> -#define LOCOMO_SPITD	0x20		/* SPI transfer data write */
> -#define LOCOMO_SPIRD	0x24		/* SPI receive data read */
> -#define LOCOMO_SPITS	0x28		/* SPI transfer data shift */
> -#define LOCOMO_SPIRS	0x2C		/* SPI receive data shift */
> -
> -/* GPIO */
> -#define LOCOMO_GPD		0x90	/* GPIO direction */
> -#define LOCOMO_GPE		0x94	/* GPIO input enable */
> -#define LOCOMO_GPL		0x98	/* GPIO level */
> -#define LOCOMO_GPO		0x9c	/* GPIO out data setting */
> -#define LOCOMO_GRIE		0xa0	/* GPIO rise detection */
> -#define LOCOMO_GFIE		0xa4	/* GPIO fall detection */
> -#define LOCOMO_GIS		0xa8	/* GPIO edge detection status */
> -#define LOCOMO_GWE		0xac	/* GPIO status write enable */
> -#define LOCOMO_GIE		0xb0	/* GPIO interrupt enable */
> -#define LOCOMO_GIR		0xb4	/* GPIO interrupt request */
> -#define	LOCOMO_GPIO(Nb)		(0x01 << (Nb))
> -#define LOCOMO_GPIO_RTS		LOCOMO_GPIO(0)
> -#define LOCOMO_GPIO_CTS		LOCOMO_GPIO(1)
> -#define LOCOMO_GPIO_DSR		LOCOMO_GPIO(2)
> -#define LOCOMO_GPIO_DTR		LOCOMO_GPIO(3)
> -#define LOCOMO_GPIO_LCD_VSHA_ON	LOCOMO_GPIO(4)
> -#define LOCOMO_GPIO_LCD_VSHD_ON	LOCOMO_GPIO(5)
> -#define LOCOMO_GPIO_LCD_VEE_ON	LOCOMO_GPIO(6)
> -#define LOCOMO_GPIO_LCD_MOD	LOCOMO_GPIO(7)
> -#define LOCOMO_GPIO_DAC_ON	LOCOMO_GPIO(8)
> -#define LOCOMO_GPIO_FL_VR	LOCOMO_GPIO(9)
> -#define LOCOMO_GPIO_DAC_SDATA	LOCOMO_GPIO(10)
> -#define LOCOMO_GPIO_DAC_SCK	LOCOMO_GPIO(11)
> -#define LOCOMO_GPIO_DAC_SLOAD	LOCOMO_GPIO(12)
> -#define LOCOMO_GPIO_CARD_DETECT LOCOMO_GPIO(13)
> -#define LOCOMO_GPIO_WRITE_PROT  LOCOMO_GPIO(14)
> -#define LOCOMO_GPIO_CARD_POWER  LOCOMO_GPIO(15)
> -
> -/* Start the definitions of the devices.  Each device has an initial
> - * base address and a series of offsets from that base address. */
> -
> -/* Keyboard controller */
> -#define LOCOMO_KEYBOARD		0x40
> -#define LOCOMO_KIB		0x00	/* KIB level */
> -#define LOCOMO_KSC		0x04	/* KSTRB control */
> -#define LOCOMO_KCMD		0x08	/* KSTRB command */
> -#define LOCOMO_KIC		0x0c	/* Key interrupt */
> -
> -/* Front light adjustment controller */
> -#define LOCOMO_FRONTLIGHT	0xc8
> -#define LOCOMO_ALS		0x00	/* Adjust light cycle */
> -#define LOCOMO_ALD		0x04	/* Adjust light duty */
> -
> -#define LOCOMO_ALC_EN		0x8000
> -
> -/* Backlight controller: TFT signal */
> -#define LOCOMO_BACKLIGHT	0x38
> -#define LOCOMO_TC		0x00		/* TFT control signal */
> -#define LOCOMO_CPSD		0x04		/* CPS delay */
> -
> -/* Audio controller */
> -#define LOCOMO_AUDIO		0x54
> -#define LOCOMO_ACC		0x00	/* Audio clock */
> -#define LOCOMO_PAIF		0xD0	/* PCM audio interface */
> -/* Audio clock */
> -#define	LOCOMO_ACC_XON		0x80
> -#define	LOCOMO_ACC_XEN		0x40
> -#define	LOCOMO_ACC_XSEL0	0x00
> -#define	LOCOMO_ACC_XSEL1	0x20
> -#define	LOCOMO_ACC_MCLKEN	0x10
> -#define	LOCOMO_ACC_64FSEN	0x08
> -#define	LOCOMO_ACC_CLKSEL000	0x00	/* mclk  2 */
> -#define	LOCOMO_ACC_CLKSEL001	0x01	/* mclk  3 */
> -#define	LOCOMO_ACC_CLKSEL010	0x02	/* mclk  4 */
> -#define	LOCOMO_ACC_CLKSEL011	0x03	/* mclk  6 */
> -#define	LOCOMO_ACC_CLKSEL100	0x04	/* mclk  8 */
> -#define	LOCOMO_ACC_CLKSEL101	0x05	/* mclk 12 */
> -/* PCM audio interface */
> -#define	LOCOMO_PAIF_SCINV	0x20
> -#define	LOCOMO_PAIF_SCEN	0x10
> -#define	LOCOMO_PAIF_LRCRST	0x08
> -#define	LOCOMO_PAIF_LRCEVE	0x04
> -#define	LOCOMO_PAIF_LRCINV	0x02
> -#define	LOCOMO_PAIF_LRCEN	0x01
> -
> -/* LED controller */
> -#define LOCOMO_LED		0xe8
> -#define LOCOMO_LPT0		0x00
> -#define LOCOMO_LPT1		0x04
> -/* LED control */
> -#define LOCOMO_LPT_TOFH		0x80
> -#define LOCOMO_LPT_TOFL		0x08
> -#define LOCOMO_LPT_TOH(TOH)	((TOH & 0x7) << 4)
> -#define LOCOMO_LPT_TOL(TOL)	((TOL & 0x7))
> -
> -#define LOCOMO_DEVID_KEYBOARD	0
> -#define LOCOMO_DEVID_FRONTLIGHT	1
> -#define LOCOMO_DEVID_BACKLIGHT	2
> -#define LOCOMO_DEVID_AUDIO	3
> -#define LOCOMO_DEVID_LED	4
> -#define LOCOMO_DEVID_UART	5
> -#define LOCOMO_DEVID_SPI	6
> -
> -struct locomo_dev {
> -	struct device	dev;
> -	unsigned int	devid;
> -	unsigned int	irq[1];
> -
> -	void		*mapbase;
> -	unsigned long	length;
> -
> -	u64		dma_mask;
> -};
> -
> -#define LOCOMO_DEV(_d)	container_of((_d), struct locomo_dev, dev)
> -
> -#define locomo_get_drvdata(d)	dev_get_drvdata(&(d)->dev)
> -#define locomo_set_drvdata(d,p)	dev_set_drvdata(&(d)->dev, p)
> -
> -struct locomo_driver {
> -	struct device_driver	drv;
> -	unsigned int		devid;
> -	int (*probe)(struct locomo_dev *);
> -	void (*remove)(struct locomo_dev *);
> -};
> -
> -#define LOCOMO_DRV(_d)	container_of_const((_d), struct locomo_driver, drv)
> -
> -#define LOCOMO_DRIVER_NAME(_ldev) ((_ldev)->dev.driver->name)
> -
> -extern void locomolcd_power(int on);
> -
> -int locomo_driver_register(struct locomo_driver *);
> -void locomo_driver_unregister(struct locomo_driver *);
> -
> -/* GPIO control functions */
> -void locomo_gpio_set_dir(struct device *dev, unsigned int bits, unsigned int dir);
> -int locomo_gpio_read_level(struct device *dev, unsigned int bits);
> -int locomo_gpio_read_output(struct device *dev, unsigned int bits);
> -void locomo_gpio_write(struct device *dev, unsigned int bits, unsigned int set);
> -
> -/* M62332 control function */
> -void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int channel);
> -
> -/* Frontlight control */
> -void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf);
> -
> -struct locomo_platform_data {
> -	int	irq_base;	/* IRQ base for cascaded on-chip IRQs */
> -};
> -
> -#endif
> diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
> deleted file mode 100644
> index 90b6a832108d..000000000000
> --- a/arch/arm/include/asm/hardware/sa1111.h
> +++ /dev/null
> @@ -1,442 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/include/asm/hardware/sa1111.h
> - *
> - * Copyright (C) 2000 John G Dorsey <john+@cs.cmu.edu>
> - *
> - * This file contains definitions for the SA-1111 Companion Chip.
> - * (Structure and naming borrowed from SA-1101.h, by Peter Danielsson.)
> - *
> - * Macro that calculates real address for registers in the SA-1111
> - */
> -
> -#ifndef _ASM_ARCH_SA1111
> -#define _ASM_ARCH_SA1111
> -
> -/*
> - * Don't ask the (SAC) DMA engines to move less than this amount.
> - */
> -
> -#define SA1111_SAC_DMA_MIN_XFER	(0x800)
> -
> -/*
> - * System Bus Interface (SBI)
> - *
> - * Registers
> - *    SKCR	Control Register
> - *    SMCR	Shared Memory Controller Register
> - *    SKID	ID Register
> - */
> -#define SA1111_SKCR	0x0000
> -#define SA1111_SMCR	0x0004
> -#define SA1111_SKID	0x0008
> -
> -#define SKCR_PLL_BYPASS	(1<<0)
> -#define SKCR_RCLKEN	(1<<1)
> -#define SKCR_SLEEP	(1<<2)
> -#define SKCR_DOZE	(1<<3)
> -#define SKCR_VCO_OFF	(1<<4)
> -#define SKCR_SCANTSTEN	(1<<5)
> -#define SKCR_CLKTSTEN	(1<<6)
> -#define SKCR_RDYEN	(1<<7)
> -#define SKCR_SELAC	(1<<8)
> -#define SKCR_OPPC	(1<<9)
> -#define SKCR_PLLTSTEN	(1<<10)
> -#define SKCR_USBIOTSTEN	(1<<11)
> -/*
> - * Don't believe the specs!  Take them, throw them outside.  Leave them
> - * there for a week.  Spit on them.  Walk on them.  Stamp on them.
> - * Pour gasoline over them and finally burn them.  Now think about coding.
> - *  - The October 1999 errata (278260-007) says its bit 13, 1 to enable.
> - *  - The Feb 2001 errata (278260-010) says that the previous errata
> - *    (278260-009) is wrong, and its bit actually 12, fixed in spec
> - *    278242-003.
> - *  - The SA1111 manual (278242) says bit 12, but 0 to enable.
> - *  - Reality is bit 13, 1 to enable.
> - *      -- rmk
> - */
> -#define SKCR_OE_EN	(1<<13)
> -
> -#define SMCR_DTIM	(1<<0)
> -#define SMCR_MBGE	(1<<1)
> -#define SMCR_DRAC_0	(1<<2)
> -#define SMCR_DRAC_1	(1<<3)
> -#define SMCR_DRAC_2	(1<<4)
> -#define SMCR_DRAC	Fld(3, 2)
> -#define SMCR_CLAT	(1<<5)
> -
> -#define SKID_SIREV_MASK	(0x000000f0)
> -#define SKID_MTREV_MASK (0x0000000f)
> -#define SKID_ID_MASK	(0xffffff00)
> -#define SKID_SA1111_ID	(0x690cc200)
> -
> -/*
> - * System Controller
> - *
> - * Registers
> - *    SKPCR	Power Control Register
> - *    SKCDR	Clock Divider Register
> - *    SKAUD	Audio Clock Divider Register
> - *    SKPMC	PS/2 Mouse Clock Divider Register
> - *    SKPTC	PS/2 Track Pad Clock Divider Register
> - *    SKPEN0	PWM0 Enable Register
> - *    SKPWM0	PWM0 Clock Register
> - *    SKPEN1	PWM1 Enable Register
> - *    SKPWM1	PWM1 Clock Register
> - */
> -#define SA1111_SKPCR	0x0200
> -#define SA1111_SKCDR	0x0204
> -#define SA1111_SKAUD	0x0208
> -#define SA1111_SKPMC	0x020c
> -#define SA1111_SKPTC	0x0210
> -#define SA1111_SKPEN0	0x0214
> -#define SA1111_SKPWM0	0x0218
> -#define SA1111_SKPEN1	0x021c
> -#define SA1111_SKPWM1	0x0220
> -
> -#define SKPCR_UCLKEN	(1<<0)
> -#define SKPCR_ACCLKEN	(1<<1)
> -#define SKPCR_I2SCLKEN	(1<<2)
> -#define SKPCR_L3CLKEN	(1<<3)
> -#define SKPCR_SCLKEN	(1<<4)
> -#define SKPCR_PMCLKEN	(1<<5)
> -#define SKPCR_PTCLKEN	(1<<6)
> -#define SKPCR_DCLKEN	(1<<7)
> -#define SKPCR_PWMCLKEN	(1<<8)
> -
> -/* USB Host controller */
> -#define SA1111_USB		0x0400
> -
> -/*
> - * Serial Audio Controller
> - *
> - * Registers
> - *    SACR0             Serial Audio Common Control Register
> - *    SACR1             Serial Audio Alternate Mode (I2C/MSB) Control Register
> - *    SACR2             Serial Audio AC-link Control Register
> - *    SASR0             Serial Audio I2S/MSB Interface & FIFO Status Register
> - *    SASR1             Serial Audio AC-link Interface & FIFO Status Register
> - *    SASCR             Serial Audio Status Clear Register
> - *    L3_CAR            L3 Control Bus Address Register
> - *    L3_CDR            L3 Control Bus Data Register
> - *    ACCAR             AC-link Command Address Register
> - *    ACCDR             AC-link Command Data Register
> - *    ACSAR             AC-link Status Address Register
> - *    ACSDR             AC-link Status Data Register
> - *    SADTCS            Serial Audio DMA Transmit Control/Status Register
> - *    SADTSA            Serial Audio DMA Transmit Buffer Start Address A
> - *    SADTCA            Serial Audio DMA Transmit Buffer Count Register A
> - *    SADTSB            Serial Audio DMA Transmit Buffer Start Address B
> - *    SADTCB            Serial Audio DMA Transmit Buffer Count Register B
> - *    SADRCS            Serial Audio DMA Receive Control/Status Register
> - *    SADRSA            Serial Audio DMA Receive Buffer Start Address A
> - *    SADRCA            Serial Audio DMA Receive Buffer Count Register A
> - *    SADRSB            Serial Audio DMA Receive Buffer Start Address B
> - *    SADRCB            Serial Audio DMA Receive Buffer Count Register B
> - *    SAITR             Serial Audio Interrupt Test Register
> - *    SADR              Serial Audio Data Register (16 x 32-bit)
> - */
> -
> -#define SA1111_SERAUDIO		0x0600
> -
> -/*
> - * These are offsets from the above base.
> - */
> -#define SA1111_SACR0		0x00
> -#define SA1111_SACR1		0x04
> -#define SA1111_SACR2		0x08
> -#define SA1111_SASR0		0x0c
> -#define SA1111_SASR1		0x10
> -#define SA1111_SASCR		0x18
> -#define SA1111_L3_CAR		0x1c
> -#define SA1111_L3_CDR		0x20
> -#define SA1111_ACCAR		0x24
> -#define SA1111_ACCDR		0x28
> -#define SA1111_ACSAR		0x2c
> -#define SA1111_ACSDR		0x30
> -#define SA1111_SADTCS		0x34
> -#define SA1111_SADTSA		0x38
> -#define SA1111_SADTCA		0x3c
> -#define SA1111_SADTSB		0x40
> -#define SA1111_SADTCB		0x44
> -#define SA1111_SADRCS		0x48
> -#define SA1111_SADRSA		0x4c
> -#define SA1111_SADRCA		0x50
> -#define SA1111_SADRSB		0x54
> -#define SA1111_SADRCB		0x58
> -#define SA1111_SAITR		0x5c
> -#define SA1111_SADR		0x80
> -
> -#ifndef CONFIG_ARCH_PXA
> -
> -#define SACR0_ENB	(1<<0)
> -#define SACR0_BCKD	(1<<2)
> -#define SACR0_RST	(1<<3)
> -
> -#define SACR1_AMSL	(1<<0)
> -#define SACR1_L3EN	(1<<1)
> -#define SACR1_L3MB	(1<<2)
> -#define SACR1_DREC	(1<<3)
> -#define SACR1_DRPL	(1<<4)
> -#define SACR1_ENLBF	(1<<5)
> -
> -#define SACR2_TS3V	(1<<0)
> -#define SACR2_TS4V	(1<<1)
> -#define SACR2_WKUP	(1<<2)
> -#define SACR2_DREC	(1<<3)
> -#define SACR2_DRPL	(1<<4)
> -#define SACR2_ENLBF	(1<<5)
> -#define SACR2_RESET	(1<<6)
> -
> -#define SASR0_TNF	(1<<0)
> -#define SASR0_RNE	(1<<1)
> -#define SASR0_BSY	(1<<2)
> -#define SASR0_TFS	(1<<3)
> -#define SASR0_RFS	(1<<4)
> -#define SASR0_TUR	(1<<5)
> -#define SASR0_ROR	(1<<6)
> -#define SASR0_L3WD	(1<<16)
> -#define SASR0_L3RD	(1<<17)
> -
> -#define SASR1_TNF	(1<<0)
> -#define SASR1_RNE	(1<<1)
> -#define SASR1_BSY	(1<<2)
> -#define SASR1_TFS	(1<<3)
> -#define SASR1_RFS	(1<<4)
> -#define SASR1_TUR	(1<<5)
> -#define SASR1_ROR	(1<<6)
> -#define SASR1_CADT	(1<<16)
> -#define SASR1_SADR	(1<<17)
> -#define SASR1_RSTO	(1<<18)
> -#define SASR1_CLPM	(1<<19)
> -#define SASR1_CRDY	(1<<20)
> -#define SASR1_RS3V	(1<<21)
> -#define SASR1_RS4V	(1<<22)
> -
> -#define SASCR_TUR	(1<<5)
> -#define SASCR_ROR	(1<<6)
> -#define SASCR_DTS	(1<<16)
> -#define SASCR_RDD	(1<<17)
> -#define SASCR_STO	(1<<18)
> -
> -#define SADTCS_TDEN	(1<<0)
> -#define SADTCS_TDIE	(1<<1)
> -#define SADTCS_TDBDA	(1<<3)
> -#define SADTCS_TDSTA	(1<<4)
> -#define SADTCS_TDBDB	(1<<5)
> -#define SADTCS_TDSTB	(1<<6)
> -#define SADTCS_TBIU	(1<<7)
> -
> -#define SADRCS_RDEN	(1<<0)
> -#define SADRCS_RDIE	(1<<1)
> -#define SADRCS_RDBDA	(1<<3)
> -#define SADRCS_RDSTA	(1<<4)
> -#define SADRCS_RDBDB	(1<<5)
> -#define SADRCS_RDSTB	(1<<6)
> -#define SADRCS_RBIU	(1<<7)
> -
> -#define SAD_CS_DEN	(1<<0)
> -#define SAD_CS_DIE	(1<<1)	/* Not functional on metal 1 */
> -#define SAD_CS_DBDA	(1<<3)	/* Not functional on metal 1 */
> -#define SAD_CS_DSTA	(1<<4)
> -#define SAD_CS_DBDB	(1<<5)	/* Not functional on metal 1 */
> -#define SAD_CS_DSTB	(1<<6)
> -#define SAD_CS_BIU	(1<<7)	/* Not functional on metal 1 */
> -
> -#define SAITR_TFS	(1<<0)
> -#define SAITR_RFS	(1<<1)
> -#define SAITR_TUR	(1<<2)
> -#define SAITR_ROR	(1<<3)
> -#define SAITR_CADT	(1<<4)
> -#define SAITR_SADR	(1<<5)
> -#define SAITR_RSTO	(1<<6)
> -#define SAITR_TDBDA	(1<<8)
> -#define SAITR_TDBDB	(1<<9)
> -#define SAITR_RDBDA	(1<<10)
> -#define SAITR_RDBDB	(1<<11)
> -
> -#endif  /* !CONFIG_ARCH_PXA */
> -
> -/*
> - * General-Purpose I/O Interface
> - *
> - * Registers
> - *    PA_DDR		GPIO Block A Data Direction
> - *    PA_DRR/PA_DWR	GPIO Block A Data Value Register (read/write)
> - *    PA_SDR		GPIO Block A Sleep Direction
> - *    PA_SSR		GPIO Block A Sleep State
> - *    PB_DDR		GPIO Block B Data Direction
> - *    PB_DRR/PB_DWR	GPIO Block B Data Value Register (read/write)
> - *    PB_SDR		GPIO Block B Sleep Direction
> - *    PB_SSR		GPIO Block B Sleep State
> - *    PC_DDR		GPIO Block C Data Direction
> - *    PC_DRR/PC_DWR	GPIO Block C Data Value Register (read/write)
> - *    PC_SDR		GPIO Block C Sleep Direction
> - *    PC_SSR		GPIO Block C Sleep State
> - */
> -
> -#define SA1111_GPIO	0x1000
> -
> -#define SA1111_GPIO_PADDR	(0x000)
> -#define SA1111_GPIO_PADRR	(0x004)
> -#define SA1111_GPIO_PADWR	(0x004)
> -#define SA1111_GPIO_PASDR	(0x008)
> -#define SA1111_GPIO_PASSR	(0x00c)
> -#define SA1111_GPIO_PBDDR	(0x010)
> -#define SA1111_GPIO_PBDRR	(0x014)
> -#define SA1111_GPIO_PBDWR	(0x014)
> -#define SA1111_GPIO_PBSDR	(0x018)
> -#define SA1111_GPIO_PBSSR	(0x01c)
> -#define SA1111_GPIO_PCDDR	(0x020)
> -#define SA1111_GPIO_PCDRR	(0x024)
> -#define SA1111_GPIO_PCDWR	(0x024)
> -#define SA1111_GPIO_PCSDR	(0x028)
> -#define SA1111_GPIO_PCSSR	(0x02c)
> -
> -#define GPIO_A0		(1 << 0)
> -#define GPIO_A1		(1 << 1)
> -#define GPIO_A2		(1 << 2)
> -#define GPIO_A3		(1 << 3)
> -
> -#define GPIO_B0		(1 << 8)
> -#define GPIO_B1		(1 << 9)
> -#define GPIO_B2		(1 << 10)
> -#define GPIO_B3		(1 << 11)
> -#define GPIO_B4		(1 << 12)
> -#define GPIO_B5		(1 << 13)
> -#define GPIO_B6		(1 << 14)
> -#define GPIO_B7		(1 << 15)
> -
> -#define GPIO_C0		(1 << 16)
> -#define GPIO_C1		(1 << 17)
> -#define GPIO_C2		(1 << 18)
> -#define GPIO_C3		(1 << 19)
> -#define GPIO_C4		(1 << 20)
> -#define GPIO_C5		(1 << 21)
> -#define GPIO_C6		(1 << 22)
> -#define GPIO_C7		(1 << 23)
> -
> -/*
> - * Interrupt Controller
> - *
> - * Registers
> - *    INTTEST0		Test register 0
> - *    INTTEST1		Test register 1
> - *    INTEN0		Interrupt Enable register 0
> - *    INTEN1		Interrupt Enable register 1
> - *    INTPOL0		Interrupt Polarity selection 0
> - *    INTPOL1		Interrupt Polarity selection 1
> - *    INTTSTSEL		Interrupt source selection
> - *    INTSTATCLR0	Interrupt Status/Clear 0
> - *    INTSTATCLR1	Interrupt Status/Clear 1
> - *    INTSET0		Interrupt source set 0
> - *    INTSET1		Interrupt source set 1
> - *    WAKE_EN0		Wake-up source enable 0
> - *    WAKE_EN1		Wake-up source enable 1
> - *    WAKE_POL0		Wake-up polarity selection 0
> - *    WAKE_POL1		Wake-up polarity selection 1
> - */
> -#define SA1111_INTC		0x1600
> -
> -/*
> - * These are offsets from the above base.
> - */
> -#define SA1111_INTTEST0		0x0000
> -#define SA1111_INTTEST1		0x0004
> -#define SA1111_INTEN0		0x0008
> -#define SA1111_INTEN1		0x000c
> -#define SA1111_INTPOL0		0x0010
> -#define SA1111_INTPOL1		0x0014
> -#define SA1111_INTTSTSEL	0x0018
> -#define SA1111_INTSTATCLR0	0x001c
> -#define SA1111_INTSTATCLR1	0x0020
> -#define SA1111_INTSET0		0x0024
> -#define SA1111_INTSET1		0x0028
> -#define SA1111_WAKEEN0		0x002c
> -#define SA1111_WAKEEN1		0x0030
> -#define SA1111_WAKEPOL0		0x0034
> -#define SA1111_WAKEPOL1		0x0038
> -
> -/* PS/2 Trackpad and Mouse Interfaces */
> -#define SA1111_KBD		0x0a00
> -#define SA1111_MSE		0x0c00
> -
> -/* PCMCIA Interface */
> -#define SA1111_PCMCIA		0x1600
> -
> -
> -
> -
> -
> -extern const struct bus_type sa1111_bus_type;
> -
> -#define SA1111_DEVID_SBI	(1 << 0)
> -#define SA1111_DEVID_SK		(1 << 1)
> -#define SA1111_DEVID_USB	(1 << 2)
> -#define SA1111_DEVID_SAC	(1 << 3)
> -#define SA1111_DEVID_SSP	(1 << 4)
> -#define SA1111_DEVID_PS2	(3 << 5)
> -#define SA1111_DEVID_PS2_KBD	(1 << 5)
> -#define SA1111_DEVID_PS2_MSE	(1 << 6)
> -#define SA1111_DEVID_GPIO	(1 << 7)
> -#define SA1111_DEVID_INT	(1 << 8)
> -#define SA1111_DEVID_PCMCIA	(1 << 9)
> -
> -struct sa1111_dev {
> -	struct device	dev;
> -	unsigned int	devid;
> -	struct resource	res;
> -	void __iomem	*mapbase;
> -	unsigned int	skpcr_mask;
> -	unsigned int	hwirq[6];
> -	u64		dma_mask;
> -};
> -
> -#define to_sa1111_device(x)	container_of(x, struct sa1111_dev, dev)
> -
> -#define sa1111_get_drvdata(d)	dev_get_drvdata(&(d)->dev)
> -#define sa1111_set_drvdata(d,p)	dev_set_drvdata(&(d)->dev, p)
> -
> -struct sa1111_driver {
> -	struct device_driver	drv;
> -	unsigned int		devid;
> -	int (*probe)(struct sa1111_dev *);
> -	void (*remove)(struct sa1111_dev *);
> -};
> -
> -#define SA1111_DRV(_d)	container_of_const((_d), struct sa1111_driver, drv)
> -
> -#define SA1111_DRIVER_NAME(_sadev) ((_sadev)->dev.driver->name)
> -
> -/*
> - * These frob the SKPCR register, and call platform specific
> - * enable/disable functions.
> - */
> -int sa1111_enable_device(struct sa1111_dev *);
> -void sa1111_disable_device(struct sa1111_dev *);
> -
> -int sa1111_get_irq(struct sa1111_dev *, unsigned num);
> -
> -unsigned int sa1111_pll_clock(struct sa1111_dev *);
> -
> -#define SA1111_AUDIO_ACLINK	0
> -#define SA1111_AUDIO_I2S	1
> -
> -void sa1111_select_audio_mode(struct sa1111_dev *sadev, int mode);
> -int sa1111_set_audio_rate(struct sa1111_dev *sadev, int rate);
> -int sa1111_get_audio_rate(struct sa1111_dev *sadev);
> -
> -int sa1111_check_dma_bug(dma_addr_t addr);
> -
> -int sa1111_driver_register(struct sa1111_driver *);
> -void sa1111_driver_unregister(struct sa1111_driver *);
> -
> -struct sa1111_platform_data {
> -	int	irq_base;	/* base for cascaded on-chip IRQs */
> -	unsigned disable_devs;
> -	void	*data;
> -	int	(*enable)(void *, unsigned);
> -	void	(*disable)(void *, unsigned);
> -};
> -
> -#endif  /* _ASM_ARCH_SA1111 */
> diff --git a/arch/arm/include/asm/hardware/ssp.h b/arch/arm/include/asm/hardware/ssp.h
> deleted file mode 100644
> index 72d176790308..000000000000
> --- a/arch/arm/include/asm/hardware/ssp.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  ssp.h
> - *
> - *  Copyright (C) 2003 Russell King, All Rights Reserved.
> - */
> -#ifndef SSP_H
> -#define SSP_H
> -
> -struct ssp_state {
> -	unsigned int	cr0;
> -	unsigned int	cr1;
> -};
> -
> -int ssp_write_word(u16 data);
> -int ssp_read_word(u16 *data);
> -int ssp_flush(void);
> -void ssp_enable(void);
> -void ssp_disable(void);
> -void ssp_save_state(struct ssp_state *ssp);
> -void ssp_restore_state(struct ssp_state *ssp);
> -int ssp_init(void);
> -void ssp_exit(void);
> -
> -#endif
> diff --git a/arch/arm/include/debug/sa1100.S b/arch/arm/include/debug/sa1100.S
> deleted file mode 100644
> index 7968ea52df3d..000000000000
> --- a/arch/arm/include/debug/sa1100.S
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/* arch/arm/include/debug/sa1100.S
> - *
> - * Debugging macro include header
> - *
> - *  Copyright (C) 1994-1999 Russell King
> - *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
> -*/
> -
> -#define UTCR3		0x0c
> -#define UTDR		0x14
> -#define UTSR1		0x20
> -#define UTCR3_TXE	0x00000002	/* Transmit Enable                 */
> -#define UTSR1_TBY	0x00000001	/* Transmitter BusY (read)         */
> -#define UTSR1_TNF	0x00000004	/* Transmit FIFO Not Full (read)   */
> -
> -		.macro	addruart, rp, rv, tmp
> -		mrc	p15, 0, \rp, c1, c0
> -		tst	\rp, #1			@ MMU enabled?
> -		moveq	\rp, #0x80000000	@ physical base address
> -		movne	\rp, #0xf8000000	@ virtual address
> -
> -		@ We probe for the active serial port here, coherently with
> -		@ the comment in arch/arm/mach-sa1100/include/mach/uncompress.h.
> -		@ We assume r1 can be clobbered.
> -
> -		@ see if Ser3 is active
> -		add	\rp, \rp, #0x00050000
> -		ldr	\rv, [\rp, #UTCR3]
> -		tst	\rv, #UTCR3_TXE
> -
> -		@ if Ser3 is inactive, then try Ser1
> -		addeq	\rp, \rp, #(0x00010000 - 0x00050000)
> -		ldreq	\rv, [\rp, #UTCR3]
> -		tsteq	\rv, #UTCR3_TXE
> -
> -		@ if Ser1 is inactive, then try Ser2
> -		addeq	\rp, \rp, #(0x00030000 - 0x00010000)
> -		ldreq	\rv, [\rp, #UTCR3]
> -		tsteq	\rv, #UTCR3_TXE
> -
> -		@ clear top bits, and generate both phys and virt addresses
> -		lsl	\rp, \rp, #8
> -		lsr	\rp, \rp, #8
> -		orr	\rv, \rp, #0xf8000000	@ virtual
> -		orr	\rp, \rp, #0x80000000	@ physical
> -
> -		.endm
> -
> -		.macro	senduart,rd,rx
> -		str	\rd, [\rx, #UTDR]
> -		.endm
> -
> -		.macro	waituartcts,rd,rx
> -		.endm
> -
> -		.macro	waituarttxrdy,rd,rx
> -1001:		ldr	\rd, [\rx, #UTSR1]
> -		tst	\rd, #UTSR1_TNF
> -		beq	1001b
> -		.endm
> -
> -		.macro	busyuart,rd,rx
> -1001:		ldr	\rd, [\rx, #UTSR1]
> -		tst	\rd, #UTSR1_TBY
> -		bne	1001b
> -		.endm
> diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
> deleted file mode 100644
> index d50721e39641..000000000000
> --- a/arch/arm/mach-sa1100/Kconfig
> +++ /dev/null
> @@ -1,92 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -menuconfig ARCH_SA1100
> -	bool "SA11x0 Implementations (DEPRECATED)"
> -	depends on ARCH_MULTI_V4 && !(ARCH_MULTI_V4T || ARCH_MULTI_V5)
> -	depends on !(ARCH_MOXART || ARCH_GEMINI)
> -	depends on ATAGS
> -	depends on CPU_LITTLE_ENDIAN
> -	depends on MMU
> -	select ARCH_NO_SG_CHAIN
> -	select ARCH_MTD_XIP
> -	select CLKSRC_MMIO
> -	select CLKSRC_PXA
> -	select CPU_FREQ
> -	select CPU_SA1100
> -	select GPIOLIB
> -	select GPIOLIB_LEGACY
> -	select IRQ_DOMAIN
> -	select ISA
> -	select NEED_MACH_MEMORY_H
> -	help
> -	  Support for StrongARM 11x0 based boards.
> -
> -	  Support for these machines will go away in 2027,
> -	  unless there are any remaining users that speak up.
> -
> -if ARCH_SA1100
> -
> -config SA1100_ASSABET
> -	bool "Assabet"
> -	select ARM_SA1110_CPUFREQ
> -	select GPIO_REG
> -	select LEDS_GPIO_REGISTER
> -	select REGULATOR
> -	select REGULATOR_FIXED_VOLTAGE
> -	help
> -	  Say Y here if you are using the Intel(R) StrongARM(R) SA-1110
> -	  Microprocessor Development Board (also known as the Assabet).
> -
> -config ASSABET_NEPONSET
> -	bool "Include support for Neponset"
> -	depends on SA1100_ASSABET
> -	select SA1111
> -	help
> -	  Say Y here if you are using the Intel(R) StrongARM(R) SA-1110
> -	  Microprocessor Development Board (Assabet)  with the SA-1111
> -	  Development Board (Nepon).
> -
> -config SA1100_COLLIE
> -	bool "Sharp Zaurus SL5500"
> -	# FIXME: select ARM_SA11x0_CPUFREQ
> -	select SHARP_LOCOMO
> -	select SHARP_PARAM
> -	select SHARP_SCOOP
> -	help
> -	  Say Y here to support the Sharp Zaurus SL5500 PDAs.
> -
> -config SA1100_H3600
> -	bool "Compaq iPAQ H3600/H3700"
> -	select ARM_SA1110_CPUFREQ
> -	select HTC_EGPIO
> -	select MFD_IPAQ_MICRO
> -	help
> -	  Say Y here if you intend to run this kernel on the Compaq iPAQ
> -	  H3600 and H3700 handheld computers.
> -
> -config SA1100_JORNADA720
> -	bool "HP Jornada 720"
> -	# FIXME: select ARM_SA11x0_CPUFREQ
> -	select SA1111
> -	help
> -	  Say Y here if you want to build a kernel for the HP Jornada 720
> -	  handheld computer.  See 
> -	  <http://h10025.www1.hp.com/ewfrf/wc/product?product=61677&cc=us&lc=en&dlc=en&product=61677#> 
> -
> -config SA1100_JORNADA720_SSP
> -	bool "HP Jornada 720 Extended SSP driver"
> -	depends on SA1100_JORNADA720
> -	select SA1100_SSP
> -	help
> -	  Say Y here if you have a HP Jornada 7xx handheld computer and you
> -	  want to access devices connected to the MCU. Those include the
> -	  keyboard, touchscreen, backlight and battery. This driver also activates
> -	  the generic SSP which it extends.
> -
> -config SA1100_SSP
> -	tristate "Generic PIO SSP"
> -	help
> -	  Say Y here to enable support for the generic PIO SSP driver.
> -	  This isn't for audio support, but for attached sensors and
> -	  other devices, eg for BadgePAD 4 sensor support.
> -
> -endif
> diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
> deleted file mode 100644
> index b5816d675152..000000000000
> --- a/arch/arm/mach-sa1100/Makefile
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile for the linux kernel.
> -#
> -
> -# Common support
> -obj-y := clock.o generic.o #nmi-oopser.o
> -
> -# Specific board support
> -obj-$(CONFIG_SA1100_ASSABET)		+= assabet.o
> -obj-$(CONFIG_ASSABET_NEPONSET)		+= neponset.o
> -obj-$(CONFIG_SA1100_COLLIE)		+= collie.o
> -obj-$(CONFIG_SA1100_H3600)		+= h3600.o h3xxx.o
> -obj-$(CONFIG_SA1100_JORNADA720)		+= jornada720.o
> -obj-$(CONFIG_SA1100_JORNADA720_SSP)	+= jornada720_ssp.o
> -
> -# Miscellaneous functions
> -obj-$(CONFIG_PM)			+= pm.o sleep.o
> -obj-$(CONFIG_SA1100_SSP)		+= ssp.o
> -
> diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
> deleted file mode 100644
> index b001f0b6a3fa..000000000000
> --- a/arch/arm/mach-sa1100/assabet.c
> +++ /dev/null
> @@ -1,770 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * linux/arch/arm/mach-sa1100/assabet.c
> - *
> - * Author: Nicolas Pitre
> - *
> - * This file contains all Assabet-specific tweaks.
> - */
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/errno.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/gpio/gpio-reg.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/gpio/property.h>
> -#include <linux/input.h>
> -#include <linux/ioport.h>
> -#include <linux/property.h>
> -#include <linux/platform_data/sa11x0-serial.h>
> -#include <linux/regulator/fixed.h>
> -#include <linux/regulator/machine.h>
> -#include <linux/serial_core.h>
> -#include <linux/platform_device.h>
> -#include <linux/mfd/ucb1x00.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/partitions.h>
> -#include <linux/delay.h>
> -#include <linux/mm.h>
> -#include <linux/leds.h>
> -#include <linux/slab.h>
> -
> -#include <video/sa1100fb.h>
> -
> -#include <mach/hardware.h>
> -#include <asm/mach-types.h>
> -#include <asm/setup.h>
> -#include <asm/page.h>
> -#include <asm/pgtable-hwdef.h>
> -#include <asm/tlbflush.h>
> -
> -#include <asm/mach/arch.h>
> -#include <asm/mach/flash.h>
> -#include <asm/mach/map.h>
> -#include <mach/assabet.h>
> -#include <linux/platform_data/mfd-mcp-sa11x0.h>
> -#include <mach/irqs.h>
> -
> -#include "generic.h"
> -
> -#define ASSABET_BCR_DB1110 \
> -	(ASSABET_BCR_SPK_OFF    | \
> -	 ASSABET_BCR_LED_GREEN  | ASSABET_BCR_LED_RED   | \
> -	 ASSABET_BCR_RS232EN    | ASSABET_BCR_LCD_12RGB | \
> -	 ASSABET_BCR_IRDA_MD0)
> -
> -#define ASSABET_BCR_DB1111 \
> -	(ASSABET_BCR_SPK_OFF    | \
> -	 ASSABET_BCR_LED_GREEN  | ASSABET_BCR_LED_RED   | \
> -	 ASSABET_BCR_RS232EN    | ASSABET_BCR_LCD_12RGB | \
> -	 ASSABET_BCR_CF_BUS_OFF | ASSABET_BCR_STEREO_LB | \
> -	 ASSABET_BCR_IRDA_MD0   | ASSABET_BCR_CF_RST)
> -
> -unsigned long SCR_value = ASSABET_SCR_INIT;
> -EXPORT_SYMBOL(SCR_value);
> -
> -static struct gpio_chip *assabet_bcr_gc;
> -
> -static const char *assabet_names[] = {
> -	"cf_pwr", "cf_gfx_reset", "nsoft_reset", "irda_fsel",
> -	"irda_md0", "irda_md1", "stereo_loopback", "ncf_bus_on",
> -	"audio_pwr_on", "light_pwr_on", "lcd16data", "lcd_pwr_on",
> -	"rs232_on", "nred_led", "ngreen_led", "vib_on",
> -	"com_dtr", "com_rts", "radio_wake_mod", "i2c_enab",
> -	"tvir_enab", "qmute", "radio_pwr_on", "spkr_off",
> -	"rs232_valid", "com_dcd", "com_cts", "com_dsr",
> -	"radio_cts", "radio_dsr", "radio_dcd", "radio_ri",
> -};
> -
> -/* The old deprecated interface */
> -void ASSABET_BCR_frob(unsigned int mask, unsigned int val)
> -{
> -	unsigned long m = mask, v = val;
> -
> -	assabet_bcr_gc->set_multiple(assabet_bcr_gc, &m, &v);
> -}
> -EXPORT_SYMBOL(ASSABET_BCR_frob);
> -
> -static void __init assabet_init_gpio(void __iomem *reg, u32 def_val)
> -{
> -	struct gpio_chip *gc;
> -
> -	writel_relaxed(def_val, reg);
> -
> -	gc = gpio_reg_init(NULL, reg, -1, 32, "assabet", 0xff000000, def_val,
> -			   assabet_names, NULL, NULL);
> -
> -	if (IS_ERR(gc))
> -		return;
> -
> -	assabet_bcr_gc = gc;
> -}
> -
> -/*
> - * The codec reset goes to three devices, so we need to release
> - * the rest when any one of these requests it.  However, that
> - * causes the ADV7171 to consume around 100mA - more than half
> - * the LCD-blanked power.
> - *
> - * With the ADV7171, LCD and backlight enabled, we go over
> - * budget on the MAX846 Li-Ion charger, and if no Li-Ion battery
> - * is connected, the Assabet crashes.
> - */
> -#define RST_UCB1X00 (1 << 0)
> -#define RST_UDA1341 (1 << 1)
> -#define RST_ADV7171 (1 << 2)
> -
> -#define SDA GPIO_GPIO(15)
> -#define SCK GPIO_GPIO(18)
> -#define MOD GPIO_GPIO(17)
> -
> -static void adv7171_start(void)
> -{
> -	GPSR = SCK;
> -	udelay(1);
> -	GPSR = SDA;
> -	udelay(2);
> -	GPCR = SDA;
> -}
> -
> -static void adv7171_stop(void)
> -{
> -	GPSR = SCK;
> -	udelay(2);
> -	GPSR = SDA;
> -	udelay(1);
> -}
> -
> -static void adv7171_send(unsigned byte)
> -{
> -	unsigned i;
> -
> -	for (i = 0; i < 8; i++, byte <<= 1) {
> -		GPCR = SCK;
> -		udelay(1);
> -		if (byte & 0x80)
> -			GPSR = SDA;
> -		else
> -			GPCR = SDA;
> -		udelay(1);
> -		GPSR = SCK;
> -		udelay(1);
> -	}
> -	GPCR = SCK;
> -	udelay(1);
> -	GPSR = SDA;
> -	udelay(1);
> -	GPDR &= ~SDA;
> -	GPSR = SCK;
> -	udelay(1);
> -	if (GPLR & SDA)
> -		printk(KERN_WARNING "No ACK from ADV7171\n");
> -	udelay(1);
> -	GPCR = SCK | SDA;
> -	udelay(1);
> -	GPDR |= SDA;
> -	udelay(1);
> -}
> -
> -static void adv7171_write(unsigned reg, unsigned val)
> -{
> -	unsigned gpdr = GPDR;
> -	unsigned gplr = GPLR;
> -
> -	ASSABET_BCR_frob(ASSABET_BCR_AUDIO_ON, ASSABET_BCR_AUDIO_ON);
> -	udelay(100);
> -
> -	GPCR = SDA | SCK | MOD; /* clear L3 mode to ensure UDA1341 doesn't respond */
> -	GPDR = (GPDR | SCK | MOD) & ~SDA;
> -	udelay(10);
> -	if (!(GPLR & SDA))
> -		printk(KERN_WARNING "Something dragging SDA down?\n");
> -	GPDR |= SDA;
> -
> -	adv7171_start();
> -	adv7171_send(0x54);
> -	adv7171_send(reg);
> -	adv7171_send(val);
> -	adv7171_stop();
> -
> -	/* Restore GPIO state for L3 bus */
> -	GPSR = gplr & (SDA | SCK | MOD);
> -	GPCR = (~gplr) & (SDA | SCK | MOD);
> -	GPDR = gpdr;
> -}
> -
> -static void adv7171_sleep(void)
> -{
> -	/* Put the ADV7171 into sleep mode */
> -	adv7171_write(0x04, 0x40);
> -}
> -
> -static unsigned codec_nreset;
> -
> -static void assabet_codec_reset(unsigned mask, int set)
> -{
> -	unsigned long flags;
> -	bool old;
> -
> -	local_irq_save(flags);
> -	old = !codec_nreset;
> -	if (set)
> -		codec_nreset &= ~mask;
> -	else
> -		codec_nreset |= mask;
> -
> -	if (old != !codec_nreset) {
> -		if (codec_nreset) {
> -			ASSABET_BCR_set(ASSABET_BCR_NCODEC_RST);
> -			adv7171_sleep();
> -		} else {
> -			ASSABET_BCR_clear(ASSABET_BCR_NCODEC_RST);
> -		}
> -	}
> -	local_irq_restore(flags);
> -}
> -
> -static void assabet_ucb1x00_reset(enum ucb1x00_reset state)
> -{
> -	int set = state == UCB_RST_REMOVE || state == UCB_RST_SUSPEND ||
> -		state == UCB_RST_PROBE_FAIL;
> -	assabet_codec_reset(RST_UCB1X00, set);
> -}
> -
> -void assabet_uda1341_reset(int set)
> -{
> -	assabet_codec_reset(RST_UDA1341, set);
> -}
> -EXPORT_SYMBOL(assabet_uda1341_reset);
> -
> -
> -/*
> - * Assabet flash support code.
> - */
> -
> -#ifdef ASSABET_REV_4
> -/*
> - * Phase 4 Assabet has two 28F160B3 flash parts in bank 0:
> - */
> -static struct mtd_partition assabet_partitions[] = {
> -	{
> -		.name		= "bootloader",
> -		.size		= 0x00020000,
> -		.offset		= 0,
> -		.mask_flags	= MTD_WRITEABLE,
> -	}, {
> -		.name		= "bootloader params",
> -		.size		= 0x00020000,
> -		.offset		= MTDPART_OFS_APPEND,
> -		.mask_flags	= MTD_WRITEABLE,
> -	}, {
> -		.name		= "jffs",
> -		.size		= MTDPART_SIZ_FULL,
> -		.offset		= MTDPART_OFS_APPEND,
> -	}
> -};
> -#else
> -/*
> - * Phase 5 Assabet has two 28F128J3A flash parts in bank 0:
> - */
> -static struct mtd_partition assabet_partitions[] = {
> -	{
> -		.name		= "bootloader",
> -		.size		= 0x00040000,
> -		.offset		= 0,
> -		.mask_flags	= MTD_WRITEABLE,
> -	}, {
> -		.name		= "bootloader params",
> -		.size		= 0x00040000,
> -		.offset		= MTDPART_OFS_APPEND,
> -		.mask_flags	= MTD_WRITEABLE,
> -	}, {
> -		.name		= "jffs",
> -		.size		= MTDPART_SIZ_FULL,
> -		.offset		= MTDPART_OFS_APPEND,
> -	}
> -};
> -#endif
> -
> -static struct flash_platform_data assabet_flash_data = {
> -	.map_name	= "cfi_probe",
> -	.parts		= assabet_partitions,
> -	.nr_parts	= ARRAY_SIZE(assabet_partitions),
> -};
> -
> -static struct resource assabet_flash_resources[] = {
> -	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M),
> -	DEFINE_RES_MEM(SA1100_CS1_PHYS, SZ_32M),
> -};
> -
> -
> -static struct ucb1x00_plat_data assabet_ucb1x00_data = {
> -	.reset		= assabet_ucb1x00_reset,
> -	.gpio_base	= -1,
> -	.can_wakeup	= 1,
> -};
> -
> -static struct mcp_plat_data assabet_mcp_data = {
> -	.mccr0		= MCCR0_ADM,
> -	.sclk_rate	= 11981000,
> -	.codec_pdata	= &assabet_ucb1x00_data,
> -};
> -
> -static void assabet_lcd_set_visual(u32 visual)
> -{
> -	u_int is_true_color = visual == FB_VISUAL_TRUECOLOR;
> -
> -	if (machine_is_assabet()) {
> -#if 1		// phase 4 or newer Assabet's
> -		if (is_true_color)
> -			ASSABET_BCR_set(ASSABET_BCR_LCD_12RGB);
> -		else
> -			ASSABET_BCR_clear(ASSABET_BCR_LCD_12RGB);
> -#else
> -		// older Assabet's
> -		if (is_true_color)
> -			ASSABET_BCR_clear(ASSABET_BCR_LCD_12RGB);
> -		else
> -			ASSABET_BCR_set(ASSABET_BCR_LCD_12RGB);
> -#endif
> -	}
> -}
> -
> -#ifndef ASSABET_PAL_VIDEO
> -static void assabet_lcd_backlight_power(int on)
> -{
> -	if (on)
> -		ASSABET_BCR_set(ASSABET_BCR_LIGHT_ON);
> -	else
> -		ASSABET_BCR_clear(ASSABET_BCR_LIGHT_ON);
> -}
> -
> -/*
> - * Turn on/off the backlight.  When turning the backlight on, we wait
> - * 500us after turning it on so we don't cause the supplies to droop
> - * when we enable the LCD controller (and cause a hard reset.)
> - */
> -static void assabet_lcd_power(int on)
> -{
> -	if (on) {
> -		ASSABET_BCR_set(ASSABET_BCR_LCD_ON);
> -		udelay(500);
> -	} else
> -		ASSABET_BCR_clear(ASSABET_BCR_LCD_ON);
> -}
> -
> -/*
> - * The assabet uses a sharp LQ039Q2DS54 LCD module.  It is actually
> - * takes an RGB666 signal, but we provide it with an RGB565 signal
> - * instead (def_rgb_16).
> - */
> -static struct sa1100fb_mach_info lq039q2ds54_info = {
> -	.pixclock	= 171521,	.bpp		= 16,
> -	.xres		= 320,		.yres		= 240,
> -
> -	.hsync_len	= 5,		.vsync_len	= 1,
> -	.left_margin	= 61,		.upper_margin	= 3,
> -	.right_margin	= 9,		.lower_margin	= 0,
> -
> -	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -
> -	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
> -	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
> -
> -	.backlight_power = assabet_lcd_backlight_power,
> -	.lcd_power = assabet_lcd_power,
> -	.set_visual = assabet_lcd_set_visual,
> -};
> -#else
> -static void assabet_pal_backlight_power(int on)
> -{
> -	ASSABET_BCR_clear(ASSABET_BCR_LIGHT_ON);
> -}
> -
> -static void assabet_pal_power(int on)
> -{
> -	ASSABET_BCR_clear(ASSABET_BCR_LCD_ON);
> -}
> -
> -static struct sa1100fb_mach_info pal_info = {
> -	.pixclock	= 67797,	.bpp		= 16,
> -	.xres		= 640,		.yres		= 512,
> -
> -	.hsync_len	= 64,		.vsync_len	= 6,
> -	.left_margin	= 125,		.upper_margin	= 70,
> -	.right_margin	= 115,		.lower_margin	= 36,
> -
> -	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
> -	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(512),
> -
> -	.backlight_power = assabet_pal_backlight_power,
> -	.lcd_power = assabet_pal_power,
> -	.set_visual = assabet_lcd_set_visual,
> -};
> -#endif
> -
> -#ifdef CONFIG_ASSABET_NEPONSET
> -static struct resource neponset_resources[] = {
> -	DEFINE_RES_MEM(0x10000000, 0x08000000),
> -	DEFINE_RES_MEM(0x18000000, 0x04000000),
> -	DEFINE_RES_MEM(0x40000000, SZ_8K),
> -	DEFINE_RES_IRQ(IRQ_GPIO25),
> -};
> -#endif
> -
> -static struct gpiod_lookup_table assabet_cf_gpio_table = {
> -	.dev_id = "sa11x0-pcmcia.1",
> -	.table = {
> -		GPIO_LOOKUP("gpio", 21, "ready", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("gpio", 22, "detect", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("gpio", 24, "bvd2", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("gpio", 25, "bvd1", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("assabet", 1, "reset", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("assabet", 7, "bus-enable", GPIO_ACTIVE_LOW),
> -		{ },
> -	},
> -};
> -
> -static struct regulator_consumer_supply assabet_cf_vcc_consumers[] = {
> -	REGULATOR_SUPPLY("vcc", "sa11x0-pcmcia.1"),
> -};
> -
> -static struct fixed_voltage_config assabet_cf_vcc_pdata __initdata = {
> -	.supply_name = "cf-power",
> -	.microvolts = 3300000,
> -};
> -
> -static struct gpiod_lookup_table assabet_cf_vcc_gpio_table = {
> -	.dev_id = "reg-fixed-voltage.0",
> -	.table = {
> -		GPIO_LOOKUP("assabet", 0, NULL, GPIO_ACTIVE_HIGH),
> -		{ },
> -	},
> -};
> -
> -static struct gpiod_lookup_table assabet_leds_gpio_table = {
> -	.dev_id = "leds-gpio",
> -	.table = {
> -		GPIO_LOOKUP("assabet", 13, NULL, GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("assabet", 14, NULL, GPIO_ACTIVE_LOW),
> -		{ },
> -	},
> -};
> -
> -static struct gpio_led assabet_leds[] __initdata = {
> -	{
> -		.name = "assabet:red",
> -		.default_trigger = "cpu0",
> -		.default_state = LEDS_GPIO_DEFSTATE_KEEP,
> -	}, {
> -		.name = "assabet:green",
> -		.default_trigger = "heartbeat",
> -		.default_state = LEDS_GPIO_DEFSTATE_KEEP,
> -	},
> -};
> -
> -static const struct gpio_led_platform_data assabet_leds_pdata __initconst = {
> -	.num_leds = ARRAY_SIZE(assabet_leds),
> -	.leds = assabet_leds,
> -};
> -
> -static const struct software_node assabet_gpio_keys_node = {
> -	.name = "assabet-gpio-keys",
> -};
> -
> -static const struct property_entry assabet_key0_props[] = {
> -	PROPERTY_ENTRY_U32("linux,code", KEY_RESERVED),
> -	PROPERTY_ENTRY_GPIO("gpios", &sa1100_gpiochip_node,
> -			    0, GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_STRING("label", "gpio0"),
> -	PROPERTY_ENTRY_BOOL("wakeup-source"),
> -	PROPERTY_ENTRY_BOOL("linux,can-disable"),
> -	PROPERTY_ENTRY_U32("debounce-interval", 5),
> -	{ }
> -};
> -
> -static const struct software_node assabet_key0_node = {
> -	.parent = &assabet_gpio_keys_node,
> -	.properties = assabet_key0_props,
> -};
> -
> -static const struct property_entry assabet_key1_props[] = {
> -	PROPERTY_ENTRY_U32("linux,code", KEY_RESERVED),
> -	PROPERTY_ENTRY_GPIO("gpios", &sa1100_gpiochip_node,
> -			    1, GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_STRING("label", "gpio1"),
> -	PROPERTY_ENTRY_BOOL("wakeup-source"),
> -	PROPERTY_ENTRY_BOOL("linux,can-disable"),
> -	PROPERTY_ENTRY_U32("debounce-interval", 5),
> -	{ }
> -};
> -
> -static const struct software_node assabet_key1_node = {
> -	.parent = &assabet_gpio_keys_node,
> -	.properties = assabet_key1_props,
> -};
> -
> -static const struct software_node * const assabet_gpio_keys_swnodes[] __initconst = {
> -	&assabet_gpio_keys_node,
> -	&assabet_key0_node,
> -	&assabet_key1_node,
> -	NULL
> -};
> -
> -static const struct platform_device_info assabet_gpio_keys_dev_info __initconst = {
> -	.name = "gpio-keys",
> -	.id = PLATFORM_DEVID_NONE,
> -	.swnode = &assabet_gpio_keys_node,
> -};
> -
> -static struct gpiod_lookup_table assabet_uart1_gpio_table = {
> -	.dev_id = "sa11x0-uart.1",
> -	.table = {
> -		GPIO_LOOKUP("assabet", 16, "dtr", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("assabet", 17, "rts", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("assabet", 25, "dcd", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("assabet", 26, "cts", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("assabet", 27, "dsr", GPIO_ACTIVE_LOW),
> -		{ },
> -	},
> -};
> -
> -static struct gpiod_lookup_table assabet_uart3_gpio_table = {
> -	.dev_id = "sa11x0-uart.3",
> -	.table = {
> -		GPIO_LOOKUP("assabet", 28, "cts", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("assabet", 29, "dsr", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("assabet", 30, "dcd", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("assabet", 31, "rng", GPIO_ACTIVE_LOW),
> -		{ },
> -	},
> -};
> -
> -static void __init assabet_init(void)
> -{
> -	/*
> -	 * Ensure that the power supply is in "high power" mode.
> -	 */
> -	GPSR = GPIO_GPIO16;
> -	GPDR |= GPIO_GPIO16;
> -
> -	/*
> -	 * Ensure that these pins are set as outputs and are driving
> -	 * logic 0.  This ensures that we won't inadvertently toggle
> -	 * the WS latch in the CPLD, and we don't float causing
> -	 * excessive power drain.  --rmk
> -	 */
> -	GPCR = GPIO_SSP_TXD | GPIO_SSP_SCLK | GPIO_SSP_SFRM;
> -	GPDR |= GPIO_SSP_TXD | GPIO_SSP_SCLK | GPIO_SSP_SFRM;
> -
> -	/*
> -	 * Also set GPIO27 as an output; this is used to clock UART3
> -	 * via the FPGA and as otherwise has no pullups or pulldowns,
> -	 * so stop it floating.
> -	 */
> -	GPCR = GPIO_GPIO27;
> -	GPDR |= GPIO_GPIO27;
> -
> -	/*
> -	 * Set up registers for sleep mode.
> -	 */
> -	PWER = PWER_GPIO0;
> -	PGSR = 0;
> -	PCFR = 0;
> -	PSDR = 0;
> -	PPDR |= PPC_TXD3 | PPC_TXD1;
> -	PPSR |= PPC_TXD3 | PPC_TXD1;
> -
> -	sa11x0_ppc_configure_mcp();
> -
> -	if (machine_has_neponset()) {
> -#ifndef CONFIG_ASSABET_NEPONSET
> -		printk( "Warning: Neponset detected but full support "
> -			"hasn't been configured in the kernel\n" );
> -#else
> -		platform_device_register_simple("neponset", 0,
> -			neponset_resources, ARRAY_SIZE(neponset_resources));
> -#endif
> -	} else {
> -		gpiod_add_lookup_table(&assabet_uart1_gpio_table);
> -		gpiod_add_lookup_table(&assabet_uart3_gpio_table);
> -		gpiod_add_lookup_table(&assabet_cf_vcc_gpio_table);
> -
> -		sa11x0_register_fixed_regulator(0, &assabet_cf_vcc_pdata,
> -					assabet_cf_vcc_consumers,
> -					ARRAY_SIZE(assabet_cf_vcc_consumers),
> -					true);
> -
> -	}
> -
> -	software_node_register_node_group(assabet_gpio_keys_swnodes);
> -	platform_device_register_full(&assabet_gpio_keys_dev_info);
> -
> -	gpiod_add_lookup_table(&assabet_leds_gpio_table);
> -	gpio_led_register_device(-1, &assabet_leds_pdata);
> -
> -#ifndef ASSABET_PAL_VIDEO
> -	sa11x0_register_lcd(&lq039q2ds54_info);
> -#else
> -	sa11x0_register_lcd(&pal_video);
> -#endif
> -	sa11x0_register_mtd(&assabet_flash_data, assabet_flash_resources,
> -			    ARRAY_SIZE(assabet_flash_resources));
> -	sa11x0_register_mcp(&assabet_mcp_data);
> -
> -	if (!machine_has_neponset())
> -		sa11x0_register_pcmcia(1, &assabet_cf_gpio_table);
> -}
> -
> -/*
> - * On Assabet, we must probe for the Neponset board _before_
> - * paging_init() has occurred to actually determine the amount
> - * of RAM available.  To do so, we map the appropriate IO section
> - * in the page table here in order to access GPIO registers.
> - */
> -static void __init map_sa1100_gpio_regs( void )
> -{
> -	unsigned long phys = __PREG(GPLR) & PMD_MASK;
> -	unsigned long virt = (unsigned long)io_p2v(phys);
> -	int prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_DOMAIN(DOMAIN_IO);
> -	pmd_t *pmd;
> -
> -	pmd = pmd_off_k(virt);
> -	*pmd = __pmd(phys | prot);
> -	flush_pmd_entry(pmd);
> -}
> -
> -/*
> - * Read System Configuration "Register"
> - * (taken from "Intel StrongARM SA-1110 Microprocessor Development Board
> - * User's Guide", section 4.4.1)
> - *
> - * This same scan is performed in arch/arm/boot/compressed/head-sa1100.S
> - * to set up the serial port for decompression status messages. We
> - * repeat it here because the kernel may not be loaded as a zImage, and
> - * also because it's a hassle to communicate the SCR value to the kernel
> - * from the decompressor.
> - *
> - * Note that IRQs are guaranteed to be disabled.
> - */
> -static void __init get_assabet_scr(void)
> -{
> -	unsigned long scr, i;
> -
> -	GPDR |= 0x3fc;			/* Configure GPIO 9:2 as outputs */
> -	GPSR = 0x3fc;			/* Write 0xFF to GPIO 9:2 */
> -	GPDR &= ~(0x3fc);		/* Configure GPIO 9:2 as inputs */
> -	for(i = 100; i--; )		/* Read GPIO 9:2 */
> -		scr = GPLR;
> -	GPDR |= 0x3fc;			/*  restore correct pin direction */
> -	scr &= 0x3fc;			/* save as system configuration byte. */
> -	SCR_value = scr;
> -}
> -
> -static void __init
> -fixup_assabet(struct tag *tags, char **cmdline)
> -{
> -	/* This must be done before any call to machine_has_neponset() */
> -	map_sa1100_gpio_regs();
> -	get_assabet_scr();
> -
> -	if (machine_has_neponset())
> -		printk("Neponset expansion board detected\n");
> -}
> -
> -
> -static void assabet_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
> -{
> -	if (port->mapbase == _Ser1UTCR0) {
> -		if (state)
> -			ASSABET_BCR_clear(ASSABET_BCR_RS232EN);
> -		else
> -			ASSABET_BCR_set(ASSABET_BCR_RS232EN);
> -	}
> -}
> -
> -static struct sa1100_port_fns assabet_port_fns __initdata = {
> -	.pm		= assabet_uart_pm,
> -};
> -
> -static struct map_desc assabet_io_desc[] __initdata = {
> -  	{	/* Board Control Register */
> -		.virtual	=  0xf1000000,
> -		.pfn		= __phys_to_pfn(0x12000000),
> -		.length		= 0x00100000,
> -		.type		= MT_DEVICE
> -	}, {	/* MQ200 */
> -		.virtual	=  0xf2800000,
> -		.pfn		= __phys_to_pfn(0x4b800000),
> -		.length		= 0x00800000,
> -		.type		= MT_DEVICE
> -	}
> -};
> -
> -static void __init assabet_map_io(void)
> -{
> -	sa1100_map_io();
> -	iotable_init(assabet_io_desc, ARRAY_SIZE(assabet_io_desc));
> -
> -	/*
> -	 * Set SUS bit in SDCR0 so serial port 1 functions.
> -	 * Its called GPCLKR0 in my SA1110 manual.
> -	 */
> -	Ser1SDCR0 |= SDCR0_SUS;
> -	MSC1 = (MSC1 & ~0xffff) |
> -		MSC_NonBrst | MSC_32BitStMem |
> -		MSC_RdAcc(2) | MSC_WrAcc(2) | MSC_Rec(0);
> -
> -	if (!machine_has_neponset())
> -		sa1100_register_uart_fns(&assabet_port_fns);
> -
> -	/*
> -	 * When Neponset is attached, the first UART should be
> -	 * UART3.  That's what Angel is doing and many documents
> -	 * are stating this.
> -	 *
> -	 * We do the Neponset mapping even if Neponset support
> -	 * isn't compiled in so the user will still get something on
> -	 * the expected physical serial port.
> -	 *
> -	 * We no longer do this; not all boot loaders support it,
> -	 * and UART3 appears to be somewhat unreliable with blob.
> -	 */
> -	sa1100_register_uart(0, 1);
> -	sa1100_register_uart(2, 3);
> -}
> -
> -static void __init assabet_init_irq(void)
> -{
> -	u32 def_val;
> -
> -	sa1100_init_irq();
> -
> -	if (machine_has_neponset())
> -		def_val = ASSABET_BCR_DB1111;
> -	else
> -		def_val = ASSABET_BCR_DB1110;
> -
> -	/*
> -	 * Angel sets this, but other bootloaders may not.
> -	 *
> -	 * This must precede any driver calls to BCR_set() or BCR_clear().
> -	 */
> -	assabet_init_gpio((void *)&ASSABET_BCR, def_val);
> -}
> -
> -MACHINE_START(ASSABET, "Intel-Assabet")
> -	.atag_offset	= 0x100,
> -	.fixup		= fixup_assabet,
> -	.map_io		= assabet_map_io,
> -	.nr_irqs	= SA1100_NR_IRQS,
> -	.init_irq	= assabet_init_irq,
> -	.init_time	= sa1100_timer_init,
> -	.init_machine	= assabet_init,
> -	.init_late	= sa11x0_init_late,
> -#ifdef CONFIG_SA1111
> -	.dma_zone_size	= SZ_1M,
> -#endif
> -	.restart	= sa11x0_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
> deleted file mode 100644
> index eafeb38502af..000000000000
> --- a/arch/arm/mach-sa1100/clock.c
> +++ /dev/null
> @@ -1,145 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/arch/arm/mach-sa1100/clock.c
> - */
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/err.h>
> -#include <linux/clk.h>
> -#include <linux/clkdev.h>
> -#include <linux/clk-provider.h>
> -#include <linux/io.h>
> -#include <linux/spinlock.h>
> -
> -#include <mach/hardware.h>
> -#include <mach/generic.h>
> -
> -static const char * const clk_tucr_parents[] = {
> -	"clk32768", "clk3686400",
> -};
> -
> -static DEFINE_SPINLOCK(tucr_lock);
> -
> -static int clk_gpio27_enable(struct clk_hw *hw)
> -{
> -	unsigned long flags;
> -
> -	/*
> -	 * First, set up the 3.6864MHz clock on GPIO 27 for the SA-1111:
> -	 * (SA-1110 Developer's Manual, section 9.1.2.1)
> -	 */
> -	local_irq_save(flags);
> -	GAFR |= GPIO_32_768kHz;
> -	GPDR |= GPIO_32_768kHz;
> -	local_irq_restore(flags);
> -
> -	return 0;
> -}
> -
> -static void clk_gpio27_disable(struct clk_hw *hw)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	GPDR &= ~GPIO_32_768kHz;
> -	GAFR &= ~GPIO_32_768kHz;
> -	local_irq_restore(flags);
> -}
> -
> -static const struct clk_ops clk_gpio27_ops = {
> -	.enable = clk_gpio27_enable,
> -	.disable = clk_gpio27_disable,
> -};
> -
> -static const char * const clk_gpio27_parents[] = {
> -	"tucr-mux",
> -};
> -
> -static const struct clk_init_data clk_gpio27_init_data __initconst = {
> -	.name = "gpio27",
> -	.ops = &clk_gpio27_ops,
> -	.parent_names = clk_gpio27_parents,
> -	.num_parents = ARRAY_SIZE(clk_gpio27_parents),
> -};
> -
> -/*
> - * Derived from the table 8-1 in the SA1110 manual, the MPLL appears to
> - * multiply its input rate by 4 x (4 + PPCR).  This calculation gives
> - * the exact rate.  The figures given in the table are the rates rounded
> - * to 100kHz.  Stick with sa11x0_getspeed() for the time being.
> - */
> -static unsigned long clk_mpll_recalc_rate(struct clk_hw *hw,
> -	unsigned long prate)
> -{
> -	return sa11x0_getspeed(0) * 1000;
> -}
> -
> -static const struct clk_ops clk_mpll_ops = {
> -	.recalc_rate = clk_mpll_recalc_rate,
> -};
> -
> -static const char * const clk_mpll_parents[] = {
> -	"clk3686400",
> -};
> -
> -static const struct clk_init_data clk_mpll_init_data __initconst = {
> -	.name = "mpll",
> -	.ops = &clk_mpll_ops,
> -	.parent_names = clk_mpll_parents,
> -	.num_parents = ARRAY_SIZE(clk_mpll_parents),
> -	.flags = CLK_GET_RATE_NOCACHE | CLK_IS_CRITICAL,
> -};
> -
> -int __init sa11xx_clk_init(void)
> -{
> -	struct clk_hw *hw;
> -	int ret;
> -
> -	hw = clk_hw_register_fixed_rate(NULL, "clk32768", NULL, 0, 32768);
> -	if (IS_ERR(hw))
> -		return PTR_ERR(hw);
> -
> -	clk_hw_register_clkdev(hw, NULL, "sa1100-rtc");
> -
> -	hw = clk_hw_register_fixed_rate(NULL, "clk3686400", NULL, 0, 3686400);
> -	if (IS_ERR(hw))
> -		return PTR_ERR(hw);
> -
> -	clk_hw_register_clkdev(hw, "OSTIMER0", NULL);
> -
> -	hw = kzalloc_obj(*hw);
> -	if (!hw)
> -		return -ENOMEM;
> -	hw->init = &clk_mpll_init_data;
> -	ret = clk_hw_register(NULL, hw);
> -	if (ret) {
> -		kfree(hw);
> -		return ret;
> -	}
> -
> -	clk_hw_register_clkdev(hw, NULL, "sa11x0-fb");
> -	clk_hw_register_clkdev(hw, NULL, "sa11x0-pcmcia");
> -	clk_hw_register_clkdev(hw, NULL, "sa11x0-pcmcia.0");
> -	clk_hw_register_clkdev(hw, NULL, "sa11x0-pcmcia.1");
> -	clk_hw_register_clkdev(hw, NULL, "1800");
> -
> -	hw = clk_hw_register_mux(NULL, "tucr-mux", clk_tucr_parents,
> -				 ARRAY_SIZE(clk_tucr_parents), 0,
> -				 (void __iomem *)&TUCR, FShft(TUCR_TSEL),
> -				 FAlnMsk(TUCR_TSEL), 0, &tucr_lock);
> -	clk_set_rate(hw->clk, 3686400);
> -
> -	hw = kzalloc_obj(*hw);
> -	if (!hw)
> -		return -ENOMEM;
> -	hw->init = &clk_gpio27_init_data;
> -	ret = clk_hw_register(NULL, hw);
> -	if (ret) {
> -		kfree(hw);
> -		return ret;
> -	}
> -
> -	clk_hw_register_clkdev(hw, NULL, "sa1111.0");
> -
> -	return 0;
> -}
> diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
> deleted file mode 100644
> index d1931f51c900..000000000000
> --- a/arch/arm/mach-sa1100/collie.c
> +++ /dev/null
> @@ -1,447 +0,0 @@
> -/*
> - * linux/arch/arm/mach-sa1100/collie.c
> - *
> - * May be copied or modified under the terms of the GNU General Public
> - * License.  See linux/COPYING for more information.
> - *
> - * This file contains all Collie-specific tweaks.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * ChangeLog:
> - *  2006 Pavel Machek <pavel@ucw.cz>
> - *  03-06-2004 John Lenz <lenz@cs.wisc.edu>
> - *  06-04-2002 Chris Larson <kergoth@digitalnemesis.net>
> - *  04-16-2001 Lineo Japan,Inc. ...
> - */
> -
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/tty.h>
> -#include <linux/delay.h>
> -#include <linux/platform_data/sa11x0-serial.h>
> -#include <linux/platform_device.h>
> -#include <linux/mfd/ucb1x00.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/partitions.h>
> -#include <linux/timer.h>
> -#include <linux/gpio/property.h>
> -#include <linux/input.h>
> -#include <linux/gpio/legacy.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/property.h>
> -#include <linux/power/gpio-charger.h>
> -
> -#include <video/sa1100fb.h>
> -
> -#include <mach/hardware.h>
> -#include <asm/mach-types.h>
> -#include <asm/page.h>
> -#include <asm/setup.h>
> -#include <mach/collie.h>
> -
> -#include <asm/mach/arch.h>
> -#include <asm/mach/flash.h>
> -#include <asm/mach/map.h>
> -
> -#include <asm/hardware/scoop.h>
> -#include <asm/mach/sharpsl_param.h>
> -#include <asm/hardware/locomo.h>
> -#include <linux/platform_data/mfd-mcp-sa11x0.h>
> -#include <mach/irqs.h>
> -
> -#include "generic.h"
> -
> -static struct resource collie_scoop_resources[] = {
> -	[0] = DEFINE_RES_MEM(0x40800000, SZ_4K),
> -};
> -
> -static struct scoop_config collie_scoop_setup = {
> -	.io_dir 	= COLLIE_SCOOP_IO_DIR,
> -	.io_out		= COLLIE_SCOOP_IO_OUT,
> -	.gpio_base	= COLLIE_SCOOP_GPIO_BASE,
> -};
> -
> -struct platform_device colliescoop_device = {
> -	.name		= "sharp-scoop",
> -	.id		= -1,
> -	.dev		= {
> - 		.platform_data	= &collie_scoop_setup,
> -	},
> -	.num_resources	= ARRAY_SIZE(collie_scoop_resources),
> -	.resource	= collie_scoop_resources,
> -};
> -
> -static struct scoop_pcmcia_dev collie_pcmcia_scoop[] = {
> -	{
> -	.dev		= &colliescoop_device.dev,
> -	.irq		= COLLIE_IRQ_GPIO_CF_IRQ,
> -	.cd_irq		= COLLIE_IRQ_GPIO_CF_CD,
> -	.cd_irq_str	= "PCMCIA0 CD",
> -	},
> -};
> -
> -static struct scoop_pcmcia_config collie_pcmcia_config = {
> -	.devs		= &collie_pcmcia_scoop[0],
> -	.num_devs	= 1,
> -};
> -
> -static struct ucb1x00_plat_data collie_ucb1x00_data = {
> -	.gpio_base	= COLLIE_TC35143_GPIO_BASE,
> -};
> -
> -static struct mcp_plat_data collie_mcp_data = {
> -	.mccr0		= MCCR0_ADM | MCCR0_ExtClk,
> -	.sclk_rate	= 9216000,
> -	.codec_pdata	= &collie_ucb1x00_data,
> -};
> -
> -/* Battery management GPIOs */
> -static struct gpiod_lookup_table collie_battery_gpiod_table = {
> -	/* the MCP codec mcp0 has the ucb1x00 as attached device */
> -	.dev_id = "ucb1x00",
> -	.table = {
> -		/* This is found on the main GPIO on the SA1100 */
> -		GPIO_LOOKUP("gpio", COLLIE_GPIO_CO,
> -			    "main battery full", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("gpio", COLLIE_GPIO_MAIN_BAT_LOW,
> -			    "main battery low", GPIO_ACTIVE_HIGH),
> -		/*
> -		 * This is GPIO 0 on the Scoop expander, which is registered
> -		 * from common/scoop.c with this gpio chip label.
> -		 */
> -		GPIO_LOOKUP("sharp-scoop", 0,
> -			    "main charge on", GPIO_ACTIVE_HIGH),
> -		{ },
> -	},
> -};
> -
> -/*
> - * Collie AC IN
> - */
> -static struct gpiod_lookup_table collie_power_gpiod_table = {
> -	.dev_id = "gpio-charger",
> -	.table = {
> -		GPIO_LOOKUP("gpio", COLLIE_GPIO_AC_IN,
> -			    NULL, GPIO_ACTIVE_HIGH),
> -		{ },
> -	},
> -};
> -
> -static char *collie_ac_supplied_to[] = {
> -	"main-battery",
> -	"backup-battery",
> -};
> -
> -static struct gpio_charger_platform_data collie_power_data = {
> -	.name			= "charger",
> -	.type			= POWER_SUPPLY_TYPE_MAINS,
> -	.supplied_to		= collie_ac_supplied_to,
> -	.num_supplicants	= ARRAY_SIZE(collie_ac_supplied_to),
> -};
> -
> -static struct platform_device collie_power_device = {
> -	.name			= "gpio-charger",
> -	.id			= -1,
> -	.dev.platform_data	= &collie_power_data,
> -};
> -
> -#ifdef CONFIG_SHARP_LOCOMO
> -/*
> - * low-level UART features.
> - */
> -struct platform_device collie_locomo_device;
> -
> -static void collie_uart_set_mctrl(struct uart_port *port, u_int mctrl)
> -{
> -	if (mctrl & TIOCM_RTS)
> -		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_RTS, 0);
> -	else
> -		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_RTS, 1);
> -
> -	if (mctrl & TIOCM_DTR)
> -		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_DTR, 0);
> -	else
> -		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_DTR, 1);
> -}
> -
> -static u_int collie_uart_get_mctrl(struct uart_port *port)
> -{
> -	int ret = TIOCM_CD;
> -	unsigned int r;
> -
> -	r = locomo_gpio_read_output(&collie_locomo_device.dev, LOCOMO_GPIO_CTS & LOCOMO_GPIO_DSR);
> -	if (r == -ENODEV)
> -		return ret;
> -	if (r & LOCOMO_GPIO_CTS)
> -		ret |= TIOCM_CTS;
> -	if (r & LOCOMO_GPIO_DSR)
> -		ret |= TIOCM_DSR;
> -
> -	return ret;
> -}
> -
> -static struct sa1100_port_fns collie_port_fns __initdata = {
> -	.set_mctrl	= collie_uart_set_mctrl,
> -	.get_mctrl	= collie_uart_get_mctrl,
> -};
> -
> -static int collie_uart_probe(struct locomo_dev *dev)
> -{
> -	return 0;
> -}
> -
> -static struct locomo_driver collie_uart_driver = {
> -	.drv = {
> -		.name = "collie_uart",
> -	},
> -	.devid	= LOCOMO_DEVID_UART,
> -	.probe	= collie_uart_probe,
> -};
> -
> -static int __init collie_uart_init(void)
> -{
> -	return locomo_driver_register(&collie_uart_driver);
> -}
> -device_initcall(collie_uart_init);
> -
> -#endif
> -
> -
> -static struct resource locomo_resources[] = {
> -	[0] = DEFINE_RES_MEM(0x40000000, SZ_8K),
> -	[1] = DEFINE_RES_IRQ(IRQ_GPIO25),
> -};
> -
> -static struct locomo_platform_data locomo_info = {
> -	.irq_base	= IRQ_BOARD_START,
> -};
> -
> -struct platform_device collie_locomo_device = {
> -	.name		= "locomo",
> -	.id		= 0,
> -	.dev		= {
> -		.platform_data	= &locomo_info,
> -	},
> -	.num_resources	= ARRAY_SIZE(locomo_resources),
> -	.resource	= locomo_resources,
> -};
> -
> -static const struct software_node collie_gpio_keys_node = {
> -	.name = "collie-gpio-keys",
> -};
> -
> -static const struct property_entry collie_on_key_props[] = {
> -	PROPERTY_ENTRY_U32("linux,code", KEY_RESERVED),
> -	PROPERTY_ENTRY_GPIO("gpios", &sa1100_gpiochip_node,
> -			    COLLIE_GPIO_ON_KEY, GPIO_ACTIVE_LOW),
> -	PROPERTY_ENTRY_STRING("label", "On key"),
> -	PROPERTY_ENTRY_U32("linux,input-type", EV_PWR),
> -	PROPERTY_ENTRY_BOOL("wakeup-source"),
> -	{ }
> -};
> -
> -static const struct software_node collie_on_key_node = {
> -	.parent = &collie_gpio_keys_node,
> -	.properties = collie_on_key_props,
> -};
> -
> -static const struct property_entry collie_wakeup_key_props[] = {
> -	PROPERTY_ENTRY_U32("linux,code", KEY_WAKEUP),
> -	PROPERTY_ENTRY_GPIO("gpios", &sa1100_gpiochip_node,
> -			    COLLIE_GPIO_WAKEUP, GPIO_ACTIVE_LOW),
> -	PROPERTY_ENTRY_STRING("label", "Sync"),
> -	PROPERTY_ENTRY_U32("linux,input-type", EV_PWR),
> -	PROPERTY_ENTRY_BOOL("wakeup-source"),
> -	{ }
> -};
> -
> -static const struct software_node collie_wakeup_key_node = {
> -	.parent = &collie_gpio_keys_node,
> -	.properties = collie_wakeup_key_props,
> -};
> -
> -static const struct software_node * const collie_gpio_keys_swnodes[] __initconst = {
> -	&collie_gpio_keys_node,
> -	&collie_on_key_node,
> -	&collie_wakeup_key_node,
> -	NULL
> -};
> -
> -static const struct platform_device_info collie_gpio_keys_dev_info __initconst = {
> -	.name = "gpio-keys",
> -	.id = PLATFORM_DEVID_NONE,
> -	.swnode = &collie_gpio_keys_node,
> -};
> -
> -static struct platform_device *devices[] __initdata = {
> -	&collie_locomo_device,
> -	&colliescoop_device,
> -	&collie_power_device,
> -};
> -
> -static struct mtd_partition collie_partitions[] = {
> -	{
> -		.name		= "bootloader",
> -		.offset 	= 0,
> -		.size		= 0x000C0000,
> -		.mask_flags	= MTD_WRITEABLE
> -	}, {
> -		.name		= "kernel",
> -		.offset 	= MTDPART_OFS_APPEND,
> -		.size		= 0x00100000,
> -	}, {
> -		.name		= "rootfs",
> -		.offset 	= MTDPART_OFS_APPEND,
> -		.size		= 0x00e20000,
> -	}, {
> -		.name		= "bootblock",
> -		.offset		= MTDPART_OFS_APPEND,
> -		.size		= 0x00020000,
> -		.mask_flags	= MTD_WRITEABLE
> -	}
> -};
> -
> -static int collie_flash_init(void)
> -{
> -	int rc = gpio_request(COLLIE_GPIO_VPEN, "flash Vpp enable");
> -	if (rc)
> -		return rc;
> -
> -	rc = gpio_direction_output(COLLIE_GPIO_VPEN, 1);
> -	if (rc)
> -		gpio_free(COLLIE_GPIO_VPEN);
> -
> -	return rc;
> -}
> -
> -static void collie_set_vpp(int vpp)
> -{
> -	gpio_set_value(COLLIE_GPIO_VPEN, vpp);
> -}
> -
> -static void collie_flash_exit(void)
> -{
> -	gpio_free(COLLIE_GPIO_VPEN);
> -}
> -
> -static struct flash_platform_data collie_flash_data = {
> -	.map_name	= "cfi_probe",
> -	.init		= collie_flash_init,
> -	.set_vpp	= collie_set_vpp,
> -	.exit		= collie_flash_exit,
> -	.parts		= collie_partitions,
> -	.nr_parts	= ARRAY_SIZE(collie_partitions),
> -};
> -
> -static struct resource collie_flash_resources[] = {
> -	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M),
> -};
> -
> -static struct sa1100fb_mach_info collie_lcd_info = {
> -	.pixclock	= 171521,	.bpp		= 16,
> -	.xres		= 320,		.yres		= 240,
> -
> -	.hsync_len	= 5,		.vsync_len	= 1,
> -	.left_margin	= 11,		.upper_margin	= 2,
> -	.right_margin	= 30,		.lower_margin	= 0,
> -
> -	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -
> -	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
> -	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
> -
> -#ifdef CONFIG_BACKLIGHT_LOCOMO
> -	.lcd_power	= locomolcd_power
> -#endif
> -};
> -
> -static void __init collie_init(void)
> -{
> -	int ret = 0;
> -
> -	/* cpu initialize */
> -	GAFR = GPIO_SSP_TXD | GPIO_SSP_SCLK | GPIO_SSP_SFRM | GPIO_SSP_CLK |
> -		GPIO_MCP_CLK | GPIO_32_768kHz;
> -
> -	GPDR = GPIO_LDD8 | GPIO_LDD9 | GPIO_LDD10 | GPIO_LDD11 | GPIO_LDD12 |
> -		GPIO_LDD13 | GPIO_LDD14 | GPIO_LDD15 | GPIO_SSP_TXD |
> -		GPIO_SSP_SCLK | GPIO_SSP_SFRM | GPIO_SDLC_SCLK |
> -		_COLLIE_GPIO_UCB1x00_RESET | _COLLIE_GPIO_nMIC_ON |
> -		_COLLIE_GPIO_nREMOCON_ON | GPIO_32_768kHz;
> -
> -	PPDR = PPC_LDD0 | PPC_LDD1 | PPC_LDD2 | PPC_LDD3 | PPC_LDD4 | PPC_LDD5 |
> -		PPC_LDD6 | PPC_LDD7 | PPC_L_PCLK | PPC_L_LCLK | PPC_L_FCLK | PPC_L_BIAS |
> -		PPC_TXD1 | PPC_TXD2 | PPC_TXD3 | PPC_TXD4 | PPC_SCLK | PPC_SFRM;
> -
> -	PWER = 0;
> -
> -	PGSR = _COLLIE_GPIO_nREMOCON_ON;
> -
> -	PSDR = PPC_RXD1 | PPC_RXD2 | PPC_RXD3 | PPC_RXD4;
> -
> -	PCFR = PCFR_OPDE;
> -
> -	GPSR |= _COLLIE_GPIO_UCB1x00_RESET;
> -
> -	sa11x0_ppc_configure_mcp();
> -
> -
> -	platform_scoop_config = &collie_pcmcia_config;
> -
> -	gpiod_add_lookup_table(&collie_power_gpiod_table);
> -	gpiod_add_lookup_table(&collie_battery_gpiod_table);
> -
> -	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
> -	if (ret) {
> -		printk(KERN_WARNING "collie: Unable to register LoCoMo device\n");
> -	}
> -
> -	software_node_register_node_group(collie_gpio_keys_swnodes);
> -	platform_device_register_full(&collie_gpio_keys_dev_info);
> -
> -	sa11x0_register_lcd(&collie_lcd_info);
> -	sa11x0_register_mtd(&collie_flash_data, collie_flash_resources,
> -			    ARRAY_SIZE(collie_flash_resources));
> -	sa11x0_register_mcp(&collie_mcp_data);
> -
> -	sharpsl_save_param();
> -}
> -
> -static struct map_desc collie_io_desc[] __initdata = {
> -	{	/* 32M main flash (cs0) */
> -		.virtual	= 0xe8000000,
> -		.pfn		= __phys_to_pfn(0x00000000),
> -		.length		= 0x02000000,
> -		.type		= MT_DEVICE
> -	}, {	/* 32M boot flash (cs1) */
> -		.virtual	= 0xea000000,
> -		.pfn		= __phys_to_pfn(0x08000000),
> -		.length		= 0x02000000,
> -		.type		= MT_DEVICE
> -	}
> -};
> -
> -static void __init collie_map_io(void)
> -{
> -	sa1100_map_io();
> -	iotable_init(collie_io_desc, ARRAY_SIZE(collie_io_desc));
> -
> -#ifdef CONFIG_SHARP_LOCOMO
> -	sa1100_register_uart_fns(&collie_port_fns);
> -#endif
> -	sa1100_register_uart(0, 3);
> -	sa1100_register_uart(1, 1);
> -}
> -
> -MACHINE_START(COLLIE, "Sharp-Collie")
> -	.map_io		= collie_map_io,
> -	.nr_irqs	= SA1100_NR_IRQS,
> -	.init_irq	= sa1100_init_irq,
> -	.init_time	= sa1100_timer_init,
> -	.init_machine	= collie_init,
> -	.init_late	= sa11x0_init_late,
> -	.restart	= sa11x0_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
> deleted file mode 100644
> index a995625ab1a0..000000000000
> --- a/arch/arm/mach-sa1100/generic.c
> +++ /dev/null
> @@ -1,470 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * linux/arch/arm/mach-sa1100/generic.c
> - *
> - * Author: Nicolas Pitre
> - *
> - * Code common to all SA11x0 machines.
> - */
> -#include <linux/gpio/consumer.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/delay.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/pm.h>
> -#include <linux/cpufreq.h>
> -#include <linux/ioport.h>
> -#include <linux/platform_device.h>
> -#include <linux/reboot.h>
> -#include <linux/regulator/fixed.h>
> -#include <linux/regulator/machine.h>
> -#include <linux/irqchip/irq-sa11x0.h>
> -
> -#include <video/sa1100fb.h>
> -
> -#include <soc/sa1100/pwer.h>
> -
> -#include <asm/div64.h>
> -#include <asm/mach/map.h>
> -#include <asm/mach/flash.h>
> -#include <asm/irq.h>
> -#include <asm/system_misc.h>
> -
> -#include <mach/hardware.h>
> -#include <mach/irqs.h>
> -#include <mach/reset.h>
> -
> -#include "generic.h"
> -#include <clocksource/pxa.h>
> -
> -#define NR_FREQS	16
> -
> -/*
> - * This table is setup for a 3.6864MHz Crystal.
> - */
> -struct cpufreq_frequency_table sa11x0_freq_table[NR_FREQS+1] = {
> -	{ .frequency = 59000,	/*  59.0 MHz */},
> -	{ .frequency = 73700,	/*  73.7 MHz */},
> -	{ .frequency = 88500,	/*  88.5 MHz */},
> -	{ .frequency = 103200,	/* 103.2 MHz */},
> -	{ .frequency = 118000,	/* 118.0 MHz */},
> -	{ .frequency = 132700,	/* 132.7 MHz */},
> -	{ .frequency = 147500,	/* 147.5 MHz */},
> -	{ .frequency = 162200,	/* 162.2 MHz */},
> -	{ .frequency = 176900,	/* 176.9 MHz */},
> -	{ .frequency = 191700,	/* 191.7 MHz */},
> -	{ .frequency = 206400,	/* 206.4 MHz */},
> -	{ .frequency = 221200,	/* 221.2 MHz */},
> -	{ .frequency = 235900,	/* 235.9 MHz */},
> -	{ .frequency = 250700,	/* 250.7 MHz */},
> -	{ .frequency = 265400,	/* 265.4 MHz */},
> -	{ .frequency = 280200,	/* 280.2 MHz */},
> -	{ .frequency = CPUFREQ_TABLE_END, },
> -};
> -
> -unsigned int sa11x0_getspeed(unsigned int cpu)
> -{
> -	if (cpu)
> -		return 0;
> -	return sa11x0_freq_table[PPCR & 0xf].frequency;
> -}
> -
> -/*
> - * Default power-off for SA1100
> - */
> -static void sa1100_power_off(void)
> -{
> -	mdelay(100);
> -	local_irq_disable();
> -	/* disable internal oscillator, float CS lines */
> -	PCFR = (PCFR_OPDE | PCFR_FP | PCFR_FS);
> -	/* enable wake-up on GPIO0 (Assabet...) */
> -	PWER = GFER = GRER = 1;
> -	/*
> -	 * set scratchpad to zero, just in case it is used as a
> -	 * restart address by the bootloader.
> -	 */
> -	PSPR = 0;
> -	/* enter sleep mode */
> -	PMCR = PMCR_SF;
> -}
> -
> -void sa11x0_restart(enum reboot_mode mode, const char *cmd)
> -{
> -	clear_reset_status(RESET_STATUS_ALL);
> -
> -	if (mode == REBOOT_SOFT) {
> -		/* Jump into ROM at address 0 */
> -		soft_restart(0);
> -	} else {
> -		/* Use on-chip reset capability */
> -		RSRR = RSRR_SWR;
> -	}
> -}
> -
> -static void sa11x0_register_device(struct platform_device *dev, void *data)
> -{
> -	int err;
> -	dev->dev.platform_data = data;
> -	err = platform_device_register(dev);
> -	if (err)
> -		printk(KERN_ERR "Unable to register device %s: %d\n",
> -			dev->name, err);
> -}
> -
> -
> -static struct resource sa11x0udc_resources[] = {
> -	[0] = DEFINE_RES_MEM(__PREG(Ser0UDCCR), SZ_64K),
> -	[1] = DEFINE_RES_IRQ(IRQ_Ser0UDC),
> -};
> -
> -static u64 sa11x0udc_dma_mask = 0xffffffffUL;
> -
> -static struct platform_device sa11x0udc_device = {
> -	.name		= "sa11x0-udc",
> -	.id		= -1,
> -	.dev		= {
> -		.dma_mask = &sa11x0udc_dma_mask,
> -		.coherent_dma_mask = 0xffffffff,
> -	},
> -	.num_resources	= ARRAY_SIZE(sa11x0udc_resources),
> -	.resource	= sa11x0udc_resources,
> -};
> -
> -static struct resource sa11x0uart1_resources[] = {
> -	[0] = DEFINE_RES_MEM(__PREG(Ser1UTCR0), SZ_64K),
> -	[1] = DEFINE_RES_IRQ(IRQ_Ser1UART),
> -};
> -
> -static struct platform_device sa11x0uart1_device = {
> -	.name		= "sa11x0-uart",
> -	.id		= 1,
> -	.num_resources	= ARRAY_SIZE(sa11x0uart1_resources),
> -	.resource	= sa11x0uart1_resources,
> -};
> -
> -static struct resource sa11x0uart3_resources[] = {
> -	[0] = DEFINE_RES_MEM(__PREG(Ser3UTCR0), SZ_64K),
> -	[1] = DEFINE_RES_IRQ(IRQ_Ser3UART),
> -};
> -
> -static struct platform_device sa11x0uart3_device = {
> -	.name		= "sa11x0-uart",
> -	.id		= 3,
> -	.num_resources	= ARRAY_SIZE(sa11x0uart3_resources),
> -	.resource	= sa11x0uart3_resources,
> -};
> -
> -static struct resource sa11x0mcp_resources[] = {
> -	[0] = DEFINE_RES_MEM(__PREG(Ser4MCCR0), SZ_64K),
> -	[1] = DEFINE_RES_MEM(__PREG(Ser4MCCR1), 4),
> -	[2] = DEFINE_RES_IRQ(IRQ_Ser4MCP),
> -};
> -
> -static u64 sa11x0mcp_dma_mask = 0xffffffffUL;
> -
> -static struct platform_device sa11x0mcp_device = {
> -	.name		= "sa11x0-mcp",
> -	.id		= -1,
> -	.dev = {
> -		.dma_mask = &sa11x0mcp_dma_mask,
> -		.coherent_dma_mask = 0xffffffff,
> -	},
> -	.num_resources	= ARRAY_SIZE(sa11x0mcp_resources),
> -	.resource	= sa11x0mcp_resources,
> -};
> -
> -void __init sa11x0_ppc_configure_mcp(void)
> -{
> -	/* Setup the PPC unit for the MCP */
> -	PPDR &= ~PPC_RXD4;
> -	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
> -	PSDR |= PPC_RXD4;
> -	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
> -	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
> -}
> -
> -void sa11x0_register_mcp(struct mcp_plat_data *data)
> -{
> -	sa11x0_register_device(&sa11x0mcp_device, data);
> -}
> -
> -static struct resource sa11x0ssp_resources[] = {
> -	[0] = DEFINE_RES_MEM(0x80070000, SZ_64K),
> -	[1] = DEFINE_RES_IRQ(IRQ_Ser4SSP),
> -};
> -
> -static u64 sa11x0ssp_dma_mask = 0xffffffffUL;
> -
> -static struct platform_device sa11x0ssp_device = {
> -	.name		= "sa11x0-ssp",
> -	.id		= -1,
> -	.dev = {
> -		.dma_mask = &sa11x0ssp_dma_mask,
> -		.coherent_dma_mask = 0xffffffff,
> -	},
> -	.num_resources	= ARRAY_SIZE(sa11x0ssp_resources),
> -	.resource	= sa11x0ssp_resources,
> -};
> -
> -static struct resource sa11x0fb_resources[] = {
> -	[0] = DEFINE_RES_MEM(0xb0100000, SZ_64K),
> -	[1] = DEFINE_RES_IRQ(IRQ_LCD),
> -};
> -
> -static struct platform_device sa11x0fb_device = {
> -	.name		= "sa11x0-fb",
> -	.id		= -1,
> -	.dev = {
> -		.coherent_dma_mask = 0xffffffff,
> -	},
> -	.num_resources	= ARRAY_SIZE(sa11x0fb_resources),
> -	.resource	= sa11x0fb_resources,
> -};
> -
> -void sa11x0_register_lcd(struct sa1100fb_mach_info *inf)
> -{
> -	sa11x0_register_device(&sa11x0fb_device, inf);
> -}
> -
> -void sa11x0_register_pcmcia(int socket, struct gpiod_lookup_table *table)
> -{
> -	if (table)
> -		gpiod_add_lookup_table(table);
> -	platform_device_register_simple("sa11x0-pcmcia", socket, NULL, 0);
> -}
> -
> -static struct platform_device sa11x0mtd_device = {
> -	.name		= "sa1100-mtd",
> -	.id		= -1,
> -};
> -
> -void sa11x0_register_mtd(struct flash_platform_data *flash,
> -			 struct resource *res, int nr)
> -{
> -	flash->name = "sa1100";
> -	sa11x0mtd_device.resource = res;
> -	sa11x0mtd_device.num_resources = nr;
> -	sa11x0_register_device(&sa11x0mtd_device, flash);
> -}
> -
> -static struct resource sa1100_rtc_resources[] = {
> -	DEFINE_RES_MEM(0x90010000, 0x40),
> -	DEFINE_RES_IRQ_NAMED(IRQ_RTC1Hz, "rtc 1Hz"),
> -	DEFINE_RES_IRQ_NAMED(IRQ_RTCAlrm, "rtc alarm"),
> -};
> -
> -static struct platform_device sa11x0rtc_device = {
> -	.name		= "sa1100-rtc",
> -	.id		= -1,
> -	.num_resources	= ARRAY_SIZE(sa1100_rtc_resources),
> -	.resource	= sa1100_rtc_resources,
> -};
> -
> -static struct resource sa11x0dma_resources[] = {
> -	DEFINE_RES_MEM(DMA_PHYS, DMA_SIZE),
> -	DEFINE_RES_IRQ(IRQ_DMA0),
> -	DEFINE_RES_IRQ(IRQ_DMA1),
> -	DEFINE_RES_IRQ(IRQ_DMA2),
> -	DEFINE_RES_IRQ(IRQ_DMA3),
> -	DEFINE_RES_IRQ(IRQ_DMA4),
> -	DEFINE_RES_IRQ(IRQ_DMA5),
> -};
> -
> -static u64 sa11x0dma_dma_mask = DMA_BIT_MASK(32);
> -
> -static struct platform_device sa11x0dma_device = {
> -	.name		= "sa11x0-dma",
> -	.id		= -1,
> -	.dev = {
> -		.dma_mask = &sa11x0dma_dma_mask,
> -		.coherent_dma_mask = 0xffffffff,
> -	},
> -	.num_resources	= ARRAY_SIZE(sa11x0dma_resources),
> -	.resource	= sa11x0dma_resources,
> -};
> -
> -static struct platform_device *sa11x0_devices[] __initdata = {
> -	&sa11x0udc_device,
> -	&sa11x0uart1_device,
> -	&sa11x0uart3_device,
> -	&sa11x0ssp_device,
> -	&sa11x0rtc_device,
> -	&sa11x0dma_device,
> -};
> -
> -static int __init sa1100_init(void)
> -{
> -	struct resource wdt_res = DEFINE_RES_MEM(0x90000000, 0x20);
> -	register_platform_power_off(sa1100_power_off);
> -
> -	regulator_has_full_constraints();
> -
> -	platform_device_register_simple("sa1100_wdt", -1, &wdt_res, 1);
> -
> -	return platform_add_devices(sa11x0_devices, ARRAY_SIZE(sa11x0_devices));
> -}
> -
> -arch_initcall(sa1100_init);
> -
> -void __init sa11x0_init_late(void)
> -{
> -	sa11x0_pm_init();
> -}
> -
> -int __init sa11x0_register_fixed_regulator(int n,
> -	struct fixed_voltage_config *cfg,
> -	struct regulator_consumer_supply *supplies, unsigned num_supplies,
> -	bool uses_gpio)
> -{
> -	struct regulator_init_data *id;
> -
> -	cfg->init_data = id = kzalloc_obj(*cfg->init_data);
> -	if (!cfg->init_data)
> -		return -ENOMEM;
> -
> -	if (!uses_gpio)
> -		id->constraints.always_on = 1;
> -	id->constraints.name = cfg->supply_name;
> -	id->constraints.min_uV = cfg->microvolts;
> -	id->constraints.max_uV = cfg->microvolts;
> -	id->constraints.valid_modes_mask = REGULATOR_MODE_NORMAL;
> -	id->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
> -	id->consumer_supplies = supplies;
> -	id->num_consumer_supplies = num_supplies;
> -
> -	platform_device_register_resndata(NULL, "reg-fixed-voltage", n,
> -					  NULL, 0, cfg, sizeof(*cfg));
> -	return 0;
> -}
> -
> -/*
> - * Common I/O mapping:
> - *
> - * Typically, static virtual address mappings are as follow:
> - *
> - * 0xf0000000-0xf3ffffff:	miscellaneous stuff (CPLDs, etc.)
> - * 0xf4000000-0xf4ffffff:	SA-1111
> - * 0xf5000000-0xf5ffffff:	reserved (used by cache flushing area)
> - * 0xf6000000-0xfffeffff:	reserved (internal SA1100 IO defined above)
> - * 0xffff0000-0xffff0fff:	SA1100 exception vectors
> - * 0xffff2000-0xffff2fff:	Minicache copy_user_page area
> - *
> - * Below 0xe8000000 is reserved for vm allocation.
> - *
> - * The machine specific code must provide the extra mapping beside the
> - * default mapping provided here.
> - */
> -
> -static struct map_desc standard_io_desc[] __initdata = {
> -	{	/* PCM */
> -		.virtual	=  0xf8000000,
> -		.pfn		= __phys_to_pfn(0x80000000),
> -		.length		= 0x00100000,
> -		.type		= MT_DEVICE
> -	}, {	/* SCM */
> -		.virtual	=  0xfa000000,
> -		.pfn		= __phys_to_pfn(0x90000000),
> -		.length		= 0x00100000,
> -		.type		= MT_DEVICE
> -	}, {	/* MER */
> -		.virtual	=  0xfc000000,
> -		.pfn		= __phys_to_pfn(0xa0000000),
> -		.length		= 0x00100000,
> -		.type		= MT_DEVICE
> -	}, {	/* LCD + DMA */
> -		.virtual	=  0xfe000000,
> -		.pfn		= __phys_to_pfn(0xb0000000),
> -		.length		= 0x00200000,
> -		.type		= MT_DEVICE
> -	},
> -};
> -
> -void __init sa1100_map_io(void)
> -{
> -	iotable_init(standard_io_desc, ARRAY_SIZE(standard_io_desc));
> -}
> -
> -void __init sa1100_timer_init(void)
> -{
> -	pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x90000000));
> -}
> -
> -static struct resource irq_resource =
> -	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
> -
> -void __init sa1100_init_irq(void)
> -{
> -	request_resource(&iomem_resource, &irq_resource);
> -
> -	sa11x0_init_irq_nodt(IRQ_GPIO0_SC, irq_resource.start);
> -
> -	sa1100_init_gpio();
> -	sa11xx_clk_init();
> -}
> -
> -/*
> - * Disable the memory bus request/grant signals on the SA1110 to
> - * ensure that we don't receive spurious memory requests.  We set
> - * the MBGNT signal false to ensure the SA1111 doesn't own the
> - * SDRAM bus.
> - */
> -void sa1110_mb_disable(void)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	
> -	PGSR &= ~GPIO_MBGNT;
> -	GPCR = GPIO_MBGNT;
> -	GPDR = (GPDR & ~GPIO_MBREQ) | GPIO_MBGNT;
> -
> -	GAFR &= ~(GPIO_MBGNT | GPIO_MBREQ);
> -
> -	local_irq_restore(flags);
> -}
> -
> -/*
> - * If the system is going to use the SA-1111 DMA engines, set up
> - * the memory bus request/grant pins.
> - */
> -void sa1110_mb_enable(void)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -
> -	PGSR &= ~GPIO_MBGNT;
> -	GPCR = GPIO_MBGNT;
> -	GPDR = (GPDR & ~GPIO_MBREQ) | GPIO_MBGNT;
> -
> -	GAFR |= (GPIO_MBGNT | GPIO_MBREQ);
> -	TUCR |= TUCR_MR;
> -
> -	local_irq_restore(flags);
> -}
> -
> -int sa11x0_gpio_set_wake(unsigned int gpio, unsigned int on)
> -{
> -	if (on)
> -		PWER |= BIT(gpio);
> -	else
> -		PWER &= ~BIT(gpio);
> -
> -	return 0;
> -}
> -
> -int sa11x0_sc_set_wake(unsigned int irq, unsigned int on)
> -{
> -	if (BIT(irq) != IC_RTCAlrm)
> -		return -EINVAL;
> -
> -	if (on)
> -		PWER |= PWER_RTC;
> -	else
> -		PWER &= ~PWER_RTC;
> -
> -	return 0;
> -}
> diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
> deleted file mode 100644
> index 3cfe3b647711..000000000000
> --- a/arch/arm/mach-sa1100/generic.h
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * linux/arch/arm/mach-sa1100/generic.h
> - *
> - * Author: Nicolas Pitre
> - */
> -#include <linux/cpufreq.h>
> -#include <linux/reboot.h>
> -
> -extern void sa1100_timer_init(void);
> -extern void __init sa1100_map_io(void);
> -extern void __init sa1100_init_irq(void);
> -extern void __init sa1100_init_gpio(void);
> -extern void sa11x0_restart(enum reboot_mode, const char *);
> -extern void sa11x0_init_late(void);
> -
> -#define SET_BANK(__nr,__start,__size) \
> -	mi->bank[__nr].start = (__start), \
> -	mi->bank[__nr].size = (__size)
> -
> -extern void sa1110_mb_enable(void);
> -extern void sa1110_mb_disable(void);
> -
> -extern struct cpufreq_frequency_table sa11x0_freq_table[];
> -extern unsigned int sa11x0_getspeed(unsigned int cpu);
> -
> -struct flash_platform_data;
> -struct resource;
> -
> -void sa11x0_register_mtd(struct flash_platform_data *flash,
> -			 struct resource *res, int nr);
> -
> -struct mcp_plat_data;
> -void sa11x0_ppc_configure_mcp(void);
> -void sa11x0_register_mcp(struct mcp_plat_data *data);
> -
> -struct sa1100fb_mach_info;
> -void sa11x0_register_lcd(struct sa1100fb_mach_info *inf);
> -
> -#ifdef CONFIG_PM
> -int sa11x0_pm_init(void);
> -#else
> -static inline int sa11x0_pm_init(void) { return 0; }
> -#endif
> -
> -int sa11xx_clk_init(void);
> -
> -struct gpiod_lookup_table;
> -void sa11x0_register_pcmcia(int socket, struct gpiod_lookup_table *);
> -
> -struct software_node;
> -extern const struct software_node sa1100_gpiochip_node;
> -
> -struct fixed_voltage_config;
> -struct regulator_consumer_supply;
> -int sa11x0_register_fixed_regulator(int n, struct fixed_voltage_config *cfg,
> -	struct regulator_consumer_supply *supplies, unsigned num_supplies,
> -	bool uses_gpio);
> diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
> deleted file mode 100644
> index 59e9251a138e..000000000000
> --- a/arch/arm/mach-sa1100/h3600.c
> +++ /dev/null
> @@ -1,134 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Support for Compaq iPAQ H3600 handheld computer
> - *
> - * Copyright (c) 2000,1 Compaq Computer Corporation. (Author: Jamey Hicks)
> - * Copyright (c) 2009 Dmitry Artamonow <mad_soft@inbox.ru>
> - */
> -
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/gpio/legacy.h>
> -
> -#include <video/sa1100fb.h>
> -
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -
> -#include <mach/h3xxx.h>
> -#include <mach/irqs.h>
> -
> -#include "generic.h"
> -
> -static bool h3600_lcd_request(void)
> -{
> -	static bool h3600_lcd_ok;
> -	int rc;
> -
> -	if (h3600_lcd_ok)
> -		return true;
> -
> -	rc = gpio_request(H3XXX_EGPIO_LCD_ON, "LCD power");
> -	if (rc)
> -		goto out;
> -	rc = gpio_direction_output(H3XXX_EGPIO_LCD_ON, 0);
> -	if (rc)
> -		goto out_free_on;
> -	rc = gpio_request(H3600_EGPIO_LCD_PCI, "LCD control");
> -	if (rc)
> -		goto out_free_on;
> -	rc = gpio_direction_output(H3600_EGPIO_LCD_PCI, 0);
> -	if (rc)
> -		goto out_free_pci;
> -	rc = gpio_request(H3600_EGPIO_LCD_5V_ON, "LCD 5v");
> -	if (rc)
> -		goto out_free_pci;
> -	rc = gpio_direction_output(H3600_EGPIO_LCD_5V_ON, 0);
> -	if (rc)
> -		goto out_free_5v_on;
> -	rc = gpio_request(H3600_EGPIO_LVDD_ON, "LCD 9v/-6.5v");
> -	if (rc)
> -		goto out_free_5v_on;
> -	rc = gpio_direction_output(H3600_EGPIO_LVDD_ON, 0);
> -	if (rc)
> -		goto out_free_lvdd_on;
> -
> -	goto out;
> -
> -out_free_lvdd_on:
> -	gpio_free(H3600_EGPIO_LVDD_ON);
> -out_free_5v_on:
> -	gpio_free(H3600_EGPIO_LCD_5V_ON);
> -out_free_pci:
> -	gpio_free(H3600_EGPIO_LCD_PCI);
> -out_free_on:
> -	gpio_free(H3XXX_EGPIO_LCD_ON);
> -out:
> -	if (rc)
> -		pr_err("%s: can't request GPIOs\n", __func__);
> -	else
> -		h3600_lcd_ok = true;
> -
> -	return h3600_lcd_ok;
> -}
> -
> -static void h3600_lcd_power(int enable)
> -{
> -	if (!h3600_lcd_request())
> -		return;
> -
> -	gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
> -	gpio_direction_output(H3600_EGPIO_LCD_PCI, enable);
> -	gpio_direction_output(H3600_EGPIO_LCD_5V_ON, enable);
> -	gpio_direction_output(H3600_EGPIO_LVDD_ON, enable);
> -}
> -
> -static const struct sa1100fb_rgb h3600_rgb_16 = {
> -	.red	= { .offset = 12, .length = 4, },
> -	.green	= { .offset = 7,  .length = 4, },
> -	.blue	= { .offset = 1,  .length = 4, },
> -	.transp	= { .offset = 0,  .length = 0, },
> -};
> -
> -static struct sa1100fb_mach_info h3600_lcd_info = {
> -	.pixclock	= 174757, 	.bpp		= 16,
> -	.xres		= 320,		.yres		= 240,
> -
> -	.hsync_len	= 3,		.vsync_len	= 3,
> -	.left_margin	= 12,		.upper_margin	= 10,
> -	.right_margin	= 17,		.lower_margin	= 1,
> -
> -	.cmap_static	= 1,
> -
> -	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
> -	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
> -
> -	.rgb[RGB_16] = &h3600_rgb_16,
> -
> -	.lcd_power = h3600_lcd_power,
> -};
> -
> -
> -static void __init h3600_map_io(void)
> -{
> -	h3xxx_map_io();
> -}
> -
> -static void __init h3600_mach_init(void)
> -{
> -	h3xxx_mach_init();
> -
> -	sa11x0_register_lcd(&h3600_lcd_info);
> -}
> -
> -MACHINE_START(H3600, "Compaq iPAQ H3600")
> -	.atag_offset	= 0x100,
> -	.map_io		= h3600_map_io,
> -	.nr_irqs	= SA1100_NR_IRQS,
> -	.init_irq	= sa1100_init_irq,
> -	.init_time	= sa1100_timer_init,
> -	.init_machine	= h3600_mach_init,
> -	.init_late	= sa11x0_init_late,
> -	.restart	= sa11x0_restart,
> -MACHINE_END
> -
> diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
> deleted file mode 100644
> index 6f4c5d2be569..000000000000
> --- a/arch/arm/mach-sa1100/h3xxx.c
> +++ /dev/null
> @@ -1,305 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Support for Compaq iPAQ H3100 and H3600 handheld computers (common code)
> - *
> - * Copyright (c) 2000,1 Compaq Computer Corporation. (Author: Jamey Hicks)
> - * Copyright (c) 2009 Dmitry Artamonow <mad_soft@inbox.ru>
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/gpio/legacy.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/gpio/property.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/input.h>
> -#include <linux/property.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/partitions.h>
> -#include <linux/platform_data/gpio-htc-egpio.h>
> -#include <linux/platform_data/sa11x0-serial.h>
> -#include <linux/platform_device.h>
> -#include <linux/serial_core.h>
> -
> -#include <asm/mach/flash.h>
> -#include <asm/mach/map.h>
> -
> -#include <mach/h3xxx.h>
> -#include <mach/irqs.h>
> -
> -#include "generic.h"
> -
> -/*
> - * H3xxx flash support
> - */
> -static struct mtd_partition h3xxx_partitions[] = {
> -	{
> -		.name		= "H3XXX boot firmware",
> -		.size		= 0x00040000,
> -		.offset		= 0,
> -		.mask_flags	= MTD_WRITEABLE,  /* force read-only */
> -	}, {
> -		.name		= "H3XXX rootfs",
> -		.size		= MTDPART_SIZ_FULL,
> -		.offset		= 0x00040000,
> -	}
> -};
> -
> -static void h3xxx_set_vpp(int vpp)
> -{
> -	gpio_set_value(H3XXX_EGPIO_VPP_ON, vpp);
> -}
> -
> -static int h3xxx_flash_init(void)
> -{
> -	int err = gpio_request(H3XXX_EGPIO_VPP_ON, "Flash Vpp");
> -	if (err) {
> -		pr_err("%s: can't request H3XXX_EGPIO_VPP_ON\n", __func__);
> -		return err;
> -	}
> -
> -	err = gpio_direction_output(H3XXX_EGPIO_VPP_ON, 0);
> -	if (err)
> -		gpio_free(H3XXX_EGPIO_VPP_ON);
> -
> -	return err;
> -}
> -
> -static void h3xxx_flash_exit(void)
> -{
> -	gpio_free(H3XXX_EGPIO_VPP_ON);
> -}
> -
> -static struct flash_platform_data h3xxx_flash_data = {
> -	.map_name	= "cfi_probe",
> -	.set_vpp	= h3xxx_set_vpp,
> -	.init		= h3xxx_flash_init,
> -	.exit		= h3xxx_flash_exit,
> -	.parts		= h3xxx_partitions,
> -	.nr_parts	= ARRAY_SIZE(h3xxx_partitions),
> -};
> -
> -static struct resource h3xxx_flash_resource =
> -	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M);
> -
> -
> -/*
> - * H3xxx uart support
> - */
> -static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
> -{
> -	if (port->mapbase == _Ser3UTCR0) {
> -		if (!gpio_request(H3XXX_EGPIO_RS232_ON, "RS232 transceiver")) {
> -			gpio_direction_output(H3XXX_EGPIO_RS232_ON, !state);
> -			gpio_free(H3XXX_EGPIO_RS232_ON);
> -		} else {
> -			pr_err("%s: can't request H3XXX_EGPIO_RS232_ON\n",
> -				__func__);
> -		}
> -	}
> -}
> -
> -/*
> - * Enable/Disable wake up events for this serial port.
> - * Obviously, we only support this on the normal COM port.
> - */
> -static int h3xxx_uart_set_wake(struct uart_port *port, u_int enable)
> -{
> -	int err = -EINVAL;
> -
> -	if (port->mapbase == _Ser3UTCR0) {
> -		if (enable)
> -			PWER |= PWER_GPIO23 | PWER_GPIO25; /* DCD and CTS */
> -		else
> -			PWER &= ~(PWER_GPIO23 | PWER_GPIO25); /* DCD and CTS */
> -		err = 0;
> -	}
> -	return err;
> -}
> -
> -static struct sa1100_port_fns h3xxx_port_fns __initdata = {
> -	.pm		= h3xxx_uart_pm,
> -	.set_wake	= h3xxx_uart_set_wake,
> -};
> -
> -static struct gpiod_lookup_table h3xxx_uart3_gpio_table = {
> -	.dev_id = "sa11x0-uart.3",
> -	.table = {
> -		GPIO_LOOKUP("gpio", H3XXX_GPIO_COM_DCD, "dcd", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("gpio", H3XXX_GPIO_COM_CTS, "cts", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("gpio", H3XXX_GPIO_COM_RTS, "rts", GPIO_ACTIVE_LOW),
> -		{ },
> -	},
> -};
> -
> -/*
> - * EGPIO
> - */
> -
> -static struct resource egpio_resources[] = {
> -	[0] = DEFINE_RES_MEM(H3600_EGPIO_PHYS, 0x4),
> -};
> -
> -static struct htc_egpio_chip egpio_chips[] = {
> -	[0] = {
> -		.reg_start	= 0,
> -		.gpio_base	= H3XXX_EGPIO_BASE,
> -		.num_gpios	= 16,
> -		.direction	= HTC_EGPIO_OUTPUT,
> -		.initial_values	= 0x0080, /* H3XXX_EGPIO_RS232_ON */
> -	},
> -};
> -
> -static struct htc_egpio_platform_data egpio_info = {
> -	.reg_width	= 16,
> -	.bus_width	= 16,
> -	.chip		= egpio_chips,
> -	.num_chips	= ARRAY_SIZE(egpio_chips),
> -};
> -
> -static struct platform_device h3xxx_egpio = {
> -	.name		= "htc-egpio",
> -	.id		= -1,
> -	.resource	= egpio_resources,
> -	.num_resources	= ARRAY_SIZE(egpio_resources),
> -	.dev		= {
> -		.platform_data = &egpio_info,
> -	},
> -};
> -
> -/*
> - * GPIO keys
> - */
> -
> -static const struct software_node h3xxx_gpio_keys_node = {
> -	.name = "h3xxx-gpio-keys",
> -};
> -
> -static const struct property_entry h3xxx_power_key_props[] = {
> -	PROPERTY_ENTRY_U32("linux,code", KEY_POWER),
> -	PROPERTY_ENTRY_GPIO("gpios", &sa1100_gpiochip_node,
> -			    H3XXX_GPIO_PWR_BUTTON, GPIO_ACTIVE_LOW),
> -	PROPERTY_ENTRY_STRING("label", "Power Button"),
> -	PROPERTY_ENTRY_BOOL("wakeup-source"),
> -	{ }
> -};
> -
> -static const struct software_node h3xxx_power_key_node = {
> -	.parent = &h3xxx_gpio_keys_node,
> -	.properties = h3xxx_power_key_props,
> -};
> -
> -static const struct property_entry h3xxx_action_key_props[] = {
> -	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> -	PROPERTY_ENTRY_GPIO("gpios", &sa1100_gpiochip_node,
> -			    H3XXX_GPIO_ACTION_BUTTON, GPIO_ACTIVE_LOW),
> -	PROPERTY_ENTRY_STRING("label", "Action button"),
> -	{ }
> -};
> -
> -static const struct software_node h3xxx_action_key_node = {
> -	.parent = &h3xxx_gpio_keys_node,
> -	.properties = h3xxx_action_key_props,
> -};
> -
> -static const struct software_node * const h3xxx_gpio_keys_swnodes[] __initconst = {
> -	&h3xxx_gpio_keys_node,
> -	&h3xxx_power_key_node,
> -	&h3xxx_action_key_node,
> -	NULL
> -};
> -
> -static const struct platform_device_info h3xxx_gpio_keys_dev_info __initconst = {
> -	.name = "gpio-keys",
> -	.id = PLATFORM_DEVID_NONE,
> -	.swnode = &h3xxx_gpio_keys_node,
> -};
> -
> -static struct resource h3xxx_micro_resources[] = {
> -	DEFINE_RES_MEM(0x80010000, SZ_4K),
> -	DEFINE_RES_MEM(0x80020000, SZ_4K),
> -	DEFINE_RES_IRQ(IRQ_Ser1UART),
> -};
> -
> -struct platform_device h3xxx_micro_asic = {
> -	.name = "ipaq-h3xxx-micro",
> -	.id = -1,
> -	.resource = h3xxx_micro_resources,
> -	.num_resources = ARRAY_SIZE(h3xxx_micro_resources),
> -};
> -
> -static struct platform_device *h3xxx_devices[] = {
> -	&h3xxx_egpio,
> -	&h3xxx_micro_asic,
> -};
> -
> -static struct gpiod_lookup_table h3xxx_pcmcia_gpio_table = {
> -	.dev_id = "sa11x0-pcmcia",
> -	.table = {
> -		GPIO_LOOKUP("gpio", H3XXX_GPIO_PCMCIA_CD0,
> -			    "pcmcia0-detect", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("gpio", H3XXX_GPIO_PCMCIA_IRQ0,
> -			    "pcmcia0-ready", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("gpio", H3XXX_GPIO_PCMCIA_CD1,
> -			    "pcmcia1-detect", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("gpio", H3XXX_GPIO_PCMCIA_IRQ1,
> -			    "pcmcia1-ready", GPIO_ACTIVE_HIGH),
> -		{ },
> -	},
> -};
> -
> -void __init h3xxx_mach_init(void)
> -{
> -	gpiod_add_lookup_table(&h3xxx_pcmcia_gpio_table);
> -	gpiod_add_lookup_table(&h3xxx_uart3_gpio_table);
> -	sa1100_register_uart_fns(&h3xxx_port_fns);
> -	sa11x0_register_mtd(&h3xxx_flash_data, &h3xxx_flash_resource, 1);
> -	platform_add_devices(h3xxx_devices, ARRAY_SIZE(h3xxx_devices));
> -	software_node_register_node_group(h3xxx_gpio_keys_swnodes);
> -	platform_device_register_full(&h3xxx_gpio_keys_dev_info);
> -}
> -
> -static struct map_desc h3600_io_desc[] __initdata = {
> -	{	/* static memory bank 2  CS#2 */
> -		.virtual	=  H3600_BANK_2_VIRT,
> -		.pfn		= __phys_to_pfn(SA1100_CS2_PHYS),
> -		.length		= 0x02800000,
> -		.type		= MT_DEVICE
> -	}, {	/* static memory bank 4  CS#4 */
> -		.virtual	=  H3600_BANK_4_VIRT,
> -		.pfn		= __phys_to_pfn(SA1100_CS4_PHYS),
> -		.length		= 0x00800000,
> -		.type		= MT_DEVICE
> -	}, {	/* EGPIO 0		CS#5 */
> -		.virtual	=  H3600_EGPIO_VIRT,
> -		.pfn		= __phys_to_pfn(H3600_EGPIO_PHYS),
> -		.length		= 0x01000000,
> -		.type		= MT_DEVICE
> -	}
> -};
> -
> -/*
> - * Common map_io initialization
> - */
> -
> -void __init h3xxx_map_io(void)
> -{
> -	sa1100_map_io();
> -	iotable_init(h3600_io_desc, ARRAY_SIZE(h3600_io_desc));
> -
> -	sa1100_register_uart(0, 3); /* Common serial port */
> -//	sa1100_register_uart(1, 1); /* Microcontroller on 3100/3600 */
> -
> -	/* Ensure those pins are outputs and driving low  */
> -	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
> -	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
> -
> -	/* Configure suspend conditions */
> -	PGSR = 0;
> -	PCFR = PCFR_OPDE;
> -	PSDR = 0;
> -
> -	GPCR = 0x0fffffff;	/* All outputs are set low by default */
> -	GPDR = 0;		/* Configure all GPIOs as input */
> -}
> -
> diff --git a/arch/arm/mach-sa1100/include/mach/SA-1100.h b/arch/arm/mach-sa1100/include/mach/SA-1100.h
> deleted file mode 100644
> index 6e6ff3e18f0f..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/SA-1100.h
> +++ /dev/null
> @@ -1,1798 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - *	FILE    	SA-1100.h
> - *
> - *	Version 	1.2
> - *	Author  	Copyright (c) Marc A. Viredaz, 1998
> - *	        	DEC Western Research Laboratory, Palo Alto, CA
> - *	Date    	January 1998 (April 1997)
> - *	System  	StrongARM SA-1100
> - *	Language	C or ARM Assembly
> - *	Purpose 	Definition of constants related to the StrongARM
> - *	        	SA-1100 microprocessor (Advanced RISC Machine (ARM)
> - *	        	architecture version 4). This file is based on the
> - *	        	StrongARM SA-1100 data sheet version 2.2.
> - *
> - */
> -
> -
> -/* Be sure that virtual mapping is defined right */
> -#ifndef __ASM_ARCH_HARDWARE_H
> -#error You must include hardware.h not SA-1100.h
> -#endif
> -
> -#include "bitfield.h"
> -
> -/*
> - * SA1100 CS line to physical address
> - */
> -
> -#define SA1100_CS0_PHYS	0x00000000
> -#define SA1100_CS1_PHYS	0x08000000
> -#define SA1100_CS2_PHYS	0x10000000
> -#define SA1100_CS3_PHYS	0x18000000
> -#define SA1100_CS4_PHYS	0x40000000
> -#define SA1100_CS5_PHYS	0x48000000
> -
> -/*
> - * Personal Computer Memory Card International Association (PCMCIA) sockets
> - */
> -
> -#define PCMCIAPrtSp	0x04000000	/* PCMCIA Partition Space [byte]   */
> -#define PCMCIASp	(4*PCMCIAPrtSp)	/* PCMCIA Space [byte]             */
> -#define PCMCIAIOSp	PCMCIAPrtSp	/* PCMCIA I/O Space [byte]         */
> -#define PCMCIAAttrSp	PCMCIAPrtSp	/* PCMCIA Attribute Space [byte]   */
> -#define PCMCIAMemSp	PCMCIAPrtSp	/* PCMCIA Memory Space [byte]      */
> -
> -#define PCMCIA0Sp	PCMCIASp	/* PCMCIA 0 Space [byte]           */
> -#define PCMCIA0IOSp	PCMCIAIOSp	/* PCMCIA 0 I/O Space [byte]       */
> -#define PCMCIA0AttrSp	PCMCIAAttrSp	/* PCMCIA 0 Attribute Space [byte] */
> -#define PCMCIA0MemSp	PCMCIAMemSp	/* PCMCIA 0 Memory Space [byte]    */
> -
> -#define PCMCIA1Sp	PCMCIASp	/* PCMCIA 1 Space [byte]           */
> -#define PCMCIA1IOSp	PCMCIAIOSp	/* PCMCIA 1 I/O Space [byte]       */
> -#define PCMCIA1AttrSp	PCMCIAAttrSp	/* PCMCIA 1 Attribute Space [byte] */
> -#define PCMCIA1MemSp	PCMCIAMemSp	/* PCMCIA 1 Memory Space [byte]    */
> -
> -#define _PCMCIA(Nb)	        	/* PCMCIA [0..1]                   */ \
> -                	(0x20000000 + (Nb)*PCMCIASp)
> -#define _PCMCIAIO(Nb)	_PCMCIA (Nb)	/* PCMCIA I/O [0..1]               */
> -#define _PCMCIAAttr(Nb)	        	/* PCMCIA Attribute [0..1]         */ \
> -                	(_PCMCIA (Nb) + 2*PCMCIAPrtSp)
> -#define _PCMCIAMem(Nb)	        	/* PCMCIA Memory [0..1]            */ \
> -                	(_PCMCIA (Nb) + 3*PCMCIAPrtSp)
> -
> -#define _PCMCIA0	_PCMCIA (0)	/* PCMCIA 0                        */
> -#define _PCMCIA0IO	_PCMCIAIO (0)	/* PCMCIA 0 I/O                    */
> -#define _PCMCIA0Attr	_PCMCIAAttr (0)	/* PCMCIA 0 Attribute              */
> -#define _PCMCIA0Mem	_PCMCIAMem (0)	/* PCMCIA 0 Memory                 */
> -
> -#define _PCMCIA1	_PCMCIA (1)	/* PCMCIA 1                        */
> -#define _PCMCIA1IO	_PCMCIAIO (1)	/* PCMCIA 1 I/O                    */
> -#define _PCMCIA1Attr	_PCMCIAAttr (1)	/* PCMCIA 1 Attribute              */
> -#define _PCMCIA1Mem	_PCMCIAMem (1)	/* PCMCIA 1 Memory                 */
> -
> -
> -/*
> - * Universal Serial Bus (USB) Device Controller (UDC) control registers
> - *
> - * Registers
> - *    Ser0UDCCR 	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Control Register (read/write).
> - *    Ser0UDCAR 	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Address Register (read/write).
> - *    Ser0UDCOMP	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Output Maximum Packet size register
> - *              	(read/write).
> - *    Ser0UDCIMP	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Input Maximum Packet size register
> - *              	(read/write).
> - *    Ser0UDCCS0	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Control/Status register end-point 0
> - *              	(read/write).
> - *    Ser0UDCCS1	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Control/Status register end-point 1
> - *              	(output, read/write).
> - *    Ser0UDCCS2	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Control/Status register end-point 2
> - *              	(input, read/write).
> - *    Ser0UDCD0 	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Data register end-point 0
> - *              	(read/write).
> - *    Ser0UDCWC 	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Write Count register end-point 0
> - *              	(read).
> - *    Ser0UDCDR 	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Data Register (read/write).
> - *    Ser0UDCSR 	Serial port 0 Universal Serial Bus (USB) Device
> - *              	Controller (UDC) Status Register (read/write).
> - */
> -
> -#define Ser0UDCCR	__REG(0x80000000)  /* Ser. port 0 UDC Control Reg. */
> -#define Ser0UDCAR	__REG(0x80000004)  /* Ser. port 0 UDC Address Reg. */
> -#define Ser0UDCOMP	__REG(0x80000008)  /* Ser. port 0 UDC Output Maximum Packet size reg. */
> -#define Ser0UDCIMP	__REG(0x8000000C)  /* Ser. port 0 UDC Input Maximum Packet size reg. */
> -#define Ser0UDCCS0	__REG(0x80000010)  /* Ser. port 0 UDC Control/Status reg. end-point 0 */
> -#define Ser0UDCCS1	__REG(0x80000014)  /* Ser. port 0 UDC Control/Status reg. end-point 1 (output) */
> -#define Ser0UDCCS2	__REG(0x80000018)  /* Ser. port 0 UDC Control/Status reg. end-point 2 (input) */
> -#define Ser0UDCD0	__REG(0x8000001C)  /* Ser. port 0 UDC Data reg. end-point 0 */
> -#define Ser0UDCWC	__REG(0x80000020)  /* Ser. port 0 UDC Write Count reg. end-point 0 */
> -#define Ser0UDCDR	__REG(0x80000028)  /* Ser. port 0 UDC Data Reg. */
> -#define Ser0UDCSR	__REG(0x80000030)  /* Ser. port 0 UDC Status Reg. */
> -
> -#define UDCCR_UDD	0x00000001	/* UDC Disable                     */
> -#define UDCCR_UDA	0x00000002	/* UDC Active (read)               */
> -#define UDCCR_RESIM	0x00000004	/* Resume Interrupt Mask, per errata */
> -#define UDCCR_EIM	0x00000008	/* End-point 0 Interrupt Mask      */
> -                	        	/* (disable)                       */
> -#define UDCCR_RIM	0x00000010	/* Receive Interrupt Mask          */
> -                	        	/* (disable)                       */
> -#define UDCCR_TIM	0x00000020	/* Transmit Interrupt Mask         */
> -                	        	/* (disable)                       */
> -#define UDCCR_SRM	0x00000040	/* Suspend/Resume interrupt Mask   */
> -                	        	/* (disable)                       */
> -#define UDCCR_SUSIM	UDCCR_SRM	/* Per errata, SRM just masks suspend */
> -#define UDCCR_REM	0x00000080	/* REset interrupt Mask (disable)  */
> -
> -#define UDCAR_ADD	Fld (7, 0)	/* function ADDress                */
> -
> -#define UDCOMP_OUTMAXP	Fld (8, 0)	/* OUTput MAXimum Packet size - 1  */
> -                	        	/* [byte]                          */
> -#define UDCOMP_OutMaxPkt(Size)  	/* Output Maximum Packet size      */ \
> -                	        	/* [1..256 byte]                   */ \
> -                	(((Size) - 1) << FShft (UDCOMP_OUTMAXP))
> -
> -#define UDCIMP_INMAXP	Fld (8, 0)	/* INput MAXimum Packet size - 1   */
> -                	        	/* [byte]                          */
> -#define UDCIMP_InMaxPkt(Size)   	/* Input Maximum Packet size       */ \
> -                	        	/* [1..256 byte]                   */ \
> -                	(((Size) - 1) << FShft (UDCIMP_INMAXP))
> -
> -#define UDCCS0_OPR	0x00000001	/* Output Packet Ready (read)      */
> -#define UDCCS0_IPR	0x00000002	/* Input Packet Ready              */
> -#define UDCCS0_SST	0x00000004	/* Sent STall                      */
> -#define UDCCS0_FST	0x00000008	/* Force STall                     */
> -#define UDCCS0_DE	0x00000010	/* Data End                        */
> -#define UDCCS0_SE	0x00000020	/* Setup End (read)                */
> -#define UDCCS0_SO	0x00000040	/* Serviced Output packet ready    */
> -                	        	/* (write)                         */
> -#define UDCCS0_SSE	0x00000080	/* Serviced Setup End (write)      */
> -
> -#define UDCCS1_RFS	0x00000001	/* Receive FIFO 12-bytes or more   */
> -                	        	/* Service request (read)          */
> -#define UDCCS1_RPC	0x00000002	/* Receive Packet Complete         */
> -#define UDCCS1_RPE	0x00000004	/* Receive Packet Error (read)     */
> -#define UDCCS1_SST	0x00000008	/* Sent STall                      */
> -#define UDCCS1_FST	0x00000010	/* Force STall                     */
> -#define UDCCS1_RNE	0x00000020	/* Receive FIFO Not Empty (read)   */
> -
> -#define UDCCS2_TFS	0x00000001	/* Transmit FIFO 8-bytes or less   */
> -                	        	/* Service request (read)          */
> -#define UDCCS2_TPC	0x00000002	/* Transmit Packet Complete        */
> -#define UDCCS2_TPE	0x00000004	/* Transmit Packet Error (read)    */
> -#define UDCCS2_TUR	0x00000008	/* Transmit FIFO Under-Run         */
> -#define UDCCS2_SST	0x00000010	/* Sent STall                      */
> -#define UDCCS2_FST	0x00000020	/* Force STall                     */
> -
> -#define UDCD0_DATA	Fld (8, 0)	/* receive/transmit DATA FIFOs     */
> -
> -#define UDCWC_WC	Fld (4, 0)	/* Write Count                     */
> -
> -#define UDCDR_DATA	Fld (8, 0)	/* receive/transmit DATA FIFOs     */
> -
> -#define UDCSR_EIR	0x00000001	/* End-point 0 Interrupt Request   */
> -#define UDCSR_RIR	0x00000002	/* Receive Interrupt Request       */
> -#define UDCSR_TIR	0x00000004	/* Transmit Interrupt Request      */
> -#define UDCSR_SUSIR	0x00000008	/* SUSpend Interrupt Request       */
> -#define UDCSR_RESIR	0x00000010	/* RESume Interrupt Request        */
> -#define UDCSR_RSTIR	0x00000020	/* ReSeT Interrupt Request         */
> -
> -
> -/*
> - * Universal Asynchronous Receiver/Transmitter (UART) control registers
> - *
> - * Registers
> - *    Ser1UTCR0 	Serial port 1 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 0
> - *              	(read/write).
> - *    Ser1UTCR1 	Serial port 1 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 1
> - *              	(read/write).
> - *    Ser1UTCR2 	Serial port 1 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 2
> - *              	(read/write).
> - *    Ser1UTCR3 	Serial port 1 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 3
> - *              	(read/write).
> - *    Ser1UTDR  	Serial port 1 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Data Register
> - *              	(read/write).
> - *    Ser1UTSR0 	Serial port 1 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Status Register 0
> - *              	(read/write).
> - *    Ser1UTSR1 	Serial port 1 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Status Register 1 (read).
> - *
> - *    Ser2UTCR0 	Serial port 2 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 0
> - *              	(read/write).
> - *    Ser2UTCR1 	Serial port 2 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 1
> - *              	(read/write).
> - *    Ser2UTCR2 	Serial port 2 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 2
> - *              	(read/write).
> - *    Ser2UTCR3 	Serial port 2 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 3
> - *              	(read/write).
> - *    Ser2UTCR4 	Serial port 2 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 4
> - *              	(read/write).
> - *    Ser2UTDR  	Serial port 2 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Data Register
> - *              	(read/write).
> - *    Ser2UTSR0 	Serial port 2 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Status Register 0
> - *              	(read/write).
> - *    Ser2UTSR1 	Serial port 2 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Status Register 1 (read).
> - *
> - *    Ser3UTCR0 	Serial port 3 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 0
> - *              	(read/write).
> - *    Ser3UTCR1 	Serial port 3 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 1
> - *              	(read/write).
> - *    Ser3UTCR2 	Serial port 3 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 2
> - *              	(read/write).
> - *    Ser3UTCR3 	Serial port 3 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Control Register 3
> - *              	(read/write).
> - *    Ser3UTDR  	Serial port 3 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Data Register
> - *              	(read/write).
> - *    Ser3UTSR0 	Serial port 3 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Status Register 0
> - *              	(read/write).
> - *    Ser3UTSR1 	Serial port 3 Universal Asynchronous
> - *              	Receiver/Transmitter (UART) Status Register 1 (read).
> - *
> - * Clocks
> - *    fxtl, Txtl	Frequency, period of the system crystal (3.6864 MHz
> - *              	or 3.5795 MHz).
> - *    fua, Tua  	Frequency, period of the UART communication.
> - */
> -
> -#define _UTCR0(Nb)	__REG(0x80010000 + ((Nb) - 1)*0x00020000)  /* UART Control Reg. 0 [1..3] */
> -#define _UTCR1(Nb)	__REG(0x80010004 + ((Nb) - 1)*0x00020000)  /* UART Control Reg. 1 [1..3] */
> -#define _UTCR2(Nb)	__REG(0x80010008 + ((Nb) - 1)*0x00020000)  /* UART Control Reg. 2 [1..3] */
> -#define _UTCR3(Nb)	__REG(0x8001000C + ((Nb) - 1)*0x00020000)  /* UART Control Reg. 3 [1..3] */
> -#define _UTCR4(Nb)	__REG(0x80010010 + ((Nb) - 1)*0x00020000)  /* UART Control Reg. 4 [2] */
> -#define _UTDR(Nb)	__REG(0x80010014 + ((Nb) - 1)*0x00020000)  /* UART Data Reg. [1..3] */
> -#define _UTSR0(Nb)	__REG(0x8001001C + ((Nb) - 1)*0x00020000)  /* UART Status Reg. 0 [1..3] */
> -#define _UTSR1(Nb)	__REG(0x80010020 + ((Nb) - 1)*0x00020000)  /* UART Status Reg. 1 [1..3] */
> -
> -#define Ser1UTCR0	_UTCR0 (1)	/* Ser. port 1 UART Control Reg. 0 */
> -#define Ser1UTCR1	_UTCR1 (1)	/* Ser. port 1 UART Control Reg. 1 */
> -#define Ser1UTCR2	_UTCR2 (1)	/* Ser. port 1 UART Control Reg. 2 */
> -#define Ser1UTCR3	_UTCR3 (1)	/* Ser. port 1 UART Control Reg. 3 */
> -#define Ser1UTDR	_UTDR (1)	/* Ser. port 1 UART Data Reg.      */
> -#define Ser1UTSR0	_UTSR0 (1)	/* Ser. port 1 UART Status Reg. 0  */
> -#define Ser1UTSR1	_UTSR1 (1)	/* Ser. port 1 UART Status Reg. 1  */
> -
> -#define Ser2UTCR0	_UTCR0 (2)	/* Ser. port 2 UART Control Reg. 0 */
> -#define Ser2UTCR1	_UTCR1 (2)	/* Ser. port 2 UART Control Reg. 1 */
> -#define Ser2UTCR2	_UTCR2 (2)	/* Ser. port 2 UART Control Reg. 2 */
> -#define Ser2UTCR3	_UTCR3 (2)	/* Ser. port 2 UART Control Reg. 3 */
> -#define Ser2UTCR4	_UTCR4 (2)	/* Ser. port 2 UART Control Reg. 4 */
> -#define Ser2UTDR	_UTDR (2)	/* Ser. port 2 UART Data Reg.      */
> -#define Ser2UTSR0	_UTSR0 (2)	/* Ser. port 2 UART Status Reg. 0  */
> -#define Ser2UTSR1	_UTSR1 (2)	/* Ser. port 2 UART Status Reg. 1  */
> -
> -#define Ser3UTCR0	_UTCR0 (3)	/* Ser. port 3 UART Control Reg. 0 */
> -#define Ser3UTCR1	_UTCR1 (3)	/* Ser. port 3 UART Control Reg. 1 */
> -#define Ser3UTCR2	_UTCR2 (3)	/* Ser. port 3 UART Control Reg. 2 */
> -#define Ser3UTCR3	_UTCR3 (3)	/* Ser. port 3 UART Control Reg. 3 */
> -#define Ser3UTDR	_UTDR (3)	/* Ser. port 3 UART Data Reg.      */
> -#define Ser3UTSR0	_UTSR0 (3)	/* Ser. port 3 UART Status Reg. 0  */
> -#define Ser3UTSR1	_UTSR1 (3)	/* Ser. port 3 UART Status Reg. 1  */
> -
> -/* Those are still used in some places */
> -#define _Ser1UTCR0	__PREG(Ser1UTCR0)
> -#define _Ser2UTCR0	__PREG(Ser2UTCR0)
> -#define _Ser3UTCR0	__PREG(Ser3UTCR0)
> -
> -/* Register offsets */
> -#define UTCR0		0x00
> -#define UTCR1		0x04
> -#define UTCR2		0x08
> -#define UTCR3		0x0c
> -#define UTDR		0x14
> -#define UTSR0		0x1c
> -#define UTSR1		0x20
> -
> -#define UTCR0_PE	0x00000001	/* Parity Enable                   */
> -#define UTCR0_OES	0x00000002	/* Odd/Even parity Select          */
> -#define UTCR0_OddPar	(UTCR0_OES*0)	/*  Odd Parity                     */
> -#define UTCR0_EvenPar	(UTCR0_OES*1)	/*  Even Parity                    */
> -#define UTCR0_SBS	0x00000004	/* Stop Bit Select                 */
> -#define UTCR0_1StpBit	(UTCR0_SBS*0)	/*  1 Stop Bit per frame           */
> -#define UTCR0_2StpBit	(UTCR0_SBS*1)	/*  2 Stop Bits per frame          */
> -#define UTCR0_DSS	0x00000008	/* Data Size Select                */
> -#define UTCR0_7BitData	(UTCR0_DSS*0)	/*  7-Bit Data                     */
> -#define UTCR0_8BitData	(UTCR0_DSS*1)	/*  8-Bit Data                     */
> -#define UTCR0_SCE	0x00000010	/* Sample Clock Enable             */
> -                	        	/* (ser. port 1: GPIO [18],        */
> -                	        	/* ser. port 3: GPIO [20])         */
> -#define UTCR0_RCE	0x00000020	/* Receive Clock Edge select       */
> -#define UTCR0_RcRsEdg	(UTCR0_RCE*0)	/*  Receive clock Rising-Edge      */
> -#define UTCR0_RcFlEdg	(UTCR0_RCE*1)	/*  Receive clock Falling-Edge     */
> -#define UTCR0_TCE	0x00000040	/* Transmit Clock Edge select      */
> -#define UTCR0_TrRsEdg	(UTCR0_TCE*0)	/*  Transmit clock Rising-Edge     */
> -#define UTCR0_TrFlEdg	(UTCR0_TCE*1)	/*  Transmit clock Falling-Edge    */
> -#define UTCR0_Ser2IrDA	        	/* Ser. port 2 IrDA settings       */ \
> -                	(UTCR0_1StpBit + UTCR0_8BitData)
> -
> -#define UTCR1_BRD	Fld (4, 0)	/* Baud Rate Divisor/16 - 1 [11:8] */
> -#define UTCR2_BRD	Fld (8, 0)	/* Baud Rate Divisor/16 - 1  [7:0] */
> -                	        	/* fua = fxtl/(16*(BRD[11:0] + 1)) */
> -                	        	/* Tua = 16*(BRD [11:0] + 1)*Txtl  */
> -#define UTCR1_BdRtDiv(Div)      	/*  Baud Rate Divisor [16..65536]  */ \
> -                	(((Div) - 16)/16 >> FSize (UTCR2_BRD) << \
> -                	 FShft (UTCR1_BRD))
> -#define UTCR2_BdRtDiv(Div)      	/*  Baud Rate Divisor [16..65536]  */ \
> -                	(((Div) - 16)/16 & FAlnMsk (UTCR2_BRD) << \
> -                	 FShft (UTCR2_BRD))
> -                	        	/*  fua = fxtl/(16*Floor (Div/16)) */
> -                	        	/*  Tua = 16*Floor (Div/16)*Txtl   */
> -#define UTCR1_CeilBdRtDiv(Div)  	/*  Ceil. of BdRtDiv [16..65536]   */ \
> -                	(((Div) - 1)/16 >> FSize (UTCR2_BRD) << \
> -                	 FShft (UTCR1_BRD))
> -#define UTCR2_CeilBdRtDiv(Div)  	/*  Ceil. of BdRtDiv [16..65536]   */ \
> -                	(((Div) - 1)/16 & FAlnMsk (UTCR2_BRD) << \
> -                	 FShft (UTCR2_BRD))
> -                	        	/*  fua = fxtl/(16*Ceil (Div/16))  */
> -                	        	/*  Tua = 16*Ceil (Div/16)*Txtl    */
> -
> -#define UTCR3_RXE	0x00000001	/* Receive Enable                  */
> -#define UTCR3_TXE	0x00000002	/* Transmit Enable                 */
> -#define UTCR3_BRK	0x00000004	/* BReaK mode                      */
> -#define UTCR3_RIE	0x00000008	/* Receive FIFO 1/3-to-2/3-full or */
> -                	        	/* more Interrupt Enable           */
> -#define UTCR3_TIE	0x00000010	/* Transmit FIFO 1/2-full or less  */
> -                	        	/* Interrupt Enable                */
> -#define UTCR3_LBM	0x00000020	/* Look-Back Mode                  */
> -#define UTCR3_Ser2IrDA	        	/* Ser. port 2 IrDA settings (RIE, */ \
> -                	        	/* TIE, LBM can be set or cleared) */ \
> -                	(UTCR3_RXE + UTCR3_TXE)
> -
> -#define UTCR4_HSE	0x00000001	/* Hewlett-Packard Serial InfraRed */
> -                	        	/* (HP-SIR) modulation Enable      */
> -#define UTCR4_NRZ	(UTCR4_HSE*0)	/*  Non-Return to Zero modulation  */
> -#define UTCR4_HPSIR	(UTCR4_HSE*1)	/*  HP-SIR modulation              */
> -#define UTCR4_LPM	0x00000002	/* Low-Power Mode                  */
> -#define UTCR4_Z3_16Bit	(UTCR4_LPM*0)	/*  Zero pulse = 3/16 Bit time     */
> -#define UTCR4_Z1_6us	(UTCR4_LPM*1)	/*  Zero pulse = 1.6 us            */
> -
> -#define UTDR_DATA	Fld (8, 0)	/* receive/transmit DATA FIFOs     */
> -#if 0           	        	/* Hidden receive FIFO bits        */
> -#define UTDR_PRE	0x00000100	/*  receive PaRity Error (read)    */
> -#define UTDR_FRE	0x00000200	/*  receive FRaming Error (read)   */
> -#define UTDR_ROR	0x00000400	/*  Receive FIFO Over-Run (read)   */
> -#endif /* 0 */
> -
> -#define UTSR0_TFS	0x00000001	/* Transmit FIFO 1/2-full or less  */
> -                	        	/* Service request (read)          */
> -#define UTSR0_RFS	0x00000002	/* Receive FIFO 1/3-to-2/3-full or */
> -                	        	/* more Service request (read)     */
> -#define UTSR0_RID	0x00000004	/* Receiver IDle                   */
> -#define UTSR0_RBB	0x00000008	/* Receive Beginning of Break      */
> -#define UTSR0_REB	0x00000010	/* Receive End of Break            */
> -#define UTSR0_EIF	0x00000020	/* Error In FIFO (read)            */
> -
> -#define UTSR1_TBY	0x00000001	/* Transmitter BusY (read)         */
> -#define UTSR1_RNE	0x00000002	/* Receive FIFO Not Empty (read)   */
> -#define UTSR1_TNF	0x00000004	/* Transmit FIFO Not Full (read)   */
> -#define UTSR1_PRE	0x00000008	/* receive PaRity Error (read)     */
> -#define UTSR1_FRE	0x00000010	/* receive FRaming Error (read)    */
> -#define UTSR1_ROR	0x00000020	/* Receive FIFO Over-Run (read)    */
> -
> -
> -/*
> - * Synchronous Data Link Controller (SDLC) control registers
> - *
> - * Registers
> - *    Ser1SDCR0 	Serial port 1 Synchronous Data Link Controller (SDLC)
> - *              	Control Register 0 (read/write).
> - *    Ser1SDCR1 	Serial port 1 Synchronous Data Link Controller (SDLC)
> - *              	Control Register 1 (read/write).
> - *    Ser1SDCR2 	Serial port 1 Synchronous Data Link Controller (SDLC)
> - *              	Control Register 2 (read/write).
> - *    Ser1SDCR3 	Serial port 1 Synchronous Data Link Controller (SDLC)
> - *              	Control Register 3 (read/write).
> - *    Ser1SDCR4 	Serial port 1 Synchronous Data Link Controller (SDLC)
> - *              	Control Register 4 (read/write).
> - *    Ser1SDDR  	Serial port 1 Synchronous Data Link Controller (SDLC)
> - *              	Data Register (read/write).
> - *    Ser1SDSR0 	Serial port 1 Synchronous Data Link Controller (SDLC)
> - *              	Status Register 0 (read/write).
> - *    Ser1SDSR1 	Serial port 1 Synchronous Data Link Controller (SDLC)
> - *              	Status Register 1 (read/write).
> - *
> - * Clocks
> - *    fxtl, Txtl	Frequency, period of the system crystal (3.6864 MHz
> - *              	or 3.5795 MHz).
> - *    fsd, Tsd  	Frequency, period of the SDLC communication.
> - */
> -
> -#define Ser1SDCR0	__REG(0x80020060)  /* Ser. port 1 SDLC Control Reg. 0 */
> -#define Ser1SDCR1	__REG(0x80020064)  /* Ser. port 1 SDLC Control Reg. 1 */
> -#define Ser1SDCR2	__REG(0x80020068)  /* Ser. port 1 SDLC Control Reg. 2 */
> -#define Ser1SDCR3	__REG(0x8002006C)  /* Ser. port 1 SDLC Control Reg. 3 */
> -#define Ser1SDCR4	__REG(0x80020070)  /* Ser. port 1 SDLC Control Reg. 4 */
> -#define Ser1SDDR	__REG(0x80020078)  /* Ser. port 1 SDLC Data Reg.      */
> -#define Ser1SDSR0	__REG(0x80020080)  /* Ser. port 1 SDLC Status Reg. 0  */
> -#define Ser1SDSR1	__REG(0x80020084)  /* Ser. port 1 SDLC Status Reg. 1  */
> -
> -#define SDCR0_SUS	0x00000001	/* SDLC/UART Select                */
> -#define SDCR0_SDLC	(SDCR0_SUS*0)	/*  SDLC mode (TXD1 & RXD1)        */
> -#define SDCR0_UART	(SDCR0_SUS*1)	/*  UART mode (TXD1 & RXD1)        */
> -#define SDCR0_SDF	0x00000002	/* Single/Double start Flag select */
> -#define SDCR0_SglFlg	(SDCR0_SDF*0)	/*  Single start Flag              */
> -#define SDCR0_DblFlg	(SDCR0_SDF*1)	/*  Double start Flag              */
> -#define SDCR0_LBM	0x00000004	/* Look-Back Mode                  */
> -#define SDCR0_BMS	0x00000008	/* Bit Modulation Select           */
> -#define SDCR0_FM0	(SDCR0_BMS*0)	/*  Freq. Modulation zero (0)      */
> -#define SDCR0_NRZ	(SDCR0_BMS*1)	/*  Non-Return to Zero modulation  */
> -#define SDCR0_SCE	0x00000010	/* Sample Clock Enable (GPIO [16]) */
> -#define SDCR0_SCD	0x00000020	/* Sample Clock Direction select   */
> -                	        	/* (GPIO [16])                     */
> -#define SDCR0_SClkIn	(SDCR0_SCD*0)	/*  Sample Clock Input             */
> -#define SDCR0_SClkOut	(SDCR0_SCD*1)	/*  Sample Clock Output            */
> -#define SDCR0_RCE	0x00000040	/* Receive Clock Edge select       */
> -#define SDCR0_RcRsEdg	(SDCR0_RCE*0)	/*  Receive clock Rising-Edge      */
> -#define SDCR0_RcFlEdg	(SDCR0_RCE*1)	/*  Receive clock Falling-Edge     */
> -#define SDCR0_TCE	0x00000080	/* Transmit Clock Edge select      */
> -#define SDCR0_TrRsEdg	(SDCR0_TCE*0)	/*  Transmit clock Rising-Edge     */
> -#define SDCR0_TrFlEdg	(SDCR0_TCE*1)	/*  Transmit clock Falling-Edge    */
> -
> -#define SDCR1_AAF	0x00000001	/* Abort After Frame enable        */
> -                	        	/* (GPIO [17])                     */
> -#define SDCR1_TXE	0x00000002	/* Transmit Enable                 */
> -#define SDCR1_RXE	0x00000004	/* Receive Enable                  */
> -#define SDCR1_RIE	0x00000008	/* Receive FIFO 1/3-to-2/3-full or */
> -                	        	/* more Interrupt Enable           */
> -#define SDCR1_TIE	0x00000010	/* Transmit FIFO 1/2-full or less  */
> -                	        	/* Interrupt Enable                */
> -#define SDCR1_AME	0x00000020	/* Address Match Enable            */
> -#define SDCR1_TUS	0x00000040	/* Transmit FIFO Under-run Select  */
> -#define SDCR1_EFrmURn	(SDCR1_TUS*0)	/*  End Frame on Under-Run         */
> -#define SDCR1_AbortURn	(SDCR1_TUS*1)	/*  Abort on Under-Run             */
> -#define SDCR1_RAE	0x00000080	/* Receive Abort interrupt Enable  */
> -
> -#define SDCR2_AMV	Fld (8, 0)	/* Address Match Value             */
> -
> -#define SDCR3_BRD	Fld (4, 0)	/* Baud Rate Divisor/16 - 1 [11:8] */
> -#define SDCR4_BRD	Fld (8, 0)	/* Baud Rate Divisor/16 - 1  [7:0] */
> -                	        	/* fsd = fxtl/(16*(BRD[11:0] + 1)) */
> -                	        	/* Tsd = 16*(BRD[11:0] + 1)*Txtl   */
> -#define SDCR3_BdRtDiv(Div)      	/*  Baud Rate Divisor [16..65536]  */ \
> -                	(((Div) - 16)/16 >> FSize (SDCR4_BRD) << \
> -                	 FShft (SDCR3_BRD))
> -#define SDCR4_BdRtDiv(Div)      	/*  Baud Rate Divisor [16..65536]  */ \
> -                	(((Div) - 16)/16 & FAlnMsk (SDCR4_BRD) << \
> -                	 FShft (SDCR4_BRD))
> -                	        	/*  fsd = fxtl/(16*Floor (Div/16)) */
> -                	        	/*  Tsd = 16*Floor (Div/16)*Txtl   */
> -#define SDCR3_CeilBdRtDiv(Div)  	/*  Ceil. of BdRtDiv [16..65536]   */ \
> -                	(((Div) - 1)/16 >> FSize (SDCR4_BRD) << \
> -                	 FShft (SDCR3_BRD))
> -#define SDCR4_CeilBdRtDiv(Div)  	/*  Ceil. of BdRtDiv [16..65536]   */ \
> -                	(((Div) - 1)/16 & FAlnMsk (SDCR4_BRD) << \
> -                	 FShft (SDCR4_BRD))
> -                	        	/*  fsd = fxtl/(16*Ceil (Div/16))  */
> -                	        	/*  Tsd = 16*Ceil (Div/16)*Txtl    */
> -
> -#define SDDR_DATA	Fld (8, 0)	/* receive/transmit DATA FIFOs     */
> -#if 0           	        	/* Hidden receive FIFO bits        */
> -#define SDDR_EOF	0x00000100	/*  receive End-Of-Frame (read)    */
> -#define SDDR_CRE	0x00000200	/*  receive CRC Error (read)       */
> -#define SDDR_ROR	0x00000400	/*  Receive FIFO Over-Run (read)   */
> -#endif /* 0 */
> -
> -#define SDSR0_EIF	0x00000001	/* Error In FIFO (read)            */
> -#define SDSR0_TUR	0x00000002	/* Transmit FIFO Under-Run         */
> -#define SDSR0_RAB	0x00000004	/* Receive ABort                   */
> -#define SDSR0_TFS	0x00000008	/* Transmit FIFO 1/2-full or less  */
> -                	        	/* Service request (read)          */
> -#define SDSR0_RFS	0x00000010	/* Receive FIFO 1/3-to-2/3-full or */
> -                	        	/* more Service request (read)     */
> -
> -#define SDSR1_RSY	0x00000001	/* Receiver SYnchronized (read)    */
> -#define SDSR1_TBY	0x00000002	/* Transmitter BusY (read)         */
> -#define SDSR1_RNE	0x00000004	/* Receive FIFO Not Empty (read)   */
> -#define SDSR1_TNF	0x00000008	/* Transmit FIFO Not Full (read)   */
> -#define SDSR1_RTD	0x00000010	/* Receive Transition Detected     */
> -#define SDSR1_EOF	0x00000020	/* receive End-Of-Frame (read)     */
> -#define SDSR1_CRE	0x00000040	/* receive CRC Error (read)        */
> -#define SDSR1_ROR	0x00000080	/* Receive FIFO Over-Run (read)    */
> -
> -
> -/*
> - * High-Speed Serial to Parallel controller (HSSP) control registers
> - *
> - * Registers
> - *    Ser2HSCR0 	Serial port 2 High-Speed Serial to Parallel
> - *              	controller (HSSP) Control Register 0 (read/write).
> - *    Ser2HSCR1 	Serial port 2 High-Speed Serial to Parallel
> - *              	controller (HSSP) Control Register 1 (read/write).
> - *    Ser2HSDR  	Serial port 2 High-Speed Serial to Parallel
> - *              	controller (HSSP) Data Register (read/write).
> - *    Ser2HSSR0 	Serial port 2 High-Speed Serial to Parallel
> - *              	controller (HSSP) Status Register 0 (read/write).
> - *    Ser2HSSR1 	Serial port 2 High-Speed Serial to Parallel
> - *              	controller (HSSP) Status Register 1 (read).
> - *    Ser2HSCR2 	Serial port 2 High-Speed Serial to Parallel
> - *              	controller (HSSP) Control Register 2 (read/write).
> - *              	[The HSCR2 register is only implemented in
> - *              	versions 2.0 (rev. = 8) and higher of the StrongARM
> - *              	SA-1100.]
> - */
> -
> -#define Ser2HSCR0	__REG(0x80040060)  /* Ser. port 2 HSSP Control Reg. 0 */
> -#define Ser2HSCR1	__REG(0x80040064)  /* Ser. port 2 HSSP Control Reg. 1 */
> -#define Ser2HSDR	__REG(0x8004006C)  /* Ser. port 2 HSSP Data Reg.      */
> -#define Ser2HSSR0	__REG(0x80040074)  /* Ser. port 2 HSSP Status Reg. 0  */
> -#define Ser2HSSR1	__REG(0x80040078)  /* Ser. port 2 HSSP Status Reg. 1  */
> -#define Ser2HSCR2	__REG(0x90060028)  /* Ser. port 2 HSSP Control Reg. 2 */
> -
> -#define HSCR0_ITR	0x00000001	/* IrDA Transmission Rate          */
> -#define HSCR0_UART	(HSCR0_ITR*0)	/*  UART mode (115.2 kb/s if IrDA) */
> -#define HSCR0_HSSP	(HSCR0_ITR*1)	/*  HSSP mode (4 Mb/s)             */
> -#define HSCR0_LBM	0x00000002	/* Look-Back Mode                  */
> -#define HSCR0_TUS	0x00000004	/* Transmit FIFO Under-run Select  */
> -#define HSCR0_EFrmURn	(HSCR0_TUS*0)	/*  End Frame on Under-Run         */
> -#define HSCR0_AbortURn	(HSCR0_TUS*1)	/*  Abort on Under-Run             */
> -#define HSCR0_TXE	0x00000008	/* Transmit Enable                 */
> -#define HSCR0_RXE	0x00000010	/* Receive Enable                  */
> -#define HSCR0_RIE	0x00000020	/* Receive FIFO 2/5-to-3/5-full or */
> -                	        	/* more Interrupt Enable           */
> -#define HSCR0_TIE	0x00000040	/* Transmit FIFO 1/2-full or less  */
> -                	        	/* Interrupt Enable                */
> -#define HSCR0_AME	0x00000080	/* Address Match Enable            */
> -
> -#define HSCR1_AMV	Fld (8, 0)	/* Address Match Value             */
> -
> -#define HSDR_DATA	Fld (8, 0)	/* receive/transmit DATA FIFOs     */
> -#if 0           	        	/* Hidden receive FIFO bits        */
> -#define HSDR_EOF	0x00000100	/*  receive End-Of-Frame (read)    */
> -#define HSDR_CRE	0x00000200	/*  receive CRC Error (read)       */
> -#define HSDR_ROR	0x00000400	/*  Receive FIFO Over-Run (read)   */
> -#endif /* 0 */
> -
> -#define HSSR0_EIF	0x00000001	/* Error In FIFO (read)            */
> -#define HSSR0_TUR	0x00000002	/* Transmit FIFO Under-Run         */
> -#define HSSR0_RAB	0x00000004	/* Receive ABort                   */
> -#define HSSR0_TFS	0x00000008	/* Transmit FIFO 1/2-full or less  */
> -                	        	/* Service request (read)          */
> -#define HSSR0_RFS	0x00000010	/* Receive FIFO 2/5-to-3/5-full or */
> -                	        	/* more Service request (read)     */
> -#define HSSR0_FRE	0x00000020	/* receive FRaming Error           */
> -
> -#define HSSR1_RSY	0x00000001	/* Receiver SYnchronized (read)    */
> -#define HSSR1_TBY	0x00000002	/* Transmitter BusY (read)         */
> -#define HSSR1_RNE	0x00000004	/* Receive FIFO Not Empty (read)   */
> -#define HSSR1_TNF	0x00000008	/* Transmit FIFO Not Full (read)   */
> -#define HSSR1_EOF	0x00000010	/* receive End-Of-Frame (read)     */
> -#define HSSR1_CRE	0x00000020	/* receive CRC Error (read)        */
> -#define HSSR1_ROR	0x00000040	/* Receive FIFO Over-Run (read)    */
> -
> -#define HSCR2_TXP	0x00040000	/* Transmit data Polarity (TXD_2)  */
> -#define HSCR2_TrDataL	(HSCR2_TXP*0)	/*  Transmit Data active Low       */
> -                	        	/*  (inverted)                     */
> -#define HSCR2_TrDataH	(HSCR2_TXP*1)	/*  Transmit Data active High      */
> -                	        	/*  (non-inverted)                 */
> -#define HSCR2_RXP	0x00080000	/* Receive data Polarity (RXD_2)   */
> -#define HSCR2_RcDataL	(HSCR2_RXP*0)	/*  Receive Data active Low        */
> -                	        	/*  (inverted)                     */
> -#define HSCR2_RcDataH	(HSCR2_RXP*1)	/*  Receive Data active High       */
> -                	        	/*  (non-inverted)                 */
> -
> -
> -/*
> - * Multi-media Communications Port (MCP) control registers
> - *
> - * Registers
> - *    Ser4MCCR0 	Serial port 4 Multi-media Communications Port (MCP)
> - *              	Control Register 0 (read/write).
> - *    Ser4MCDR0 	Serial port 4 Multi-media Communications Port (MCP)
> - *              	Data Register 0 (audio, read/write).
> - *    Ser4MCDR1 	Serial port 4 Multi-media Communications Port (MCP)
> - *              	Data Register 1 (telecom, read/write).
> - *    Ser4MCDR2 	Serial port 4 Multi-media Communications Port (MCP)
> - *              	Data Register 2 (CODEC registers, read/write).
> - *    Ser4MCSR  	Serial port 4 Multi-media Communications Port (MCP)
> - *              	Status Register (read/write).
> - *    Ser4MCCR1 	Serial port 4 Multi-media Communications Port (MCP)
> - *              	Control Register 1 (read/write).
> - *              	[The MCCR1 register is only implemented in
> - *              	versions 2.0 (rev. = 8) and higher of the StrongARM
> - *              	SA-1100.]
> - *
> - * Clocks
> - *    fmc, Tmc  	Frequency, period of the MCP communication (10 MHz,
> - *              	12 MHz, or GPIO [21]).
> - *    faud, Taud	Frequency, period of the audio sampling.
> - *    ftcm, Ttcm	Frequency, period of the telecom sampling.
> - */
> -
> -#define Ser4MCCR0	__REG(0x80060000)  /* Ser. port 4 MCP Control Reg. 0 */
> -#define Ser4MCDR0	__REG(0x80060008)  /* Ser. port 4 MCP Data Reg. 0 (audio) */
> -#define Ser4MCDR1	__REG(0x8006000C)  /* Ser. port 4 MCP Data Reg. 1 (telecom) */
> -#define Ser4MCDR2	__REG(0x80060010)  /* Ser. port 4 MCP Data Reg. 2 (CODEC reg.) */
> -#define Ser4MCSR	__REG(0x80060018)  /* Ser. port 4 MCP Status Reg. */
> -#define Ser4MCCR1	__REG(0x90060030)  /* Ser. port 4 MCP Control Reg. 1 */
> -
> -#define MCCR0_ASD	Fld (7, 0)	/* Audio Sampling rate Divisor/32  */
> -                	        	/* [6..127]                        */
> -                	        	/* faud = fmc/(32*ASD)             */
> -                	        	/* Taud = 32*ASD*Tmc               */
> -#define MCCR0_AudSmpDiv(Div)    	/*  Audio Sampling rate Divisor    */ \
> -                	        	/*  [192..4064]                    */ \
> -                	((Div)/32 << FShft (MCCR0_ASD))
> -                	        	/*  faud = fmc/(32*Floor (Div/32)) */
> -                	        	/*  Taud = 32*Floor (Div/32)*Tmc   */
> -#define MCCR0_CeilAudSmpDiv(Div)	/*  Ceil. of AudSmpDiv [192..4064] */ \
> -                	(((Div) + 31)/32 << FShft (MCCR0_ASD))
> -                	        	/*  faud = fmc/(32*Ceil (Div/32))  */
> -                	        	/*  Taud = 32*Ceil (Div/32)*Tmc    */
> -#define MCCR0_TSD	Fld (7, 8)	/* Telecom Sampling rate           */
> -                	        	/* Divisor/32 [16..127]            */
> -                	        	/* ftcm = fmc/(32*TSD)             */
> -                	        	/* Ttcm = 32*TSD*Tmc               */
> -#define MCCR0_TcmSmpDiv(Div)    	/*  Telecom Sampling rate Divisor  */ \
> -                	        	/*  [512..4064]                    */ \
> -                	((Div)/32 << FShft (MCCR0_TSD))
> -                	        	/*  ftcm = fmc/(32*Floor (Div/32)) */
> -                	        	/*  Ttcm = 32*Floor (Div/32)*Tmc   */
> -#define MCCR0_CeilTcmSmpDiv(Div)	/*  Ceil. of TcmSmpDiv [512..4064] */ \
> -                	(((Div) + 31)/32 << FShft (MCCR0_TSD))
> -                	        	/*  ftcm = fmc/(32*Ceil (Div/32))  */
> -                	        	/*  Ttcm = 32*Ceil (Div/32)*Tmc    */
> -#define MCCR0_MCE	0x00010000	/* MCP Enable                      */
> -#define MCCR0_ECS	0x00020000	/* External Clock Select           */
> -#define MCCR0_IntClk	(MCCR0_ECS*0)	/*  Internal Clock (10 or 12 MHz)  */
> -#define MCCR0_ExtClk	(MCCR0_ECS*1)	/*  External Clock (GPIO [21])     */
> -#define MCCR0_ADM	0x00040000	/* A/D (audio/telecom) data        */
> -                	        	/* sampling/storing Mode           */
> -#define MCCR0_VldBit	(MCCR0_ADM*0)	/*  Valid Bit storing mode         */
> -#define MCCR0_SmpCnt	(MCCR0_ADM*1)	/*  Sampling Counter storing mode  */
> -#define MCCR0_TTE	0x00080000	/* Telecom Transmit FIFO 1/2-full  */
> -                	        	/* or less interrupt Enable        */
> -#define MCCR0_TRE	0x00100000	/* Telecom Receive FIFO 1/2-full   */
> -                	        	/* or more interrupt Enable        */
> -#define MCCR0_ATE	0x00200000	/* Audio Transmit FIFO 1/2-full    */
> -                	        	/* or less interrupt Enable        */
> -#define MCCR0_ARE	0x00400000	/* Audio Receive FIFO 1/2-full or  */
> -                	        	/* more interrupt Enable           */
> -#define MCCR0_LBM	0x00800000	/* Look-Back Mode                  */
> -#define MCCR0_ECP	Fld (2, 24)	/* External Clock Prescaler - 1    */
> -#define MCCR0_ExtClkDiv(Div)    	/*  External Clock Divisor [1..4]  */ \
> -                	(((Div) - 1) << FShft (MCCR0_ECP))
> -
> -#define MCDR0_DATA	Fld (12, 4)	/* receive/transmit audio DATA     */
> -                	        	/* FIFOs                           */
> -
> -#define MCDR1_DATA	Fld (14, 2)	/* receive/transmit telecom DATA   */
> -                	        	/* FIFOs                           */
> -
> -                	        	/* receive/transmit CODEC reg.     */
> -                	        	/* FIFOs:                          */
> -#define MCDR2_DATA	Fld (16, 0)	/*  reg. DATA                      */
> -#define MCDR2_RW	0x00010000	/*  reg. Read/Write (transmit)     */
> -#define MCDR2_Rd	(MCDR2_RW*0)	/*   reg. Read                     */
> -#define MCDR2_Wr	(MCDR2_RW*1)	/*   reg. Write                    */
> -#define MCDR2_ADD	Fld (4, 17)	/*  reg. ADDress                   */
> -
> -#define MCSR_ATS	0x00000001	/* Audio Transmit FIFO 1/2-full    */
> -                	        	/* or less Service request (read)  */
> -#define MCSR_ARS	0x00000002	/* Audio Receive FIFO 1/2-full or  */
> -                	        	/* more Service request (read)     */
> -#define MCSR_TTS	0x00000004	/* Telecom Transmit FIFO 1/2-full  */
> -                	        	/* or less Service request (read)  */
> -#define MCSR_TRS	0x00000008	/* Telecom Receive FIFO 1/2-full   */
> -                	        	/* or more Service request (read)  */
> -#define MCSR_ATU	0x00000010	/* Audio Transmit FIFO Under-run   */
> -#define MCSR_ARO	0x00000020	/* Audio Receive FIFO Over-run     */
> -#define MCSR_TTU	0x00000040	/* Telecom Transmit FIFO Under-run */
> -#define MCSR_TRO	0x00000080	/* Telecom Receive FIFO Over-run   */
> -#define MCSR_ANF	0x00000100	/* Audio transmit FIFO Not Full    */
> -                	        	/* (read)                          */
> -#define MCSR_ANE	0x00000200	/* Audio receive FIFO Not Empty    */
> -                	        	/* (read)                          */
> -#define MCSR_TNF	0x00000400	/* Telecom transmit FIFO Not Full  */
> -                	        	/* (read)                          */
> -#define MCSR_TNE	0x00000800	/* Telecom receive FIFO Not Empty  */
> -                	        	/* (read)                          */
> -#define MCSR_CWC	0x00001000	/* CODEC register Write Completed  */
> -                	        	/* (read)                          */
> -#define MCSR_CRC	0x00002000	/* CODEC register Read Completed   */
> -                	        	/* (read)                          */
> -#define MCSR_ACE	0x00004000	/* Audio CODEC Enabled (read)      */
> -#define MCSR_TCE	0x00008000	/* Telecom CODEC Enabled (read)    */
> -
> -#define MCCR1_CFS	0x00100000	/* Clock Freq. Select              */
> -#define MCCR1_F12MHz	(MCCR1_CFS*0)	/*  Freq. (fmc) = ~ 12 MHz         */
> -                	        	/*  (11.981 MHz)                   */
> -#define MCCR1_F10MHz	(MCCR1_CFS*1)	/*  Freq. (fmc) = ~ 10 MHz         */
> -                	        	/*  (9.585 MHz)                    */
> -
> -
> -/*
> - * Synchronous Serial Port (SSP) control registers
> - *
> - * Registers
> - *    Ser4SSCR0 	Serial port 4 Synchronous Serial Port (SSP) Control
> - *              	Register 0 (read/write).
> - *    Ser4SSCR1 	Serial port 4 Synchronous Serial Port (SSP) Control
> - *              	Register 1 (read/write).
> - *              	[Bits SPO and SP are only implemented in versions 2.0
> - *              	(rev. = 8) and higher of the StrongARM SA-1100.]
> - *    Ser4SSDR  	Serial port 4 Synchronous Serial Port (SSP) Data
> - *              	Register (read/write).
> - *    Ser4SSSR  	Serial port 4 Synchronous Serial Port (SSP) Status
> - *              	Register (read/write).
> - *
> - * Clocks
> - *    fxtl, Txtl	Frequency, period of the system crystal (3.6864 MHz
> - *              	or 3.5795 MHz).
> - *    fss, Tss  	Frequency, period of the SSP communication.
> - */
> -
> -#define Ser4SSCR0	__REG(0x80070060)  /* Ser. port 4 SSP Control Reg. 0 */
> -#define Ser4SSCR1	__REG(0x80070064)  /* Ser. port 4 SSP Control Reg. 1 */
> -#define Ser4SSDR	__REG(0x8007006C)  /* Ser. port 4 SSP Data Reg. */
> -#define Ser4SSSR	__REG(0x80070074)  /* Ser. port 4 SSP Status Reg. */
> -
> -#define SSCR0_DSS	Fld (4, 0)	/* Data Size - 1 Select [3..15]    */
> -#define SSCR0_DataSize(Size)    	/*  Data Size Select [4..16]       */ \
> -                	(((Size) - 1) << FShft (SSCR0_DSS))
> -#define SSCR0_FRF	Fld (2, 4)	/* FRame Format                    */
> -#define SSCR0_Motorola	        	/*  Motorola Serial Peripheral     */ \
> -                	        	/*  Interface (SPI) format         */ \
> -                	(0 << FShft (SSCR0_FRF))
> -#define SSCR0_TI	        	/*  Texas Instruments Synchronous  */ \
> -                	        	/*  Serial format                  */ \
> -                	(1 << FShft (SSCR0_FRF))
> -#define SSCR0_National	        	/*  National Microwire format      */ \
> -                	(2 << FShft (SSCR0_FRF))
> -#define SSCR0_SSE	0x00000080	/* SSP Enable                      */
> -#define SSCR0_SCR	Fld (8, 8)	/* Serial Clock Rate divisor/2 - 1 */
> -                	        	/* fss = fxtl/(2*(SCR + 1))        */
> -                	        	/* Tss = 2*(SCR + 1)*Txtl          */
> -#define SSCR0_SerClkDiv(Div)    	/*  Serial Clock Divisor [2..512]  */ \
> -                	(((Div) - 2)/2 << FShft (SSCR0_SCR))
> -                	        	/*  fss = fxtl/(2*Floor (Div/2))   */
> -                	        	/*  Tss = 2*Floor (Div/2)*Txtl     */
> -#define SSCR0_CeilSerClkDiv(Div)	/*  Ceil. of SerClkDiv [2..512]    */ \
> -                	(((Div) - 1)/2 << FShft (SSCR0_SCR))
> -                	        	/*  fss = fxtl/(2*Ceil (Div/2))    */
> -                	        	/*  Tss = 2*Ceil (Div/2)*Txtl      */
> -
> -#define SSCR1_RIE	0x00000001	/* Receive FIFO 1/2-full or more   */
> -                	        	/* Interrupt Enable                */
> -#define SSCR1_TIE	0x00000002	/* Transmit FIFO 1/2-full or less  */
> -                	        	/* Interrupt Enable                */
> -#define SSCR1_LBM	0x00000004	/* Look-Back Mode                  */
> -#define SSCR1_SPO	0x00000008	/* Sample clock (SCLK) POlarity    */
> -#define SSCR1_SClkIactL	(SSCR1_SPO*0)	/*  Sample Clock Inactive Low      */
> -#define SSCR1_SClkIactH	(SSCR1_SPO*1)	/*  Sample Clock Inactive High     */
> -#define SSCR1_SP	0x00000010	/* Sample clock (SCLK) Phase       */
> -#define SSCR1_SClk1P	(SSCR1_SP*0)	/*  Sample Clock active 1 Period   */
> -                	        	/*  after frame (SFRM, 1st edge)   */
> -#define SSCR1_SClk1_2P	(SSCR1_SP*1)	/*  Sample Clock active 1/2 Period */
> -                	        	/*  after frame (SFRM, 1st edge)   */
> -#define SSCR1_ECS	0x00000020	/* External Clock Select           */
> -#define SSCR1_IntClk	(SSCR1_ECS*0)	/*  Internal Clock                 */
> -#define SSCR1_ExtClk	(SSCR1_ECS*1)	/*  External Clock (GPIO [19])     */
> -
> -#define SSDR_DATA	Fld (16, 0)	/* receive/transmit DATA FIFOs     */
> -
> -#define SSSR_TNF	0x00000002	/* Transmit FIFO Not Full (read)   */
> -#define SSSR_RNE	0x00000004	/* Receive FIFO Not Empty (read)   */
> -#define SSSR_BSY	0x00000008	/* SSP BuSY (read)                 */
> -#define SSSR_TFS	0x00000010	/* Transmit FIFO 1/2-full or less  */
> -                	        	/* Service request (read)          */
> -#define SSSR_RFS	0x00000020	/* Receive FIFO 1/2-full or more   */
> -                	        	/* Service request (read)          */
> -#define SSSR_ROR	0x00000040	/* Receive FIFO Over-Run           */
> -
> -
> -/*
> - * Operating System (OS) timer control registers
> - *
> - * Registers
> - *    OSMR0     	Operating System (OS) timer Match Register 0
> - *              	(read/write).
> - *    OSMR1     	Operating System (OS) timer Match Register 1
> - *              	(read/write).
> - *    OSMR2     	Operating System (OS) timer Match Register 2
> - *              	(read/write).
> - *    OSMR3     	Operating System (OS) timer Match Register 3
> - *              	(read/write).
> - *    OSCR      	Operating System (OS) timer Counter Register
> - *              	(read/write).
> - *    OSSR      	Operating System (OS) timer Status Register
> - *              	(read/write).
> - *    OWER      	Operating System (OS) timer Watch-dog Enable Register
> - *              	(read/write).
> - *    OIER      	Operating System (OS) timer Interrupt Enable Register
> - *              	(read/write).
> - */
> -
> -#define OSMR0  		io_p2v(0x90000000)  /* OS timer Match Reg. 0 */
> -#define OSMR1  		io_p2v(0x90000004)  /* OS timer Match Reg. 1 */
> -#define OSMR2  		io_p2v(0x90000008)  /* OS timer Match Reg. 2 */
> -#define OSMR3  		io_p2v(0x9000000c)  /* OS timer Match Reg. 3 */
> -#define OSCR   		io_p2v(0x90000010)  /* OS timer Counter Reg. */
> -#define OSSR   		io_p2v(0x90000014)  /* OS timer Status Reg. */
> -#define OWER   		io_p2v(0x90000018)  /* OS timer Watch-dog Enable Reg. */
> -#define OIER  	 	io_p2v(0x9000001C)  /* OS timer Interrupt Enable Reg. */
> -
> -#define OSSR_M(Nb)	        	/* Match detected [0..3]           */ \
> -                	(0x00000001 << (Nb))
> -#define OSSR_M0 	OSSR_M (0)	/* Match detected 0                */
> -#define OSSR_M1 	OSSR_M (1)	/* Match detected 1                */
> -#define OSSR_M2 	OSSR_M (2)	/* Match detected 2                */
> -#define OSSR_M3 	OSSR_M (3)	/* Match detected 3                */
> -
> -#define OWER_WME	0x00000001	/* Watch-dog Match Enable          */
> -                	        	/* (set only)                      */
> -
> -#define OIER_E(Nb)	        	/* match interrupt Enable [0..3]   */ \
> -                	(0x00000001 << (Nb))
> -#define OIER_E0 	OIER_E (0)	/* match interrupt Enable 0        */
> -#define OIER_E1 	OIER_E (1)	/* match interrupt Enable 1        */
> -#define OIER_E2 	OIER_E (2)	/* match interrupt Enable 2        */
> -#define OIER_E3 	OIER_E (3)	/* match interrupt Enable 3        */
> -
> -
> -/*
> - * Power Manager (PM) control registers
> - *
> - * Registers
> - *    PMCR      	Power Manager (PM) Control Register (read/write).
> - *    PSSR      	Power Manager (PM) Sleep Status Register (read/write).
> - *    PSPR      	Power Manager (PM) Scratch-Pad Register (read/write).
> - *    PWER      	Power Manager (PM) Wake-up Enable Register
> - *              	(read/write).
> - *    PCFR      	Power Manager (PM) general ConFiguration Register
> - *              	(read/write).
> - *    PPCR      	Power Manager (PM) Phase-Locked Loop (PLL)
> - *              	Configuration Register (read/write).
> - *    PGSR      	Power Manager (PM) General-Purpose Input/Output (GPIO)
> - *              	Sleep state Register (read/write, see GPIO pins).
> - *    POSR      	Power Manager (PM) Oscillator Status Register (read).
> - *
> - * Clocks
> - *    fxtl, Txtl	Frequency, period of the system crystal (3.6864 MHz
> - *              	or 3.5795 MHz).
> - *    fcpu, Tcpu	Frequency, period of the CPU core clock (CCLK).
> - */
> -
> -#define PMCR		__REG(0x90020000)  /* PM Control Reg. */
> -#define PSSR		__REG(0x90020004)  /* PM Sleep Status Reg. */
> -#define PSPR		__REG(0x90020008)  /* PM Scratch-Pad Reg. */
> -#define PWER		__REG(0x9002000C)  /* PM Wake-up Enable Reg. */
> -#define PCFR		__REG(0x90020010)  /* PM general ConFiguration Reg. */
> -#define PPCR		__REG(0x90020014)  /* PM PLL Configuration Reg. */
> -#define PGSR		__REG(0x90020018)  /* PM GPIO Sleep state Reg. */
> -#define POSR		__REG(0x9002001C)  /* PM Oscillator Status Reg. */
> -
> -#define PMCR_SF 	0x00000001	/* Sleep Force (set only)          */
> -
> -#define PSSR_SS 	0x00000001	/* Software Sleep                  */
> -#define PSSR_BFS	0x00000002	/* Battery Fault Status            */
> -                	        	/* (BATT_FAULT)                    */
> -#define PSSR_VFS	0x00000004	/* Vdd Fault Status (VDD_FAULT)    */
> -#define PSSR_DH 	0x00000008	/* DRAM control Hold               */
> -#define PSSR_PH 	0x00000010	/* Peripheral control Hold         */
> -
> -#define PWER_GPIO(Nb)	GPIO_GPIO (Nb)	/* GPIO [0..27] wake-up enable     */
> -#define PWER_GPIO0	PWER_GPIO (0)	/* GPIO  [0] wake-up enable        */
> -#define PWER_GPIO1	PWER_GPIO (1)	/* GPIO  [1] wake-up enable        */
> -#define PWER_GPIO2	PWER_GPIO (2)	/* GPIO  [2] wake-up enable        */
> -#define PWER_GPIO3	PWER_GPIO (3)	/* GPIO  [3] wake-up enable        */
> -#define PWER_GPIO4	PWER_GPIO (4)	/* GPIO  [4] wake-up enable        */
> -#define PWER_GPIO5	PWER_GPIO (5)	/* GPIO  [5] wake-up enable        */
> -#define PWER_GPIO6	PWER_GPIO (6)	/* GPIO  [6] wake-up enable        */
> -#define PWER_GPIO7	PWER_GPIO (7)	/* GPIO  [7] wake-up enable        */
> -#define PWER_GPIO8	PWER_GPIO (8)	/* GPIO  [8] wake-up enable        */
> -#define PWER_GPIO9	PWER_GPIO (9)	/* GPIO  [9] wake-up enable        */
> -#define PWER_GPIO10	PWER_GPIO (10)	/* GPIO [10] wake-up enable        */
> -#define PWER_GPIO11	PWER_GPIO (11)	/* GPIO [11] wake-up enable        */
> -#define PWER_GPIO12	PWER_GPIO (12)	/* GPIO [12] wake-up enable        */
> -#define PWER_GPIO13	PWER_GPIO (13)	/* GPIO [13] wake-up enable        */
> -#define PWER_GPIO14	PWER_GPIO (14)	/* GPIO [14] wake-up enable        */
> -#define PWER_GPIO15	PWER_GPIO (15)	/* GPIO [15] wake-up enable        */
> -#define PWER_GPIO16	PWER_GPIO (16)	/* GPIO [16] wake-up enable        */
> -#define PWER_GPIO17	PWER_GPIO (17)	/* GPIO [17] wake-up enable        */
> -#define PWER_GPIO18	PWER_GPIO (18)	/* GPIO [18] wake-up enable        */
> -#define PWER_GPIO19	PWER_GPIO (19)	/* GPIO [19] wake-up enable        */
> -#define PWER_GPIO20	PWER_GPIO (20)	/* GPIO [20] wake-up enable        */
> -#define PWER_GPIO21	PWER_GPIO (21)	/* GPIO [21] wake-up enable        */
> -#define PWER_GPIO22	PWER_GPIO (22)	/* GPIO [22] wake-up enable        */
> -#define PWER_GPIO23	PWER_GPIO (23)	/* GPIO [23] wake-up enable        */
> -#define PWER_GPIO24	PWER_GPIO (24)	/* GPIO [24] wake-up enable        */
> -#define PWER_GPIO25	PWER_GPIO (25)	/* GPIO [25] wake-up enable        */
> -#define PWER_GPIO26	PWER_GPIO (26)	/* GPIO [26] wake-up enable        */
> -#define PWER_GPIO27	PWER_GPIO (27)	/* GPIO [27] wake-up enable        */
> -#define PWER_RTC	0x80000000	/* RTC alarm wake-up enable        */
> -
> -#define PCFR_OPDE	0x00000001	/* Oscillator Power-Down Enable    */
> -#define PCFR_ClkRun	(PCFR_OPDE*0)	/*  Clock Running in sleep mode    */
> -#define PCFR_ClkStp	(PCFR_OPDE*1)	/*  Clock Stopped in sleep mode    */
> -#define PCFR_FP 	0x00000002	/* Float PCMCIA pins               */
> -#define PCFR_PCMCIANeg	(PCFR_FP*0)	/*  PCMCIA pins Negated (1)        */
> -#define PCFR_PCMCIAFlt	(PCFR_FP*1)	/*  PCMCIA pins Floating           */
> -#define PCFR_FS 	0x00000004	/* Float Static memory pins        */
> -#define PCFR_StMemNeg	(PCFR_FS*0)	/*  Static Memory pins Negated (1) */
> -#define PCFR_StMemFlt	(PCFR_FS*1)	/*  Static Memory pins Floating    */
> -#define PCFR_FO 	0x00000008	/* Force RTC oscillator            */
> -                	        	/* (32.768 kHz) enable On          */
> -
> -#define PPCR_CCF	Fld (5, 0)	/* CPU core Clock (CCLK) Freq.     */
> -#define PPCR_Fx16	        	/*  Freq. x 16 (fcpu = 16*fxtl)    */ \
> -                	(0x00 << FShft (PPCR_CCF))
> -#define PPCR_Fx20	        	/*  Freq. x 20 (fcpu = 20*fxtl)    */ \
> -                	(0x01 << FShft (PPCR_CCF))
> -#define PPCR_Fx24	        	/*  Freq. x 24 (fcpu = 24*fxtl)    */ \
> -                	(0x02 << FShft (PPCR_CCF))
> -#define PPCR_Fx28	        	/*  Freq. x 28 (fcpu = 28*fxtl)    */ \
> -                	(0x03 << FShft (PPCR_CCF))
> -#define PPCR_Fx32	        	/*  Freq. x 32 (fcpu = 32*fxtl)    */ \
> -                	(0x04 << FShft (PPCR_CCF))
> -#define PPCR_Fx36	        	/*  Freq. x 36 (fcpu = 36*fxtl)    */ \
> -                	(0x05 << FShft (PPCR_CCF))
> -#define PPCR_Fx40	        	/*  Freq. x 40 (fcpu = 40*fxtl)    */ \
> -                	(0x06 << FShft (PPCR_CCF))
> -#define PPCR_Fx44	        	/*  Freq. x 44 (fcpu = 44*fxtl)    */ \
> -                	(0x07 << FShft (PPCR_CCF))
> -#define PPCR_Fx48	        	/*  Freq. x 48 (fcpu = 48*fxtl)    */ \
> -                	(0x08 << FShft (PPCR_CCF))
> -#define PPCR_Fx52	        	/*  Freq. x 52 (fcpu = 52*fxtl)    */ \
> -                	(0x09 << FShft (PPCR_CCF))
> -#define PPCR_Fx56	        	/*  Freq. x 56 (fcpu = 56*fxtl)    */ \
> -                	(0x0A << FShft (PPCR_CCF))
> -#define PPCR_Fx60	        	/*  Freq. x 60 (fcpu = 60*fxtl)    */ \
> -                	(0x0B << FShft (PPCR_CCF))
> -#define PPCR_Fx64	        	/*  Freq. x 64 (fcpu = 64*fxtl)    */ \
> -                	(0x0C << FShft (PPCR_CCF))
> -#define PPCR_Fx68	        	/*  Freq. x 68 (fcpu = 68*fxtl)    */ \
> -                	(0x0D << FShft (PPCR_CCF))
> -#define PPCR_Fx72	        	/*  Freq. x 72 (fcpu = 72*fxtl)    */ \
> -                	(0x0E << FShft (PPCR_CCF))
> -#define PPCR_Fx76	        	/*  Freq. x 76 (fcpu = 76*fxtl)    */ \
> -                	(0x0F << FShft (PPCR_CCF))
> -                	        	/*  3.6864 MHz crystal (fxtl):     */
> -#define PPCR_F59_0MHz	PPCR_Fx16	/*   Freq. (fcpu) =  59.0 MHz      */
> -#define PPCR_F73_7MHz	PPCR_Fx20	/*   Freq. (fcpu) =  73.7 MHz      */
> -#define PPCR_F88_5MHz	PPCR_Fx24	/*   Freq. (fcpu) =  88.5 MHz      */
> -#define PPCR_F103_2MHz	PPCR_Fx28	/*   Freq. (fcpu) = 103.2 MHz      */
> -#define PPCR_F118_0MHz	PPCR_Fx32	/*   Freq. (fcpu) = 118.0 MHz      */
> -#define PPCR_F132_7MHz	PPCR_Fx36	/*   Freq. (fcpu) = 132.7 MHz      */
> -#define PPCR_F147_5MHz	PPCR_Fx40	/*   Freq. (fcpu) = 147.5 MHz      */
> -#define PPCR_F162_2MHz	PPCR_Fx44	/*   Freq. (fcpu) = 162.2 MHz      */
> -#define PPCR_F176_9MHz	PPCR_Fx48	/*   Freq. (fcpu) = 176.9 MHz      */
> -#define PPCR_F191_7MHz	PPCR_Fx52	/*   Freq. (fcpu) = 191.7 MHz      */
> -#define PPCR_F206_4MHz	PPCR_Fx56	/*   Freq. (fcpu) = 206.4 MHz      */
> -#define PPCR_F221_2MHz	PPCR_Fx60	/*   Freq. (fcpu) = 221.2 MHz      */
> -#define PPCR_F239_6MHz	PPCR_Fx64	/*   Freq. (fcpu) = 239.6 MHz      */
> -#define PPCR_F250_7MHz	PPCR_Fx68	/*   Freq. (fcpu) = 250.7 MHz      */
> -#define PPCR_F265_4MHz	PPCR_Fx72	/*   Freq. (fcpu) = 265.4 MHz      */
> -#define PPCR_F280_2MHz	PPCR_Fx76	/*   Freq. (fcpu) = 280.2 MHz      */
> -                	        	/*  3.5795 MHz crystal (fxtl):     */
> -#define PPCR_F57_3MHz	PPCR_Fx16	/*   Freq. (fcpu) =  57.3 MHz      */
> -#define PPCR_F71_6MHz	PPCR_Fx20	/*   Freq. (fcpu) =  71.6 MHz      */
> -#define PPCR_F85_9MHz	PPCR_Fx24	/*   Freq. (fcpu) =  85.9 MHz      */
> -#define PPCR_F100_2MHz	PPCR_Fx28	/*   Freq. (fcpu) = 100.2 MHz      */
> -#define PPCR_F114_5MHz	PPCR_Fx32	/*   Freq. (fcpu) = 114.5 MHz      */
> -#define PPCR_F128_9MHz	PPCR_Fx36	/*   Freq. (fcpu) = 128.9 MHz      */
> -#define PPCR_F143_2MHz	PPCR_Fx40	/*   Freq. (fcpu) = 143.2 MHz      */
> -#define PPCR_F157_5MHz	PPCR_Fx44	/*   Freq. (fcpu) = 157.5 MHz      */
> -#define PPCR_F171_8MHz	PPCR_Fx48	/*   Freq. (fcpu) = 171.8 MHz      */
> -#define PPCR_F186_1MHz	PPCR_Fx52	/*   Freq. (fcpu) = 186.1 MHz      */
> -#define PPCR_F200_5MHz	PPCR_Fx56	/*   Freq. (fcpu) = 200.5 MHz      */
> -#define PPCR_F214_8MHz	PPCR_Fx60	/*   Freq. (fcpu) = 214.8 MHz      */
> -#define PPCR_F229_1MHz	PPCR_Fx64	/*   Freq. (fcpu) = 229.1 MHz      */
> -#define PPCR_F243_4MHz	PPCR_Fx68	/*   Freq. (fcpu) = 243.4 MHz      */
> -#define PPCR_F257_7MHz	PPCR_Fx72	/*   Freq. (fcpu) = 257.7 MHz      */
> -#define PPCR_F272_0MHz	PPCR_Fx76	/*   Freq. (fcpu) = 272.0 MHz      */
> -
> -#define POSR_OOK	0x00000001	/* RTC Oscillator (32.768 kHz) OK  */
> -
> -
> -/*
> - * Reset Controller (RC) control registers
> - *
> - * Registers
> - *    RSRR      	Reset Controller (RC) Software Reset Register
> - *              	(read/write).
> - *    RCSR      	Reset Controller (RC) Status Register (read/write).
> - */
> -
> -#define RSRR		__REG(0x90030000)  /* RC Software Reset Reg. */
> -#define RCSR		__REG(0x90030004)  /* RC Status Reg. */
> -
> -#define RSRR_SWR	0x00000001	/* SoftWare Reset (set only)       */
> -
> -#define RCSR_HWR	0x00000001	/* HardWare Reset                  */
> -#define RCSR_SWR	0x00000002	/* SoftWare Reset                  */
> -#define RCSR_WDR	0x00000004	/* Watch-Dog Reset                 */
> -#define RCSR_SMR	0x00000008	/* Sleep-Mode Reset                */
> -
> -
> -/*
> - * Test unit control registers
> - *
> - * Registers
> - *    TUCR      	Test Unit Control Register (read/write).
> - */
> -
> -#define TUCR		__REG(0x90030008)  /* Test Unit Control Reg. */
> -
> -#define TUCR_TIC	0x00000040	/* TIC mode                        */
> -#define TUCR_TTST	0x00000080	/* Trim TeST mode                  */
> -#define TUCR_RCRC	0x00000100	/* Richard's Cyclic Redundancy     */
> -                	        	/* Check                           */
> -#define TUCR_PMD	0x00000200	/* Power Management Disable        */
> -#define TUCR_MR 	0x00000400	/* Memory Request mode             */
> -#define TUCR_NoMB	(TUCR_MR*0)	/*  No Memory Bus request & grant  */
> -#define TUCR_MBGPIO	(TUCR_MR*1)	/*  Memory Bus request (MBREQ) &   */
> -                	        	/*  grant (MBGNT) on GPIO [22:21]  */
> -#define TUCR_CTB	Fld (3, 20)	/* Clock Test Bits                 */
> -#define TUCR_FDC	0x00800000	/* RTC Force Delete Count          */
> -#define TUCR_FMC	0x01000000	/* Force Michelle's Control mode   */
> -#define TUCR_TMC	0x02000000	/* RTC Trimmer Multiplexer Control */
> -#define TUCR_DPS	0x04000000	/* Disallow Pad Sleep              */
> -#define TUCR_TSEL	Fld (3, 29)	/* clock Test SELect on GPIO [27]  */
> -#define TUCR_32_768kHz	        	/*  32.768 kHz osc. on GPIO [27]   */ \
> -                	(0 << FShft (TUCR_TSEL))
> -#define TUCR_3_6864MHz	        	/*  3.6864 MHz osc. on GPIO [27]   */ \
> -                	(1 << FShft (TUCR_TSEL))
> -#define TUCR_VDD	        	/*  VDD ring osc./16 on GPIO [27]  */ \
> -                	(2 << FShft (TUCR_TSEL))
> -#define TUCR_96MHzPLL	        	/*  96 MHz PLL/4 on GPIO [27]      */ \
> -                	(3 << FShft (TUCR_TSEL))
> -#define TUCR_Clock	        	/*  internal (fcpu/2) & 32.768 kHz */ \
> -                	        	/*  Clocks on GPIO [26:27]         */ \
> -                	(4 << FShft (TUCR_TSEL))
> -#define TUCR_3_6864MHzA	        	/*  3.6864 MHz osc. on GPIO [27]   */ \
> -                	        	/*  (Alternative)                  */ \
> -                	(5 << FShft (TUCR_TSEL))
> -#define TUCR_MainPLL	        	/*  Main PLL/16 on GPIO [27]       */ \
> -                	(6 << FShft (TUCR_TSEL))
> -#define TUCR_VDDL	        	/*  VDDL ring osc./4 on GPIO [27]  */ \
> -                	(7 << FShft (TUCR_TSEL))
> -
> -
> -/*
> - * General-Purpose Input/Output (GPIO) control registers
> - *
> - * Registers
> - *    GPLR      	General-Purpose Input/Output (GPIO) Pin Level
> - *              	Register (read).
> - *    GPDR      	General-Purpose Input/Output (GPIO) Pin Direction
> - *              	Register (read/write).
> - *    GPSR      	General-Purpose Input/Output (GPIO) Pin output Set
> - *              	Register (write).
> - *    GPCR      	General-Purpose Input/Output (GPIO) Pin output Clear
> - *              	Register (write).
> - *    GRER      	General-Purpose Input/Output (GPIO) Rising-Edge
> - *              	detect Register (read/write).
> - *    GFER      	General-Purpose Input/Output (GPIO) Falling-Edge
> - *              	detect Register (read/write).
> - *    GEDR      	General-Purpose Input/Output (GPIO) Edge Detect
> - *              	status Register (read/write).
> - *    GAFR      	General-Purpose Input/Output (GPIO) Alternate
> - *              	Function Register (read/write).
> - *
> - * Clock
> - *    fcpu, Tcpu	Frequency, period of the CPU core clock (CCLK).
> - */
> -
> -#define GPLR		__REG(0x90040000)  /* GPIO Pin Level Reg.             */
> -#define GPDR		__REG(0x90040004)  /* GPIO Pin Direction Reg.         */
> -#define GPSR		__REG(0x90040008)  /* GPIO Pin output Set Reg.        */
> -#define GPCR		__REG(0x9004000C)  /* GPIO Pin output Clear Reg.      */
> -#define GRER		__REG(0x90040010)  /* GPIO Rising-Edge detect Reg.    */
> -#define GFER		__REG(0x90040014)  /* GPIO Falling-Edge detect Reg.   */
> -#define GEDR		__REG(0x90040018)  /* GPIO Edge Detect status Reg.    */
> -#define GAFR		__REG(0x9004001C)  /* GPIO Alternate Function Reg.    */
> -
> -#define GPIO_MIN	(0)
> -#define GPIO_MAX	(27)
> -
> -#define GPIO_GPIO(Nb)	        	/* GPIO [0..27]                    */ \
> -                	(0x00000001 << (Nb))
> -#define GPIO_GPIO0	GPIO_GPIO (0)	/* GPIO  [0]                       */
> -#define GPIO_GPIO1	GPIO_GPIO (1)	/* GPIO  [1]                       */
> -#define GPIO_GPIO2	GPIO_GPIO (2)	/* GPIO  [2]                       */
> -#define GPIO_GPIO3	GPIO_GPIO (3)	/* GPIO  [3]                       */
> -#define GPIO_GPIO4	GPIO_GPIO (4)	/* GPIO  [4]                       */
> -#define GPIO_GPIO5	GPIO_GPIO (5)	/* GPIO  [5]                       */
> -#define GPIO_GPIO6	GPIO_GPIO (6)	/* GPIO  [6]                       */
> -#define GPIO_GPIO7	GPIO_GPIO (7)	/* GPIO  [7]                       */
> -#define GPIO_GPIO8	GPIO_GPIO (8)	/* GPIO  [8]                       */
> -#define GPIO_GPIO9	GPIO_GPIO (9)	/* GPIO  [9]                       */
> -#define GPIO_GPIO10	GPIO_GPIO (10)	/* GPIO [10]                       */
> -#define GPIO_GPIO11	GPIO_GPIO (11)	/* GPIO [11]                       */
> -#define GPIO_GPIO12	GPIO_GPIO (12)	/* GPIO [12]                       */
> -#define GPIO_GPIO13	GPIO_GPIO (13)	/* GPIO [13]                       */
> -#define GPIO_GPIO14	GPIO_GPIO (14)	/* GPIO [14]                       */
> -#define GPIO_GPIO15	GPIO_GPIO (15)	/* GPIO [15]                       */
> -#define GPIO_GPIO16	GPIO_GPIO (16)	/* GPIO [16]                       */
> -#define GPIO_GPIO17	GPIO_GPIO (17)	/* GPIO [17]                       */
> -#define GPIO_GPIO18	GPIO_GPIO (18)	/* GPIO [18]                       */
> -#define GPIO_GPIO19	GPIO_GPIO (19)	/* GPIO [19]                       */
> -#define GPIO_GPIO20	GPIO_GPIO (20)	/* GPIO [20]                       */
> -#define GPIO_GPIO21	GPIO_GPIO (21)	/* GPIO [21]                       */
> -#define GPIO_GPIO22	GPIO_GPIO (22)	/* GPIO [22]                       */
> -#define GPIO_GPIO23	GPIO_GPIO (23)	/* GPIO [23]                       */
> -#define GPIO_GPIO24	GPIO_GPIO (24)	/* GPIO [24]                       */
> -#define GPIO_GPIO25	GPIO_GPIO (25)	/* GPIO [25]                       */
> -#define GPIO_GPIO26	GPIO_GPIO (26)	/* GPIO [26]                       */
> -#define GPIO_GPIO27	GPIO_GPIO (27)	/* GPIO [27]                       */
> -
> -#define GPIO_LDD(Nb)	        	/* LCD Data [8..15] (O)            */ \
> -                	GPIO_GPIO ((Nb) - 6)
> -#define GPIO_LDD8	GPIO_LDD (8)	/* LCD Data  [8] (O)               */
> -#define GPIO_LDD9	GPIO_LDD (9)	/* LCD Data  [9] (O)               */
> -#define GPIO_LDD10	GPIO_LDD (10)	/* LCD Data [10] (O)               */
> -#define GPIO_LDD11	GPIO_LDD (11)	/* LCD Data [11] (O)               */
> -#define GPIO_LDD12	GPIO_LDD (12)	/* LCD Data [12] (O)               */
> -#define GPIO_LDD13	GPIO_LDD (13)	/* LCD Data [13] (O)               */
> -#define GPIO_LDD14	GPIO_LDD (14)	/* LCD Data [14] (O)               */
> -#define GPIO_LDD15	GPIO_LDD (15)	/* LCD Data [15] (O)               */
> -                	        	/* ser. port 4:                    */
> -#define GPIO_SSP_TXD	GPIO_GPIO (10)	/*  SSP Transmit Data (O)          */
> -#define GPIO_SSP_RXD	GPIO_GPIO (11)	/*  SSP Receive Data (I)           */
> -#define GPIO_SSP_SCLK	GPIO_GPIO (12)	/*  SSP Sample CLocK (O)           */
> -#define GPIO_SSP_SFRM	GPIO_GPIO (13)	/*  SSP Sample FRaMe (O)           */
> -                	        	/* ser. port 1:                    */
> -#define GPIO_UART_TXD	GPIO_GPIO (14)	/*  UART Transmit Data (O)         */
> -#define GPIO_UART_RXD	GPIO_GPIO (15)	/*  UART Receive Data (I)          */
> -#define GPIO_SDLC_SCLK	GPIO_GPIO (16)	/*  SDLC Sample CLocK (I/O)        */
> -#define GPIO_SDLC_AAF	GPIO_GPIO (17)	/*  SDLC Abort After Frame (O)     */
> -#define GPIO_UART_SCLK1	GPIO_GPIO (18)	/*  UART Sample CLocK 1 (I)        */
> -                	        	/* ser. port 4:                    */
> -#define GPIO_SSP_CLK	GPIO_GPIO (19)	/*  SSP external CLocK (I)         */
> -                	        	/* ser. port 3:                    */
> -#define GPIO_UART_SCLK3	GPIO_GPIO (20)	/*  UART Sample CLocK 3 (I)        */
> -                	        	/* ser. port 4:                    */
> -#define GPIO_MCP_CLK	GPIO_GPIO (21)	/*  MCP CLocK (I)                  */
> -                	        	/* test controller:                */
> -#define GPIO_TIC_ACK	GPIO_GPIO (21)	/*  TIC ACKnowledge (O)            */
> -#define GPIO_MBGNT	GPIO_GPIO (21)	/*  Memory Bus GraNT (O)           */
> -#define GPIO_TREQA	GPIO_GPIO (22)	/*  TIC REQuest A (I)              */
> -#define GPIO_MBREQ	GPIO_GPIO (22)	/*  Memory Bus REQuest (I)         */
> -#define GPIO_TREQB	GPIO_GPIO (23)	/*  TIC REQuest B (I)              */
> -#define GPIO_1Hz	GPIO_GPIO (25)	/* 1 Hz clock (O)                  */
> -#define GPIO_RCLK	GPIO_GPIO (26)	/* internal (R) CLocK (O, fcpu/2)  */
> -#define GPIO_32_768kHz	GPIO_GPIO (27)	/* 32.768 kHz clock (O, RTC)       */
> -
> -#define GPDR_In 	0       	/* Input                           */
> -#define GPDR_Out	1       	/* Output                          */
> -
> -
> -/*
> - * Interrupt Controller (IC) control registers
> - *
> - * Registers
> - *    ICIP      	Interrupt Controller (IC) Interrupt ReQuest (IRQ)
> - *              	Pending register (read).
> - *    ICMR      	Interrupt Controller (IC) Mask Register (read/write).
> - *    ICLR      	Interrupt Controller (IC) Level Register (read/write).
> - *    ICCR      	Interrupt Controller (IC) Control Register
> - *              	(read/write).
> - *              	[The ICCR register is only implemented in versions 2.0
> - *              	(rev. = 8) and higher of the StrongARM SA-1100.]
> - *    ICFP      	Interrupt Controller (IC) Fast Interrupt reQuest
> - *              	(FIQ) Pending register (read).
> - *    ICPR      	Interrupt Controller (IC) Pending Register (read).
> - *              	[The ICPR register is active low (inverted) in
> - *              	versions 1.0 (rev. = 1) and 1.1 (rev. = 2) of the
> - *              	StrongARM SA-1100, it is active high (non-inverted) in
> - *              	versions 2.0 (rev. = 8) and higher.]
> - */
> -
> -#define ICIP		__REG(0x90050000)  /* IC IRQ Pending reg.             */
> -#define ICMR		__REG(0x90050004)  /* IC Mask Reg.                    */
> -#define ICLR		__REG(0x90050008)  /* IC Level Reg.                   */
> -#define ICCR		__REG(0x9005000C)  /* IC Control Reg.                 */
> -#define ICFP		__REG(0x90050010)  /* IC FIQ Pending reg.             */
> -#define ICPR		__REG(0x90050020)  /* IC Pending Reg.                 */
> -
> -#define IC_GPIO(Nb)	        	/* GPIO [0..10]                    */ \
> -                	(0x00000001 << (Nb))
> -#define IC_GPIO0	IC_GPIO (0)	/* GPIO  [0]                       */
> -#define IC_GPIO1	IC_GPIO (1)	/* GPIO  [1]                       */
> -#define IC_GPIO2	IC_GPIO (2)	/* GPIO  [2]                       */
> -#define IC_GPIO3	IC_GPIO (3)	/* GPIO  [3]                       */
> -#define IC_GPIO4	IC_GPIO (4)	/* GPIO  [4]                       */
> -#define IC_GPIO5	IC_GPIO (5)	/* GPIO  [5]                       */
> -#define IC_GPIO6	IC_GPIO (6)	/* GPIO  [6]                       */
> -#define IC_GPIO7	IC_GPIO (7)	/* GPIO  [7]                       */
> -#define IC_GPIO8	IC_GPIO (8)	/* GPIO  [8]                       */
> -#define IC_GPIO9	IC_GPIO (9)	/* GPIO  [9]                       */
> -#define IC_GPIO10	IC_GPIO (10)	/* GPIO [10]                       */
> -#define IC_GPIO11_27	0x00000800	/* GPIO [11:27] (ORed)             */
> -#define IC_LCD  	0x00001000	/* LCD controller                  */
> -#define IC_Ser0UDC	0x00002000	/* Ser. port 0 UDC                 */
> -#define IC_Ser1SDLC	0x00004000	/* Ser. port 1 SDLC                */
> -#define IC_Ser1UART	0x00008000	/* Ser. port 1 UART                */
> -#define IC_Ser2ICP	0x00010000	/* Ser. port 2 ICP                 */
> -#define IC_Ser3UART	0x00020000	/* Ser. port 3 UART                */
> -#define IC_Ser4MCP	0x00040000	/* Ser. port 4 MCP                 */
> -#define IC_Ser4SSP	0x00080000	/* Ser. port 4 SSP                 */
> -#define IC_DMA(Nb)	        	/* DMA controller channel [0..5]   */ \
> -                	(0x00100000 << (Nb))
> -#define IC_DMA0 	IC_DMA (0)	/* DMA controller channel 0        */
> -#define IC_DMA1 	IC_DMA (1)	/* DMA controller channel 1        */
> -#define IC_DMA2 	IC_DMA (2)	/* DMA controller channel 2        */
> -#define IC_DMA3 	IC_DMA (3)	/* DMA controller channel 3        */
> -#define IC_DMA4 	IC_DMA (4)	/* DMA controller channel 4        */
> -#define IC_DMA5 	IC_DMA (5)	/* DMA controller channel 5        */
> -#define IC_OST(Nb)	        	/* OS Timer match [0..3]           */ \
> -                	(0x04000000 << (Nb))
> -#define IC_OST0 	IC_OST (0)	/* OS Timer match 0                */
> -#define IC_OST1 	IC_OST (1)	/* OS Timer match 1                */
> -#define IC_OST2 	IC_OST (2)	/* OS Timer match 2                */
> -#define IC_OST3 	IC_OST (3)	/* OS Timer match 3                */
> -#define IC_RTC1Hz	0x40000000	/* RTC 1 Hz clock                  */
> -#define IC_RTCAlrm	0x80000000	/* RTC Alarm                       */
> -
> -#define ICLR_IRQ	0       	/* Interrupt ReQuest               */
> -#define ICLR_FIQ	1       	/* Fast Interrupt reQuest          */
> -
> -#define ICCR_DIM	0x00000001	/* Disable Idle-mode interrupt     */
> -                	        	/* Mask                            */
> -#define ICCR_IdleAllInt	(ICCR_DIM*0)	/*  Idle-mode All Interrupt enable */
> -                	        	/*  (ICMR ignored)                 */
> -#define ICCR_IdleMskInt	(ICCR_DIM*1)	/*  Idle-mode non-Masked Interrupt */
> -                	        	/*  enable (ICMR used)             */
> -
> -
> -/*
> - * Peripheral Pin Controller (PPC) control registers
> - *
> - * Registers
> - *    PPDR      	Peripheral Pin Controller (PPC) Pin Direction
> - *              	Register (read/write).
> - *    PPSR      	Peripheral Pin Controller (PPC) Pin State Register
> - *              	(read/write).
> - *    PPAR      	Peripheral Pin Controller (PPC) Pin Assignment
> - *              	Register (read/write).
> - *    PSDR      	Peripheral Pin Controller (PPC) Sleep-mode pin
> - *              	Direction Register (read/write).
> - *    PPFR      	Peripheral Pin Controller (PPC) Pin Flag Register
> - *              	(read).
> - */
> -
> -#define PPDR		__REG(0x90060000)  /* PPC Pin Direction Reg.          */
> -#define PPSR		__REG(0x90060004)  /* PPC Pin State Reg.              */
> -#define PPAR		__REG(0x90060008)  /* PPC Pin Assignment Reg.         */
> -#define PSDR		__REG(0x9006000C)  /* PPC Sleep-mode pin Direction Reg. */
> -#define PPFR		__REG(0x90060010)  /* PPC Pin Flag Reg.               */
> -
> -#define PPC_LDD(Nb)	        	/* LCD Data [0..7]                 */ \
> -                	(0x00000001 << (Nb))
> -#define PPC_LDD0	PPC_LDD (0)	/* LCD Data [0]                    */
> -#define PPC_LDD1	PPC_LDD (1)	/* LCD Data [1]                    */
> -#define PPC_LDD2	PPC_LDD (2)	/* LCD Data [2]                    */
> -#define PPC_LDD3	PPC_LDD (3)	/* LCD Data [3]                    */
> -#define PPC_LDD4	PPC_LDD (4)	/* LCD Data [4]                    */
> -#define PPC_LDD5	PPC_LDD (5)	/* LCD Data [5]                    */
> -#define PPC_LDD6	PPC_LDD (6)	/* LCD Data [6]                    */
> -#define PPC_LDD7	PPC_LDD (7)	/* LCD Data [7]                    */
> -#define PPC_L_PCLK	0x00000100	/* LCD Pixel CLocK                 */
> -#define PPC_L_LCLK	0x00000200	/* LCD Line CLocK                  */
> -#define PPC_L_FCLK	0x00000400	/* LCD Frame CLocK                 */
> -#define PPC_L_BIAS	0x00000800	/* LCD AC BIAS                     */
> -                	        	/* ser. port 1:                    */
> -#define PPC_TXD1	0x00001000	/*  SDLC/UART Transmit Data 1      */
> -#define PPC_RXD1	0x00002000	/*  SDLC/UART Receive Data 1       */
> -                	        	/* ser. port 2:                    */
> -#define PPC_TXD2	0x00004000	/*  IPC Transmit Data 2            */
> -#define PPC_RXD2	0x00008000	/*  IPC Receive Data 2             */
> -                	        	/* ser. port 3:                    */
> -#define PPC_TXD3	0x00010000	/*  UART Transmit Data 3           */
> -#define PPC_RXD3	0x00020000	/*  UART Receive Data 3            */
> -                	        	/* ser. port 4:                    */
> -#define PPC_TXD4	0x00040000	/*  MCP/SSP Transmit Data 4        */
> -#define PPC_RXD4	0x00080000	/*  MCP/SSP Receive Data 4         */
> -#define PPC_SCLK	0x00100000	/*  MCP/SSP Sample CLocK           */
> -#define PPC_SFRM	0x00200000	/*  MCP/SSP Sample FRaMe           */
> -
> -#define PPDR_In 	0       	/* Input                           */
> -#define PPDR_Out	1       	/* Output                          */
> -
> -                	        	/* ser. port 1:                    */
> -#define PPAR_UPR	0x00001000	/*  UART Pin Reassignment          */
> -#define PPAR_UARTTR	(PPAR_UPR*0)	/*   UART on TXD_1 & RXD_1         */
> -#define PPAR_UARTGPIO	(PPAR_UPR*1)	/*   UART on GPIO [14:15]          */
> -                	        	/* ser. port 4:                    */
> -#define PPAR_SPR	0x00040000	/*  SSP Pin Reassignment           */
> -#define PPAR_SSPTRSS	(PPAR_SPR*0)	/*   SSP on TXD_C, RXD_C, SCLK_C,  */
> -                	        	/*   & SFRM_C                      */
> -#define PPAR_SSPGPIO	(PPAR_SPR*1)	/*   SSP on GPIO [10:13]           */
> -
> -#define PSDR_OutL	0       	/* Output Low in sleep mode        */
> -#define PSDR_Flt	1       	/* Floating (input) in sleep mode  */
> -
> -#define PPFR_LCD	0x00000001	/* LCD controller                  */
> -#define PPFR_SP1TX	0x00001000	/* Ser. Port 1 SDLC/UART Transmit  */
> -#define PPFR_SP1RX	0x00002000	/* Ser. Port 1 SDLC/UART Receive   */
> -#define PPFR_SP2TX	0x00004000	/* Ser. Port 2 ICP Transmit        */
> -#define PPFR_SP2RX	0x00008000	/* Ser. Port 2 ICP Receive         */
> -#define PPFR_SP3TX	0x00010000	/* Ser. Port 3 UART Transmit       */
> -#define PPFR_SP3RX	0x00020000	/* Ser. Port 3 UART Receive        */
> -#define PPFR_SP4	0x00040000	/* Ser. Port 4 MCP/SSP             */
> -#define PPFR_PerEn	0       	/* Peripheral Enabled              */
> -#define PPFR_PPCEn	1       	/* PPC Enabled                     */
> -
> -
> -/*
> - * Dynamic Random-Access Memory (DRAM) control registers
> - *
> - * Registers
> - *    MDCNFG    	Memory system: Dynamic Random-Access Memory (DRAM)
> - *              	CoNFiGuration register (read/write).
> - *    MDCAS0    	Memory system: Dynamic Random-Access Memory (DRAM)
> - *              	Column Address Strobe (CAS) shift register 0
> - *              	(read/write).
> - *    MDCAS1    	Memory system: Dynamic Random-Access Memory (DRAM)
> - *              	Column Address Strobe (CAS) shift register 1
> - *              	(read/write).
> - *    MDCAS2    	Memory system: Dynamic Random-Access Memory (DRAM)
> - *              	Column Address Strobe (CAS) shift register 2
> - *              	(read/write).
> - *
> - * Clocks
> - *    fcpu, Tcpu	Frequency, period of the CPU core clock (CCLK).
> - *    fmem, Tmem	Frequency, period of the memory clock (fmem = fcpu/2).
> - *    fcas, Tcas	Frequency, period of the DRAM CAS shift registers.
> - */
> -
> -#define MDCNFG		__REG(0xA0000000)  /*  DRAM CoNFiGuration reg. */
> -#define MDCAS0		__REG(0xA0000004)  /* DRAM CAS shift reg. 0 */
> -#define MDCAS1		__REG(0xA0000008)  /* DRAM CAS shift reg. 1 */
> -#define MDCAS2		__REG(0xA000000c)  /* DRAM CAS shift reg. 2 */
> -
> -/* SA1100 MDCNFG values */
> -#define MDCNFG_DE(Nb)	        	/* DRAM Enable bank [0..3]         */ \
> -                	(0x00000001 << (Nb))
> -#define MDCNFG_DE0	MDCNFG_DE (0)	/* DRAM Enable bank 0              */
> -#define MDCNFG_DE1	MDCNFG_DE (1)	/* DRAM Enable bank 1              */
> -#define MDCNFG_DE2	MDCNFG_DE (2)	/* DRAM Enable bank 2              */
> -#define MDCNFG_DE3	MDCNFG_DE (3)	/* DRAM Enable bank 3              */
> -#define MDCNFG_DRAC	Fld (2, 4)	/* DRAM Row Address Count - 9      */
> -#define MDCNFG_RowAdd(Add)      	/*  Row Address count [9..12]      */ \
> -                	(((Add) - 9) << FShft (MDCNFG_DRAC))
> -#define MDCNFG_CDB2	0x00000040	/* shift reg. Clock Divide By 2    */
> -                	        	/* (fcas = fcpu/2)                 */
> -#define MDCNFG_TRP	Fld (4, 7)	/* Time RAS Pre-charge - 1 [Tmem]  */
> -#define MDCNFG_PrChrg(Tcpu)     	/*  Pre-Charge time [2..32 Tcpu]   */ \
> -                	(((Tcpu) - 2)/2 << FShft (MDCNFG_TRP))
> -#define MDCNFG_CeilPrChrg(Tcpu) 	/*  Ceil. of PrChrg [2..32 Tcpu]   */ \
> -                	(((Tcpu) - 1)/2 << FShft (MDCNFG_TRP))
> -#define MDCNFG_TRASR	Fld (4, 11)	/* Time RAS Refresh - 1 [Tmem]     */
> -#define MDCNFG_Ref(Tcpu)        	/*  Refresh time [2..32 Tcpu]      */ \
> -                	(((Tcpu) - 2)/2 << FShft (MDCNFG_TRASR))
> -#define MDCNFG_CeilRef(Tcpu)    	/*  Ceil. of Ref [2..32 Tcpu]      */ \
> -                	(((Tcpu) - 1)/2 << FShft (MDCNFG_TRASR))
> -#define MDCNFG_TDL	Fld (2, 15)	/* Time Data Latch [Tcpu]          */
> -#define MDCNFG_DataLtch(Tcpu)   	/*  Data Latch delay [0..3 Tcpu]   */ \
> -                	((Tcpu) << FShft (MDCNFG_TDL))
> -#define MDCNFG_DRI	Fld (15, 17)	/* min. DRAM Refresh Interval/4    */
> -                	        	/* [Tmem]                          */
> -#define MDCNFG_RefInt(Tcpu)     	/*  min. Refresh Interval          */ \
> -                	        	/*  [0..262136 Tcpu]               */ \
> -                	((Tcpu)/8 << FShft (MDCNFG_DRI))
> -
> -/* SA1110 MDCNFG values */
> -#define MDCNFG_SA1110_DE0	0x00000001	/* DRAM Enable bank 0        */
> -#define MDCNFG_SA1110_DE1	0x00000002 	/* DRAM Enable bank 1        */
> -#define MDCNFG_SA1110_DTIM0	0x00000004	/* DRAM timing type 0/1      */
> -#define MDCNFG_SA1110_DWID0	0x00000008	/* DRAM bus width 0/1        */
> -#define MDCNFG_SA1110_DRAC0	Fld(3, 4)	/* DRAM row addr bit count   */
> -                	        		/* bank 0/1                  */
> -#define MDCNFG_SA1110_CDB20	0x00000080	/* Mem Clock divide by 2 0/1 */
> -#define MDCNFG_SA1110_TRP0	Fld(3, 8)	/* RAS precharge 0/1         */
> -#define MDCNFG_SA1110_TDL0	Fld(2, 12)	/* Data input latch after CAS*/
> -                	        		/* deassertion 0/1           */
> -#define MDCNFG_SA1110_TWR0	Fld(2, 14)	/* SDRAM write recovery 0/1  */
> -#define MDCNFG_SA1110_DE2	0x00010000	/* DRAM Enable bank 0        */
> -#define MDCNFG_SA1110_DE3	0x00020000 	/* DRAM Enable bank 1        */
> -#define MDCNFG_SA1110_DTIM2	0x00040000	/* DRAM timing type 0/1      */
> -#define MDCNFG_SA1110_DWID2	0x00080000	/* DRAM bus width 0/1        */
> -#define MDCNFG_SA1110_DRAC2	Fld(3, 20)	/* DRAM row addr bit count   */
> -                	        		/* bank 0/1                  */
> -#define MDCNFG_SA1110_CDB22	0x00800000	/* Mem Clock divide by 2 0/1 */
> -#define MDCNFG_SA1110_TRP2	Fld(3, 24)	/* RAS precharge 0/1         */
> -#define MDCNFG_SA1110_TDL2	Fld(2, 28)	/* Data input latch after CAS*/
> -                	        		/* deassertion 0/1           */
> -#define MDCNFG_SA1110_TWR2	Fld(2, 30)	/* SDRAM write recovery 0/1  */
> -
> -
> -/*
> - * Static memory control registers
> - *
> - * Registers
> - *    MSC0      	Memory system: Static memory Control register 0
> - *              	(read/write).
> - *    MSC1      	Memory system: Static memory Control register 1
> - *              	(read/write).
> - *
> - * Clocks
> - *    fcpu, Tcpu	Frequency, period of the CPU core clock (CCLK).
> - *    fmem, Tmem	Frequency, period of the memory clock (fmem = fcpu/2).
> - */
> -
> -#define MSC0		__REG(0xa0000010)  /* Static memory Control reg. 0 */
> -#define MSC1		__REG(0xa0000014)  /* Static memory Control reg. 1 */
> -#define MSC2		__REG(0xa000002c)  /* Static memory Control reg. 2, not contiguous   */
> -
> -#define MSC_Bnk(Nb)	        	/* static memory Bank [0..3]       */ \
> -                	Fld (16, ((Nb) Modulo 2)*16)
> -#define MSC0_Bnk0	MSC_Bnk (0)	/* static memory Bank 0            */
> -#define MSC0_Bnk1	MSC_Bnk (1)	/* static memory Bank 1            */
> -#define MSC1_Bnk2	MSC_Bnk (2)	/* static memory Bank 2            */
> -#define MSC1_Bnk3	MSC_Bnk (3)	/* static memory Bank 3            */
> -
> -#define MSC_RT  	Fld (2, 0)	/* ROM/static memory Type          */
> -#define MSC_NonBrst	        	/*  Non-Burst static memory        */ \
> -                	(0 << FShft (MSC_RT))
> -#define MSC_SRAM	        	/*  32-bit byte-writable SRAM      */ \
> -                	(1 << FShft (MSC_RT))
> -#define MSC_Brst4	        	/*  Burst-of-4 static memory       */ \
> -                	(2 << FShft (MSC_RT))
> -#define MSC_Brst8	        	/*  Burst-of-8 static memory       */ \
> -                	(3 << FShft (MSC_RT))
> -#define MSC_RBW 	0x0004  	/* ROM/static memory Bus Width     */
> -#define MSC_32BitStMem	(MSC_RBW*0)	/*  32-Bit Static Memory           */
> -#define MSC_16BitStMem	(MSC_RBW*1)	/*  16-Bit Static Memory           */
> -#define MSC_RDF 	Fld (5, 3)	/* ROM/static memory read Delay    */
> -                	        	/* First access - 1(.5) [Tmem]     */
> -#define MSC_1stRdAcc(Tcpu)      	/*  1st Read Access time (burst    */ \
> -                	        	/*  static memory) [3..65 Tcpu]    */ \
> -                	((((Tcpu) - 3)/2) << FShft (MSC_RDF))
> -#define MSC_Ceil1stRdAcc(Tcpu)  	/*  Ceil. of 1stRdAcc [3..65 Tcpu] */ \
> -                	((((Tcpu) - 2)/2) << FShft (MSC_RDF))
> -#define MSC_RdAcc(Tcpu)	        	/*  Read Access time (non-burst    */ \
> -                	        	/*  static memory) [2..64 Tcpu]    */ \
> -                	((((Tcpu) - 2)/2) << FShft (MSC_RDF))
> -#define MSC_CeilRdAcc(Tcpu)     	/*  Ceil. of RdAcc [2..64 Tcpu]    */ \
> -                	((((Tcpu) - 1)/2) << FShft (MSC_RDF))
> -#define MSC_RDN 	Fld (5, 8)	/* ROM/static memory read Delay    */
> -                	        	/* Next access - 1 [Tmem]          */
> -#define MSC_NxtRdAcc(Tcpu)      	/*  Next Read Access time (burst   */ \
> -                	        	/*  static memory) [2..64 Tcpu]    */ \
> -                	((((Tcpu) - 2)/2) << FShft (MSC_RDN))
> -#define MSC_CeilNxtRdAcc(Tcpu)  	/*  Ceil. of NxtRdAcc [2..64 Tcpu] */ \
> -                	((((Tcpu) - 1)/2) << FShft (MSC_RDN))
> -#define MSC_WrAcc(Tcpu)	        	/*  Write Access time (non-burst   */ \
> -                	        	/*  static memory) [2..64 Tcpu]    */ \
> -                	((((Tcpu) - 2)/2) << FShft (MSC_RDN))
> -#define MSC_CeilWrAcc(Tcpu)     	/*  Ceil. of WrAcc [2..64 Tcpu]    */ \
> -                	((((Tcpu) - 1)/2) << FShft (MSC_RDN))
> -#define MSC_RRR 	Fld (3, 13)	/* ROM/static memory RecoveRy      */
> -                	        	/* time/2 [Tmem]                   */
> -#define MSC_Rec(Tcpu)	        	/*  Recovery time [0..28 Tcpu]     */ \
> -                	(((Tcpu)/4) << FShft (MSC_RRR))
> -#define MSC_CeilRec(Tcpu)       	/*  Ceil. of Rec [0..28 Tcpu]      */ \
> -                	((((Tcpu) + 3)/4) << FShft (MSC_RRR))
> -
> -
> -/*
> - * Personal Computer Memory Card International Association (PCMCIA) control
> - * register
> - *
> - * Register
> - *    MECR      	Memory system: Expansion memory bus (PCMCIA)
> - *              	Configuration Register (read/write).
> - *
> - * Clocks
> - *    fcpu, Tcpu	Frequency, period of the CPU core clock (CCLK).
> - *    fmem, Tmem	Frequency, period of the memory clock (fmem = fcpu/2).
> - *    fbclk, Tbclk	Frequency, period of the PCMCIA clock (BCLK).
> - */
> -
> -                	        	/* Memory system:                  */
> -#define MECR		__REG(0xA0000018)  /*  Expansion memory bus (PCMCIA) Configuration Reg.             */
> -
> -#define MECR_PCMCIA(Nb)	        	/* PCMCIA [0..1]                   */ \
> -                	Fld (15, (Nb)*16)
> -#define MECR_PCMCIA0	MECR_PCMCIA (0)	/* PCMCIA 0                        */
> -#define MECR_PCMCIA1	MECR_PCMCIA (1)	/* PCMCIA 1                        */
> -
> -#define MECR_BSIO	Fld (5, 0)	/* BCLK Select I/O - 1 [Tmem]      */
> -#define MECR_IOClk(Tcpu)        	/*  I/O Clock [2..64 Tcpu]         */ \
> -                	((((Tcpu) - 2)/2) << FShft (MECR_BSIO))
> -#define MECR_CeilIOClk(Tcpu)    	/*  Ceil. of IOClk [2..64 Tcpu]    */ \
> -                	((((Tcpu) - 1)/2) << FShft (MECR_BSIO))
> -#define MECR_BSA	Fld (5, 5)	/* BCLK Select Attribute - 1       */
> -                	        	/* [Tmem]                          */
> -#define MECR_AttrClk(Tcpu)      	/*  Attribute Clock [2..64 Tcpu]   */ \
> -                	((((Tcpu) - 2)/2) << FShft (MECR_BSA))
> -#define MECR_CeilAttrClk(Tcpu)  	/*  Ceil. of AttrClk [2..64 Tcpu]  */ \
> -                	((((Tcpu) - 1)/2) << FShft (MECR_BSA))
> -#define MECR_BSM	Fld (5, 10)	/* BCLK Select Memory - 1 [Tmem]   */
> -#define MECR_MemClk(Tcpu)       	/*  Memory Clock [2..64 Tcpu]      */ \
> -                	((((Tcpu) - 2)/2) << FShft (MECR_BSM))
> -#define MECR_CeilMemClk(Tcpu)   	/*  Ceil. of MemClk [2..64 Tcpu]   */ \
> -                	((((Tcpu) - 1)/2) << FShft (MECR_BSM))
> -
> -/*
> - * On SA1110 only
> - */
> -
> -#define MDREFR		__REG(0xA000001C)
> -
> -#define MDREFR_TRASR		Fld (4, 0)
> -#define MDREFR_DRI		Fld (12, 4)
> -#define MDREFR_E0PIN		(1 << 16)
> -#define MDREFR_K0RUN		(1 << 17)
> -#define MDREFR_K0DB2		(1 << 18)
> -#define MDREFR_E1PIN		(1 << 20)
> -#define MDREFR_K1RUN		(1 << 21)
> -#define MDREFR_K1DB2		(1 << 22)
> -#define MDREFR_K2RUN		(1 << 25)
> -#define MDREFR_K2DB2		(1 << 26)
> -#define MDREFR_EAPD		(1 << 28)
> -#define MDREFR_KAPD		(1 << 29)
> -#define MDREFR_SLFRSH		(1 << 31)
> -
> -
> -/*
> - * Direct Memory Access (DMA) control registers
> - */
> -#define DMA_SIZE	(6 * 0x20)
> -#define DMA_PHYS	0xb0000000
> -
> -
> -/*
> - * Liquid Crystal Display (LCD) control registers
> - *
> - * Registers
> - *    LCCR0     	Liquid Crystal Display (LCD) Control Register 0
> - *              	(read/write).
> - *              	[Bits LDM, BAM, and ERM are only implemented in
> - *              	versions 2.0 (rev. = 8) and higher of the StrongARM
> - *              	SA-1100.]
> - *    LCSR      	Liquid Crystal Display (LCD) Status Register
> - *              	(read/write).
> - *              	[Bit LDD can be only read in versions 1.0 (rev. = 1)
> - *              	and 1.1 (rev. = 2) of the StrongARM SA-1100, it can be
> - *              	read and written (cleared) in versions 2.0 (rev. = 8)
> - *              	and higher.]
> - *    DBAR1     	Liquid Crystal Display (LCD) Direct Memory Access
> - *              	(DMA) Base Address Register channel 1 (read/write).
> - *    DCAR1     	Liquid Crystal Display (LCD) Direct Memory Access
> - *              	(DMA) Current Address Register channel 1 (read).
> - *    DBAR2     	Liquid Crystal Display (LCD) Direct Memory Access
> - *              	(DMA) Base Address Register channel 2 (read/write).
> - *    DCAR2     	Liquid Crystal Display (LCD) Direct Memory Access
> - *              	(DMA) Current Address Register channel 2 (read).
> - *    LCCR1     	Liquid Crystal Display (LCD) Control Register 1
> - *              	(read/write).
> - *              	[The LCCR1 register can be only written in
> - *              	versions 1.0 (rev. = 1) and 1.1 (rev. = 2) of the
> - *              	StrongARM SA-1100, it can be written and read in
> - *              	versions 2.0 (rev. = 8) and higher.]
> - *    LCCR2     	Liquid Crystal Display (LCD) Control Register 2
> - *              	(read/write).
> - *              	[The LCCR1 register can be only written in
> - *              	versions 1.0 (rev. = 1) and 1.1 (rev. = 2) of the
> - *              	StrongARM SA-1100, it can be written and read in
> - *              	versions 2.0 (rev. = 8) and higher.]
> - *    LCCR3     	Liquid Crystal Display (LCD) Control Register 3
> - *              	(read/write).
> - *              	[The LCCR1 register can be only written in
> - *              	versions 1.0 (rev. = 1) and 1.1 (rev. = 2) of the
> - *              	StrongARM SA-1100, it can be written and read in
> - *              	versions 2.0 (rev. = 8) and higher. Bit PCP is only
> - *              	implemented in versions 2.0 (rev. = 8) and higher of
> - *              	the StrongARM SA-1100.]
> - *
> - * Clocks
> - *    fcpu, Tcpu	Frequency, period of the CPU core clock (CCLK).
> - *    fmem, Tmem	Frequency, period of the memory clock (fmem = fcpu/2).
> - *    fpix, Tpix	Frequency, period of the pixel clock.
> - *    fln, Tln  	Frequency, period of the line clock.
> - *    fac, Tac  	Frequency, period of the AC bias clock.
> - */
> -
> -#define LCD_PEntrySp	2       	/* LCD Palette Entry Space [byte]  */
> -#define LCD_4BitPSp	        	/* LCD 4-Bit pixel Palette Space   */ \
> -                	        	/* [byte]                          */ \
> -                	(16*LCD_PEntrySp)
> -#define LCD_8BitPSp	        	/* LCD 8-Bit pixel Palette Space   */ \
> -                	        	/* [byte]                          */ \
> -                	(256*LCD_PEntrySp)
> -#define LCD_12_16BitPSp	        	/* LCD 12/16-Bit pixel             */ \
> -                	        	/* dummy-Palette Space [byte]      */ \
> -                	(16*LCD_PEntrySp)
> -
> -#define LCD_PGrey	Fld (4, 0)	/* LCD Palette entry Grey value    */
> -#define LCD_PBlue	Fld (4, 0)	/* LCD Palette entry Blue value    */
> -#define LCD_PGreen	Fld (4, 4)	/* LCD Palette entry Green value   */
> -#define LCD_PRed	Fld (4, 8)	/* LCD Palette entry Red value     */
> -#define LCD_PBS 	Fld (2, 12)	/* LCD Pixel Bit Size              */
> -#define LCD_4Bit	        	/*  LCD 4-Bit pixel mode           */ \
> -                	(0 << FShft (LCD_PBS))
> -#define LCD_8Bit	        	/*  LCD 8-Bit pixel mode           */ \
> -                	(1 << FShft (LCD_PBS))
> -#define LCD_12_16Bit	        	/*  LCD 12/16-Bit pixel mode       */ \
> -                	(2 << FShft (LCD_PBS))
> -
> -#define LCD_Int0_0	0x0     	/* LCD Intensity =   0.0% =  0     */
> -#define LCD_Int11_1	0x1     	/* LCD Intensity =  11.1% =  1/9   */
> -#define LCD_Int20_0	0x2     	/* LCD Intensity =  20.0% =  1/5   */
> -#define LCD_Int26_7	0x3     	/* LCD Intensity =  26.7% =  4/15  */
> -#define LCD_Int33_3	0x4     	/* LCD Intensity =  33.3% =  3/9   */
> -#define LCD_Int40_0	0x5     	/* LCD Intensity =  40.0% =  2/5   */
> -#define LCD_Int44_4	0x6     	/* LCD Intensity =  44.4% =  4/9   */
> -#define LCD_Int50_0	0x7     	/* LCD Intensity =  50.0% =  1/2   */
> -#define LCD_Int55_6	0x8     	/* LCD Intensity =  55.6% =  5/9   */
> -#define LCD_Int60_0	0x9     	/* LCD Intensity =  60.0% =  3/5   */
> -#define LCD_Int66_7	0xA     	/* LCD Intensity =  66.7% =  6/9   */
> -#define LCD_Int73_3	0xB     	/* LCD Intensity =  73.3% = 11/15  */
> -#define LCD_Int80_0	0xC     	/* LCD Intensity =  80.0% =  4/5   */
> -#define LCD_Int88_9	0xD     	/* LCD Intensity =  88.9% =  8/9   */
> -#define LCD_Int100_0	0xE     	/* LCD Intensity = 100.0% =  1     */
> -#define LCD_Int100_0A	0xF     	/* LCD Intensity = 100.0% =  1     */
> -                	        	/* (Alternative)                   */
> -
> -#define LCCR0_LEN	0x00000001	/* LCD ENable                      */
> -#define LCCR0_CMS	0x00000002	/* Color/Monochrome display Select */
> -#define LCCR0_Color	(LCCR0_CMS*0)	/*  Color display                  */
> -#define LCCR0_Mono	(LCCR0_CMS*1)	/*  Monochrome display             */
> -#define LCCR0_SDS	0x00000004	/* Single/Dual panel display       */
> -                	        	/* Select                          */
> -#define LCCR0_Sngl	(LCCR0_SDS*0)	/*  Single panel display           */
> -#define LCCR0_Dual	(LCCR0_SDS*1)	/*  Dual panel display             */
> -#define LCCR0_LDM	0x00000008	/* LCD Disable done (LDD)          */
> -                	        	/* interrupt Mask (disable)        */
> -#define LCCR0_BAM	0x00000010	/* Base Address update (BAU)       */
> -                	        	/* interrupt Mask (disable)        */
> -#define LCCR0_ERM	0x00000020	/* LCD ERror (BER, IOL, IUL, IOU,  */
> -                	        	/* IUU, OOL, OUL, OOU, and OUU)    */
> -                	        	/* interrupt Mask (disable)        */
> -#define LCCR0_PAS	0x00000080	/* Passive/Active display Select   */
> -#define LCCR0_Pas	(LCCR0_PAS*0)	/*  Passive display (STN)          */
> -#define LCCR0_Act	(LCCR0_PAS*1)	/*  Active display (TFT)           */
> -#define LCCR0_BLE	0x00000100	/* Big/Little Endian select        */
> -#define LCCR0_LtlEnd	(LCCR0_BLE*0)	/*  Little Endian frame buffer     */
> -#define LCCR0_BigEnd	(LCCR0_BLE*1)	/*  Big Endian frame buffer        */
> -#define LCCR0_DPD	0x00000200	/* Double Pixel Data (monochrome   */
> -                	        	/* display mode)                   */
> -#define LCCR0_4PixMono	(LCCR0_DPD*0)	/*  4-Pixel/clock Monochrome       */
> -                	        	/*  display                        */
> -#define LCCR0_8PixMono	(LCCR0_DPD*1)	/*  8-Pixel/clock Monochrome       */
> -                	        	/*  display                        */
> -#define LCCR0_PDD	Fld (8, 12)	/* Palette DMA request Delay       */
> -                	        	/* [Tmem]                          */
> -#define LCCR0_DMADel(Tcpu)      	/*  palette DMA request Delay      */ \
> -                	        	/*  [0..510 Tcpu]                  */ \
> -                	((Tcpu)/2 << FShft (LCCR0_PDD))
> -
> -#define LCSR_LDD	0x00000001	/* LCD Disable Done                */
> -#define LCSR_BAU	0x00000002	/* Base Address Update (read)      */
> -#define LCSR_BER	0x00000004	/* Bus ERror                       */
> -#define LCSR_ABC	0x00000008	/* AC Bias clock Count             */
> -#define LCSR_IOL	0x00000010	/* Input FIFO Over-run Lower       */
> -                	        	/* panel                           */
> -#define LCSR_IUL	0x00000020	/* Input FIFO Under-run Lower      */
> -                	        	/* panel                           */
> -#define LCSR_IOU	0x00000040	/* Input FIFO Over-run Upper       */
> -                	        	/* panel                           */
> -#define LCSR_IUU	0x00000080	/* Input FIFO Under-run Upper      */
> -                	        	/* panel                           */
> -#define LCSR_OOL	0x00000100	/* Output FIFO Over-run Lower      */
> -                	        	/* panel                           */
> -#define LCSR_OUL	0x00000200	/* Output FIFO Under-run Lower     */
> -                	        	/* panel                           */
> -#define LCSR_OOU	0x00000400	/* Output FIFO Over-run Upper      */
> -                	        	/* panel                           */
> -#define LCSR_OUU	0x00000800	/* Output FIFO Under-run Upper     */
> -                	        	/* panel                           */
> -
> -#define LCCR1_PPL	Fld (6, 4)	/* Pixels Per Line/16 - 1          */
> -#define LCCR1_DisWdth(Pixel)    	/*  Display Width [16..1024 pix.]  */ \
> -                	(((Pixel) - 16)/16 << FShft (LCCR1_PPL))
> -#define LCCR1_HSW	Fld (6, 10)	/* Horizontal Synchronization      */
> -                	        	/* pulse Width - 1 [Tpix] (L_LCLK) */
> -#define LCCR1_HorSnchWdth(Tpix) 	/*  Horizontal Synchronization     */ \
> -                	        	/*  pulse Width [1..64 Tpix]       */ \
> -                	(((Tpix) - 1) << FShft (LCCR1_HSW))
> -#define LCCR1_ELW	Fld (8, 16)	/* End-of-Line pixel clock Wait    */
> -                	        	/* count - 1 [Tpix]                */
> -#define LCCR1_EndLnDel(Tpix)    	/*  End-of-Line Delay              */ \
> -                	        	/*  [1..256 Tpix]                  */ \
> -                	(((Tpix) - 1) << FShft (LCCR1_ELW))
> -#define LCCR1_BLW	Fld (8, 24)	/* Beginning-of-Line pixel clock   */
> -                	        	/* Wait count - 1 [Tpix]           */
> -#define LCCR1_BegLnDel(Tpix)    	/*  Beginning-of-Line Delay        */ \
> -                	        	/*  [1..256 Tpix]                  */ \
> -                	(((Tpix) - 1) << FShft (LCCR1_BLW))
> -
> -#define LCCR2_LPP	Fld (10, 0)	/* Line Per Panel - 1              */
> -#define LCCR2_DisHght(Line)     	/*  Display Height [1..1024 lines] */ \
> -                	(((Line) - 1) << FShft (LCCR2_LPP))
> -#define LCCR2_VSW	Fld (6, 10)	/* Vertical Synchronization pulse  */
> -                	        	/* Width - 1 [Tln] (L_FCLK)        */
> -#define LCCR2_VrtSnchWdth(Tln)  	/*  Vertical Synchronization pulse */ \
> -                	        	/*  Width [1..64 Tln]              */ \
> -                	(((Tln) - 1) << FShft (LCCR2_VSW))
> -#define LCCR2_EFW	Fld (8, 16)	/* End-of-Frame line clock Wait    */
> -                	        	/* count [Tln]                     */
> -#define LCCR2_EndFrmDel(Tln)    	/*  End-of-Frame Delay             */ \
> -                	        	/*  [0..255 Tln]                   */ \
> -                	((Tln) << FShft (LCCR2_EFW))
> -#define LCCR2_BFW	Fld (8, 24)	/* Beginning-of-Frame line clock   */
> -                	        	/* Wait count [Tln]                */
> -#define LCCR2_BegFrmDel(Tln)    	/*  Beginning-of-Frame Delay       */ \
> -                	        	/*  [0..255 Tln]                   */ \
> -                	((Tln) << FShft (LCCR2_BFW))
> -
> -#define LCCR3_PCD	Fld (8, 0)	/* Pixel Clock Divisor/2 - 2       */
> -                	        	/* [1..255] (L_PCLK)               */
> -                	        	/* fpix = fcpu/(2*(PCD + 2))       */
> -                	        	/* Tpix = 2*(PCD + 2)*Tcpu         */
> -#define LCCR3_PixClkDiv(Div)    	/*  Pixel Clock Divisor [6..514]   */ \
> -                	(((Div) - 4)/2 << FShft (LCCR3_PCD))
> -                	        	/*  fpix = fcpu/(2*Floor (Div/2))  */
> -                	        	/*  Tpix = 2*Floor (Div/2)*Tcpu    */
> -#define LCCR3_CeilPixClkDiv(Div)	/*  Ceil. of PixClkDiv [6..514]    */ \
> -                	(((Div) - 3)/2 << FShft (LCCR3_PCD))
> -                	        	/*  fpix = fcpu/(2*Ceil (Div/2))   */
> -                	        	/*  Tpix = 2*Ceil (Div/2)*Tcpu     */
> -#define LCCR3_ACB	Fld (8, 8)	/* AC Bias clock half period - 1   */
> -                	        	/* [Tln] (L_BIAS)                  */
> -#define LCCR3_ACBsDiv(Div)      	/*  AC Bias clock Divisor [2..512] */ \
> -                	(((Div) - 2)/2 << FShft (LCCR3_ACB))
> -                	        	/*  fac = fln/(2*Floor (Div/2))    */
> -                	        	/*  Tac = 2*Floor (Div/2)*Tln      */
> -#define LCCR3_CeilACBsDiv(Div)  	/*  Ceil. of ACBsDiv [2..512]      */ \
> -                	(((Div) - 1)/2 << FShft (LCCR3_ACB))
> -                	        	/*  fac = fln/(2*Ceil (Div/2))     */
> -                	        	/*  Tac = 2*Ceil (Div/2)*Tln       */
> -#define LCCR3_API	Fld (4, 16)	/* AC bias Pin transitions per     */
> -                	        	/* Interrupt                       */
> -#define LCCR3_ACBsCntOff        	/*  AC Bias clock transition Count */ \
> -                	        	/*  Off                            */ \
> -                	(0 << FShft (LCCR3_API))
> -#define LCCR3_ACBsCnt(Trans)    	/*  AC Bias clock transition Count */ \
> -                	        	/*  [1..15]                        */ \
> -                	((Trans) << FShft (LCCR3_API))
> -#define LCCR3_VSP	0x00100000	/* Vertical Synchronization pulse  */
> -                	        	/* Polarity (L_FCLK)               */
> -#define LCCR3_VrtSnchH	(LCCR3_VSP*0)	/*  Vertical Synchronization pulse */
> -                	        	/*  active High                    */
> -#define LCCR3_VrtSnchL	(LCCR3_VSP*1)	/*  Vertical Synchronization pulse */
> -                	        	/*  active Low                     */
> -#define LCCR3_HSP	0x00200000	/* Horizontal Synchronization      */
> -                	        	/* pulse Polarity (L_LCLK)         */
> -#define LCCR3_HorSnchH	(LCCR3_HSP*0)	/*  Horizontal Synchronization     */
> -                	        	/*  pulse active High              */
> -#define LCCR3_HorSnchL	(LCCR3_HSP*1)	/*  Horizontal Synchronization     */
> -                	        	/*  pulse active Low               */
> -#define LCCR3_PCP	0x00400000	/* Pixel Clock Polarity (L_PCLK)   */
> -#define LCCR3_PixRsEdg	(LCCR3_PCP*0)	/*  Pixel clock Rising-Edge        */
> -#define LCCR3_PixFlEdg	(LCCR3_PCP*1)	/*  Pixel clock Falling-Edge       */
> -#define LCCR3_OEP	0x00800000	/* Output Enable Polarity (L_BIAS, */
> -                	        	/* active display mode)            */
> -#define LCCR3_OutEnH	(LCCR3_OEP*0)	/*  Output Enable active High      */
> -#define LCCR3_OutEnL	(LCCR3_OEP*1)	/*  Output Enable active Low       */
> diff --git a/arch/arm/mach-sa1100/include/mach/assabet.h b/arch/arm/mach-sa1100/include/mach/assabet.h
> deleted file mode 100644
> index 641a961653af..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/assabet.h
> +++ /dev/null
> @@ -1,99 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/mach-sa1100/include/mach/assabet.h
> - *
> - * Created 2000/06/05 by Nicolas Pitre <nico@fluxnic.net>
> - *
> - * This file contains the hardware specific definitions for Assabet
> - * Only include this file from SA1100-specific files.
> - *
> - * 2000/05/23 John Dorsey <john+@cs.cmu.edu>
> - *      Definitions for Neponset added.
> - */
> -#ifndef __ASM_ARCH_ASSABET_H
> -#define __ASM_ARCH_ASSABET_H
> -
> -
> -/* System Configuration Register flags */
> -
> -#define ASSABET_SCR_SDRAM_LOW	(1<<2)	/* SDRAM size (low bit) */
> -#define ASSABET_SCR_SDRAM_HIGH	(1<<3)	/* SDRAM size (high bit) */
> -#define ASSABET_SCR_FLASH_LOW	(1<<4)	/* Flash size (low bit) */
> -#define ASSABET_SCR_FLASH_HIGH	(1<<5)	/* Flash size (high bit) */
> -#define ASSABET_SCR_GFX		(1<<8)	/* Graphics Accelerator (0 = present) */
> -#define ASSABET_SCR_SA1111	(1<<9)	/* Neponset (0 = present) */
> -
> -#define ASSABET_SCR_INIT	-1
> -
> -extern unsigned long SCR_value;
> -
> -#ifdef CONFIG_ASSABET_NEPONSET
> -#define machine_has_neponset()  ((SCR_value & ASSABET_SCR_SA1111) == 0)
> -#else
> -#define machine_has_neponset()	(0)
> -#endif
> -
> -/* Board Control Register */
> -
> -#define ASSABET_BCR_BASE  0xf1000000
> -#define ASSABET_BCR (*(volatile unsigned int *)(ASSABET_BCR_BASE))
> -
> -#define ASSABET_BCR_CF_PWR	(1<<0)	/* Compact Flash Power (1 = 3.3v, 0 = off) */
> -#define ASSABET_BCR_CF_RST	(1<<1)	/* Compact Flash Reset (1 = power up reset) */
> -#define ASSABET_BCR_NGFX_RST	(1<<1)	/* Graphics Accelerator Reset (0 = hold reset) */
> -#define ASSABET_BCR_NCODEC_RST	(1<<2)	/* 0 = Holds UCB1300, ADI7171, and UDA1341 in reset */
> -#define ASSABET_BCR_IRDA_FSEL	(1<<3)	/* IRDA Frequency select (0 = SIR, 1 = MIR/ FIR) */
> -#define ASSABET_BCR_IRDA_MD0	(1<<4)	/* Range/Power select */
> -#define ASSABET_BCR_IRDA_MD1	(1<<5)	/* Range/Power select */
> -#define ASSABET_BCR_STEREO_LB	(1<<6)	/* Stereo Loopback */
> -#define ASSABET_BCR_CF_BUS_OFF	(1<<7)	/* Compact Flash bus (0 = on, 1 = off (float)) */
> -#define ASSABET_BCR_AUDIO_ON	(1<<8)	/* Audio power on */
> -#define ASSABET_BCR_LIGHT_ON	(1<<9)	/* Backlight */
> -#define ASSABET_BCR_LCD_12RGB	(1<<10)	/* 0 = 16RGB, 1 = 12RGB */
> -#define ASSABET_BCR_LCD_ON	(1<<11)	/* LCD power on */
> -#define ASSABET_BCR_RS232EN	(1<<12)	/* RS232 transceiver enable */
> -#define ASSABET_BCR_LED_RED	(1<<13)	/* D9 (0 = on, 1 = off) */
> -#define ASSABET_BCR_LED_GREEN	(1<<14)	/* D8 (0 = on, 1 = off) */
> -#define ASSABET_BCR_VIB_ON	(1<<15)	/* Vibration motor (quiet alert) */
> -#define ASSABET_BCR_COM_DTR	(1<<16)	/* COMport Data Terminal Ready */
> -#define ASSABET_BCR_COM_RTS	(1<<17)	/* COMport Request To Send */
> -#define ASSABET_BCR_RAD_WU	(1<<18)	/* Radio wake up interrupt */
> -#define ASSABET_BCR_SMB_EN	(1<<19)	/* System management bus enable */
> -#define ASSABET_BCR_TV_IR_DEC	(1<<20)	/* TV IR Decode Enable (not implemented) */
> -#define ASSABET_BCR_QMUTE	(1<<21)	/* Quick Mute */
> -#define ASSABET_BCR_RAD_ON	(1<<22)	/* Radio Power On */
> -#define ASSABET_BCR_SPK_OFF	(1<<23)	/* 1 = Speaker amplifier power off */
> -
> -#ifdef CONFIG_SA1100_ASSABET
> -extern void ASSABET_BCR_frob(unsigned int mask, unsigned int set);
> -#else
> -#define ASSABET_BCR_frob(x,y)	do { } while (0)
> -#endif
> -
> -extern void assabet_uda1341_reset(int set);
> -
> -#define ASSABET_BCR_set(x)	ASSABET_BCR_frob((x), (x))
> -#define ASSABET_BCR_clear(x)	ASSABET_BCR_frob((x), 0)
> -
> -#define ASSABET_BSR_BASE	0xf1000000
> -#define ASSABET_BSR (*(volatile unsigned int*)(ASSABET_BSR_BASE))
> -
> -#define ASSABET_BSR_RS232_VALID	(1 << 24)
> -#define ASSABET_BSR_COM_DCD	(1 << 25)
> -#define ASSABET_BSR_COM_CTS	(1 << 26)
> -#define ASSABET_BSR_COM_DSR	(1 << 27)
> -#define ASSABET_BSR_RAD_CTS	(1 << 28)
> -#define ASSABET_BSR_RAD_DSR	(1 << 29)
> -#define ASSABET_BSR_RAD_DCD	(1 << 30)
> -#define ASSABET_BSR_RAD_RI	(1 << 31)
> -
> -
> -/* GPIOs (bitmasks) for which the generic definition doesn't say much */
> -#define ASSABET_GPIO_RADIO_IRQ		GPIO_GPIO (14)	/* Radio interrupt request  */
> -#define ASSABET_GPIO_PS_MODE_SYNC	GPIO_GPIO (16)	/* Power supply mode/sync   */
> -#define ASSABET_GPIO_STEREO_64FS_CLK	GPIO_GPIO (19)	/* SSP UDA1341 clock input  */
> -#define ASSABET_GPIO_GFX_IRQ		GPIO_GPIO (24)	/* Graphics IRQ */
> -#define ASSABET_GPIO_BATT_LOW		GPIO_GPIO (26)	/* Low battery */
> -#define ASSABET_GPIO_RCLK		GPIO_GPIO (26)	/* CCLK/2  */
> -
> -#endif
> diff --git a/arch/arm/mach-sa1100/include/mach/bitfield.h b/arch/arm/mach-sa1100/include/mach/bitfield.h
> deleted file mode 100644
> index f1f0e3387d9c..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/bitfield.h
> +++ /dev/null
> @@ -1,113 +0,0 @@
> -/*
> - *	FILE    	bitfield.h
> - *
> - *	Version 	1.1
> - *	Author  	Copyright (c) Marc A. Viredaz, 1998
> - *	        	DEC Western Research Laboratory, Palo Alto, CA
> - *	Date    	April 1998 (April 1997)
> - *	System  	Advanced RISC Machine (ARM)
> - *	Language	C or ARM Assembly
> - *	Purpose 	Definition of macros to operate on bit fields.
> - */
> -
> -
> -
> -#ifndef __BITFIELD_H
> -#define __BITFIELD_H
> -
> -#ifndef __ASSEMBLY__
> -#define UData(Data)	((unsigned long) (Data))
> -#else
> -#define UData(Data)	(Data)
> -#endif
> -
> -
> -/*
> - * MACRO: Fld
> - *
> - * Purpose
> - *    The macro "Fld" encodes a bit field, given its size and its shift value
> - *    with respect to bit 0.
> - *
> - * Note
> - *    A more intuitive way to encode bit fields would have been to use their
> - *    mask. However, extracting size and shift value information from a bit
> - *    field's mask is cumbersome and might break the assembler (255-character
> - *    line-size limit).
> - *
> - * Input
> - *    Size      	Size of the bit field, in number of bits.
> - *    Shft      	Shift value of the bit field with respect to bit 0.
> - *
> - * Output
> - *    Fld       	Encoded bit field.
> - */
> -
> -#define Fld(Size, Shft)	(((Size) << 16) + (Shft))
> -
> -
> -/*
> - * MACROS: FSize, FShft, FMsk, FAlnMsk, F1stBit
> - *
> - * Purpose
> - *    The macros "FSize", "FShft", "FMsk", "FAlnMsk", and "F1stBit" return
> - *    the size, shift value, mask, aligned mask, and first bit of a
> - *    bit field.
> - *
> - * Input
> - *    Field     	Encoded bit field (using the macro "Fld").
> - *
> - * Output
> - *    FSize     	Size of the bit field, in number of bits.
> - *    FShft     	Shift value of the bit field with respect to bit 0.
> - *    FMsk      	Mask for the bit field.
> - *    FAlnMsk   	Mask for the bit field, aligned on bit 0.
> - *    F1stBit   	First bit of the bit field.
> - */
> -
> -#define FSize(Field)	((Field) >> 16)
> -#define FShft(Field)	((Field) & 0x0000FFFF)
> -#define FMsk(Field)	(((UData (1) << FSize (Field)) - 1) << FShft (Field))
> -#define FAlnMsk(Field)	((UData (1) << FSize (Field)) - 1)
> -#define F1stBit(Field)	(UData (1) << FShft (Field))
> -
> -
> -/*
> - * MACRO: FInsrt
> - *
> - * Purpose
> - *    The macro "FInsrt" inserts a value into a bit field by shifting the
> - *    former appropriately.
> - *
> - * Input
> - *    Value     	Bit-field value.
> - *    Field     	Encoded bit field (using the macro "Fld").
> - *
> - * Output
> - *    FInsrt    	Bit-field value positioned appropriately.
> - */
> -
> -#define FInsrt(Value, Field) \
> -                	(UData (Value) << FShft (Field))
> -
> -
> -/*
> - * MACRO: FExtr
> - *
> - * Purpose
> - *    The macro "FExtr" extracts the value of a bit field by masking and
> - *    shifting it appropriately.
> - *
> - * Input
> - *    Data      	Data containing the bit-field to be extracted.
> - *    Field     	Encoded bit field (using the macro "Fld").
> - *
> - * Output
> - *    FExtr     	Bit-field value.
> - */
> -
> -#define FExtr(Data, Field) \
> -                	((UData (Data) >> FShft (Field)) & FAlnMsk (Field))
> -
> -
> -#endif /* __BITFIELD_H */
> diff --git a/arch/arm/mach-sa1100/include/mach/collie.h b/arch/arm/mach-sa1100/include/mach/collie.h
> deleted file mode 100644
> index c95273c9567b..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/collie.h
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/mach-sa1100/include/mach/collie.h
> - *
> - * This file contains the hardware specific definitions for Collie
> - * Only include this file from SA1100-specific files.
> - *
> - * ChangeLog:
> - *   04-06-2001 Lineo Japan, Inc.
> - *   04-16-2001 SHARP Corporation
> - *   07-07-2002 Chris Larson <clarson@digi.com>
> - *
> - */
> -#ifndef __ASM_ARCH_COLLIE_H
> -#define __ASM_ARCH_COLLIE_H
> -
> -#include "hardware.h" /* Gives GPIO_MAX */
> -
> -#define COLLIE_SCOOP_GPIO_BASE	(GPIO_MAX + 1)
> -#define COLLIE_GPIO_CHARGE_ON	(COLLIE_SCOOP_GPIO_BASE + 0)
> -#define COLLIE_SCP_DIAG_BOOT1	SCOOP_GPCR_PA12
> -#define COLLIE_SCP_DIAG_BOOT2	SCOOP_GPCR_PA13
> -#define COLLIE_SCP_MUTE_L	SCOOP_GPCR_PA14
> -#define COLLIE_SCP_MUTE_R	SCOOP_GPCR_PA15
> -#define COLLIE_SCP_5VON		SCOOP_GPCR_PA16
> -#define COLLIE_SCP_AMP_ON	SCOOP_GPCR_PA17
> -#define COLLIE_GPIO_VPEN	(COLLIE_SCOOP_GPIO_BASE + 7)
> -#define COLLIE_SCP_LB_VOL_CHG	SCOOP_GPCR_PA19
> -
> -#define COLLIE_SCOOP_IO_DIR	(COLLIE_SCP_MUTE_L | COLLIE_SCP_MUTE_R | \
> -				COLLIE_SCP_5VON | COLLIE_SCP_AMP_ON | \
> -				COLLIE_SCP_LB_VOL_CHG)
> -#define COLLIE_SCOOP_IO_OUT	(COLLIE_SCP_MUTE_L | COLLIE_SCP_MUTE_R)
> -
> -/* GPIOs for gpiolib  */
> -
> -#define COLLIE_GPIO_ON_KEY		(0)
> -#define COLLIE_GPIO_AC_IN		(1)
> -#define COLLIE_GPIO_SDIO_INT		(11)
> -#define COLLIE_GPIO_CF_IRQ		(14)
> -#define COLLIE_GPIO_nREMOCON_INT	(15)
> -#define COLLIE_GPIO_UCB1x00_RESET	(16)
> -#define COLLIE_GPIO_nMIC_ON		(17)
> -#define COLLIE_GPIO_nREMOCON_ON		(18)
> -#define COLLIE_GPIO_CO			(20)
> -#define COLLIE_GPIO_MCP_CLK		(21)
> -#define COLLIE_GPIO_CF_CD		(22)
> -#define COLLIE_GPIO_UCB1x00_IRQ		(23)
> -#define COLLIE_GPIO_WAKEUP		(24)
> -#define COLLIE_GPIO_GA_INT		(25)
> -#define COLLIE_GPIO_MAIN_BAT_LOW	(26)
> -
> -/* GPIO definitions for direct register access */
> -
> -#define _COLLIE_GPIO_ON_KEY		GPIO_GPIO(0)
> -#define _COLLIE_GPIO_AC_IN		GPIO_GPIO(1)
> -#define _COLLIE_GPIO_nREMOCON_INT	GPIO_GPIO(15)
> -#define _COLLIE_GPIO_UCB1x00_RESET	GPIO_GPIO(16)
> -#define _COLLIE_GPIO_nMIC_ON		GPIO_GPIO(17)
> -#define _COLLIE_GPIO_nREMOCON_ON	GPIO_GPIO(18)
> -#define _COLLIE_GPIO_CO			GPIO_GPIO(20)
> -#define _COLLIE_GPIO_WAKEUP		GPIO_GPIO(24)
> -/* Interrupts */
> -
> -#define COLLIE_IRQ_GPIO_ON_KEY		IRQ_GPIO0
> -#define COLLIE_IRQ_GPIO_AC_IN		IRQ_GPIO1
> -#define COLLIE_IRQ_GPIO_SDIO_IRQ	IRQ_GPIO11
> -#define COLLIE_IRQ_GPIO_CF_IRQ		IRQ_GPIO14
> -#define COLLIE_IRQ_GPIO_nREMOCON_INT	IRQ_GPIO15
> -#define COLLIE_IRQ_GPIO_CO		IRQ_GPIO20
> -#define COLLIE_IRQ_GPIO_CF_CD		IRQ_GPIO22
> -#define COLLIE_IRQ_GPIO_UCB1x00_IRQ	IRQ_GPIO23
> -#define COLLIE_IRQ_GPIO_WAKEUP		IRQ_GPIO24
> -#define COLLIE_IRQ_GPIO_GA_INT		IRQ_GPIO25
> -#define COLLIE_IRQ_GPIO_MAIN_BAT_LOW	IRQ_GPIO26
> -
> -/* GPIO's on the TC35143AF (Toshiba Analog Frontend) */
> -#define COLLIE_TC35143_GPIO_BASE	(GPIO_MAX + 13)
> -#define COLLIE_TC35143_GPIO_VERSION0    UCB_IO_0
> -#define COLLIE_TC35143_GPIO_TBL_CHK     UCB_IO_1
> -#define COLLIE_TC35143_GPIO_VPEN_ON     UCB_IO_2
> -#define COLLIE_GPIO_IR_ON		(COLLIE_TC35143_GPIO_BASE + 3)
> -#define COLLIE_TC35143_GPIO_AMP_ON      UCB_IO_4
> -#define COLLIE_TC35143_GPIO_VERSION1    UCB_IO_5
> -#define COLLIE_TC35143_GPIO_FS8KLPF     UCB_IO_5
> -#define COLLIE_TC35143_GPIO_BUZZER_BIAS UCB_IO_6
> -#define COLLIE_GPIO_MBAT_ON     	(COLLIE_TC35143_GPIO_BASE + 7)
> -#define COLLIE_GPIO_BBAT_ON     	(COLLIE_TC35143_GPIO_BASE + 8)
> -#define COLLIE_GPIO_TMP_ON      	(COLLIE_TC35143_GPIO_BASE + 9)
> -#define COLLIE_TC35143_GPIO_IN		(UCB_IO_0 | UCB_IO_2 | UCB_IO_5)
> -#define COLLIE_TC35143_GPIO_OUT		(UCB_IO_1 | UCB_IO_3 | UCB_IO_4 \
> -						| UCB_IO_6)
> -
> -#endif
> diff --git a/arch/arm/mach-sa1100/include/mach/generic.h b/arch/arm/mach-sa1100/include/mach/generic.h
> deleted file mode 100644
> index 665542e0c9e2..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/generic.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -#include "../../generic.h"
> diff --git a/arch/arm/mach-sa1100/include/mach/h3xxx.h b/arch/arm/mach-sa1100/include/mach/h3xxx.h
> deleted file mode 100644
> index 0ee2578e0006..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/h3xxx.h
> +++ /dev/null
> @@ -1,81 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Definitions for Compaq iPAQ H3100 and H3600 handheld computers
> - *
> - * (c) 2000 Compaq Computer Corporation. (Author: Jamey Hicks)
> - * (c) 2009 Dmitry Artamonow <mad_soft@inbox.ru>
> - */
> -
> -#ifndef _INCLUDE_H3XXX_H_
> -#define _INCLUDE_H3XXX_H_
> -
> -#include "hardware.h" /* Gives GPIO_MAX */
> -
> -/* Physical memory regions corresponding to chip selects */
> -#define H3600_EGPIO_PHYS	(SA1100_CS5_PHYS + 0x01000000)
> -#define H3600_BANK_2_PHYS	SA1100_CS2_PHYS
> -#define H3600_BANK_4_PHYS	SA1100_CS4_PHYS
> -
> -/* Virtual memory regions corresponding to chip selects 2 & 4 (used on sleeves) */
> -#define H3600_EGPIO_VIRT	0xf0000000
> -#define H3600_BANK_2_VIRT	0xf1000000
> -#define H3600_BANK_4_VIRT	0xf3800000
> -
> -/*
> - * gpiolib numbers for all iPAQs
> - */
> -#define H3XXX_GPIO_PWR_BUTTON		0
> -#define H3XXX_GPIO_PCMCIA_CD1		10
> -#define H3XXX_GPIO_PCMCIA_IRQ1		11
> -#define H3XXX_GPIO_PCMCIA_CD0		17
> -#define H3XXX_GPIO_ACTION_BUTTON	18
> -#define H3XXX_GPIO_SYS_CLK		19
> -#define H3XXX_GPIO_PCMCIA_IRQ0		21
> -#define H3XXX_GPIO_COM_DCD		23
> -#define H3XXX_GPIO_OPTION		24
> -#define H3XXX_GPIO_COM_CTS		25
> -#define H3XXX_GPIO_COM_RTS		26
> -
> -/* machine-specific gpios */
> -
> -#define H3100_GPIO_BT_ON		2
> -#define H3100_GPIO_QMUTE		4
> -#define H3100_GPIO_LCD_3V_ON		5
> -#define H3100_GPIO_AUD_ON		6
> -#define H3100_GPIO_AUD_PWR_ON		7
> -#define H3100_GPIO_IR_ON		8
> -#define H3100_GPIO_IR_FSEL		9
> -
> -#define H3600_GPIO_CLK_SET0		12	/* audio sample rate clock generator */
> -#define H3600_GPIO_CLK_SET1		13
> -#define H3600_GPIO_SOFT_RESET		20	/* also known as BATT_FAULT */
> -#define H3600_GPIO_OPT_LOCK		22
> -#define H3600_GPIO_OPT_DET		27
> -
> -
> -/* H3100 / 3600 EGPIO pins */
> -#define H3XXX_EGPIO_BASE		(GPIO_MAX + 1)
> -
> -#define H3XXX_EGPIO_VPP_ON		(H3XXX_EGPIO_BASE + 0)
> -#define H3XXX_EGPIO_CARD_RESET		(H3XXX_EGPIO_BASE + 1) /* reset the attached pcmcia/compactflash card.  active high. */
> -#define H3XXX_EGPIO_OPT_RESET		(H3XXX_EGPIO_BASE + 2) /* reset the attached option pack.  active high. */
> -#define H3XXX_EGPIO_CODEC_NRESET	(H3XXX_EGPIO_BASE + 3) /* reset the onboard UDA1341.  active low. */
> -#define H3XXX_EGPIO_OPT_NVRAM_ON	(H3XXX_EGPIO_BASE + 4) /* apply power to optionpack nvram, active high. */
> -#define H3XXX_EGPIO_OPT_ON		(H3XXX_EGPIO_BASE + 5) /* full power to option pack.  active high. */
> -#define H3XXX_EGPIO_LCD_ON		(H3XXX_EGPIO_BASE + 6) /* enable 3.3V to LCD.  active high. */
> -#define H3XXX_EGPIO_RS232_ON		(H3XXX_EGPIO_BASE + 7) /* UART3 transceiver force on.  Active high. */
> -
> -/* H3600 only EGPIO pins */
> -#define H3600_EGPIO_LCD_PCI		(H3XXX_EGPIO_BASE + 8) /* LCD control IC enable.  active high. */
> -#define H3600_EGPIO_IR_ON		(H3XXX_EGPIO_BASE + 9) /* apply power to IR module.  active high. */
> -#define H3600_EGPIO_AUD_AMP_ON		(H3XXX_EGPIO_BASE + 10) /* apply power to audio power amp.  active high. */
> -#define H3600_EGPIO_AUD_PWR_ON		(H3XXX_EGPIO_BASE + 11) /* apply power to reset of audio circuit.  active high. */
> -#define H3600_EGPIO_QMUTE		(H3XXX_EGPIO_BASE + 12) /* mute control for onboard UDA1341.  active high. */
> -#define H3600_EGPIO_IR_FSEL		(H3XXX_EGPIO_BASE + 13) /* IR speed select: 1->fast, 0->slow */
> -#define H3600_EGPIO_LCD_5V_ON		(H3XXX_EGPIO_BASE + 14) /* enable 5V to LCD. active high. */
> -#define H3600_EGPIO_LVDD_ON		(H3XXX_EGPIO_BASE + 15) /* enable 9V and -6.5V to LCD. */
> -
> -void __init h3xxx_map_io(void);
> -void __init h3xxx_mach_init(void);
> -
> -#endif /* _INCLUDE_H3XXX_H_ */
> diff --git a/arch/arm/mach-sa1100/include/mach/hardware.h b/arch/arm/mach-sa1100/include/mach/hardware.h
> deleted file mode 100644
> index 6f2dbdc28663..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/hardware.h
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/mach-sa1100/include/mach/hardware.h
> - *
> - * Copyright (C) 1998 Nicolas Pitre <nico@fluxnic.net>
> - *
> - * This file contains the hardware definitions for SA1100 architecture
> - *
> - * 2000/05/23 John Dorsey <john+@cs.cmu.edu>
> - *      Definitions for SA1111 added.
> - */
> -
> -#ifndef __ASM_ARCH_HARDWARE_H
> -#define __ASM_ARCH_HARDWARE_H
> -
> -
> -#define UNCACHEABLE_ADDR	0xfa050000	/* ICIP */
> -
> -
> -/*
> - * SA1100 internal I/O mappings
> - *
> - * We have the following mapping:
> - *      phys            virt
> - *      80000000        f8000000
> - *      90000000        fa000000
> - *      a0000000        fc000000
> - *      b0000000        fe000000
> - */
> -
> -#define VIO_BASE        0xf8000000	/* virtual start of IO space */
> -#define VIO_SHIFT       3		/* x = IO space shrink power */
> -#define PIO_START       0x80000000	/* physical start of IO space */
> -
> -#define io_p2v( x )             \
> -   IOMEM( (((x)&0x00ffffff) | (((x)&0x30000000)>>VIO_SHIFT)) + VIO_BASE )
> -#define io_v2p( x )             \
> -   ( (((x)&0x00ffffff) | (((x)&(0x30000000>>VIO_SHIFT))<<VIO_SHIFT)) + PIO_START )
> -
> -#define __MREG(x)	IOMEM(io_p2v(x))
> -
> -#ifndef __ASSEMBLY__
> -
> -# define __REG(x)	(*((volatile unsigned long __iomem *)io_p2v(x)))
> -# define __PREG(x)	(io_v2p((unsigned long)&(x)))
> -
> -#else
> -
> -# define __REG(x)	io_p2v(x)
> -# define __PREG(x)	io_v2p(x)
> -
> -#endif
> -
> -#include "SA-1100.h"
> -
> -#endif  /* _ASM_ARCH_HARDWARE_H */
> diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
> deleted file mode 100644
> index f4a41e665262..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/irqs.h
> +++ /dev/null
> @@ -1,101 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/mach-sa1100/include/mach/irqs.h
> - *
> - * Copyright (C) 1996 Russell King
> - * Copyright (C) 1998 Deborah Wallach (updates for SA1100/Brutus).
> - * Copyright (C) 1999 Nicolas Pitre (full GPIO irq isolation)
> - *
> - * 2001/11/14	RMK	Cleaned up and standardised a lot of the IRQs.
> - */
> -
> -#define	IRQ_GPIO0_SC		1
> -#define	IRQ_GPIO1_SC		2
> -#define	IRQ_GPIO2_SC		3
> -#define	IRQ_GPIO3_SC		4
> -#define	IRQ_GPIO4_SC		5
> -#define	IRQ_GPIO5_SC		6
> -#define	IRQ_GPIO6_SC		7
> -#define	IRQ_GPIO7_SC		8
> -#define	IRQ_GPIO8_SC		9
> -#define	IRQ_GPIO9_SC		10
> -#define	IRQ_GPIO10_SC		11
> -#define	IRQ_GPIO11_27		12
> -#define	IRQ_LCD			13	/* LCD controller           */
> -#define	IRQ_Ser0UDC		14	/* Ser. port 0 UDC          */
> -#define	IRQ_Ser1SDLC		15	/* Ser. port 1 SDLC         */
> -#define	IRQ_Ser1UART		16	/* Ser. port 1 UART         */
> -#define	IRQ_Ser2ICP		17	/* Ser. port 2 ICP          */
> -#define	IRQ_Ser3UART		18	/* Ser. port 3 UART         */
> -#define	IRQ_Ser4MCP		19	/* Ser. port 4 MCP          */
> -#define	IRQ_Ser4SSP		20	/* Ser. port 4 SSP          */
> -#define	IRQ_DMA0		21	/* DMA controller channel 0 */
> -#define	IRQ_DMA1		22	/* DMA controller channel 1 */
> -#define	IRQ_DMA2		23	/* DMA controller channel 2 */
> -#define	IRQ_DMA3		24	/* DMA controller channel 3 */
> -#define	IRQ_DMA4		25	/* DMA controller channel 4 */
> -#define	IRQ_DMA5		26	/* DMA controller channel 5 */
> -#define	IRQ_OST0		27	/* OS Timer match 0         */
> -#define	IRQ_OST1		28	/* OS Timer match 1         */
> -#define	IRQ_OST2		29	/* OS Timer match 2         */
> -#define	IRQ_OST3		30	/* OS Timer match 3         */
> -#define	IRQ_RTC1Hz		31	/* RTC 1 Hz clock           */
> -#define	IRQ_RTCAlrm		32	/* RTC Alarm                */
> -
> -#define	IRQ_GPIO0		33
> -#define	IRQ_GPIO1		34
> -#define	IRQ_GPIO2		35
> -#define	IRQ_GPIO3		36
> -#define	IRQ_GPIO4		37
> -#define	IRQ_GPIO5		38
> -#define	IRQ_GPIO6		39
> -#define	IRQ_GPIO7		40
> -#define	IRQ_GPIO8		41
> -#define	IRQ_GPIO9		42
> -#define	IRQ_GPIO10		43
> -#define	IRQ_GPIO11		44
> -#define	IRQ_GPIO12		45
> -#define	IRQ_GPIO13		46
> -#define	IRQ_GPIO14		47
> -#define	IRQ_GPIO15		48
> -#define	IRQ_GPIO16		49
> -#define	IRQ_GPIO17		50
> -#define	IRQ_GPIO18		51
> -#define	IRQ_GPIO19		52
> -#define	IRQ_GPIO20		53
> -#define	IRQ_GPIO21		54
> -#define	IRQ_GPIO22		55
> -#define	IRQ_GPIO23		56
> -#define	IRQ_GPIO24		57
> -#define	IRQ_GPIO25		58
> -#define	IRQ_GPIO26		59
> -#define	IRQ_GPIO27		60
> -
> -/*
> - * The next 16 interrupts are for board specific purposes.  Since
> - * the kernel can only run on one machine at a time, we can re-use
> - * these.  If you need more, increase IRQ_BOARD_END, but keep it
> - * within sensible limits.  IRQs 61 to 76 are available.
> - */
> -#define IRQ_BOARD_START		61
> -#define IRQ_BOARD_END		77
> -
> -/*
> - * Figure out the MAX IRQ number.
> - *
> - * Neponset, SA1111 and UCB1x00 are sparse IRQ aware, so can dynamically
> - * allocate their IRQs above NR_IRQS.
> - *
> - * LoCoMo has 4 additional IRQs, but is not sparse IRQ aware, and so has
> - * to be included in the NR_IRQS calculation.
> - */
> -#ifdef CONFIG_SHARP_LOCOMO
> -#define NR_IRQS_LOCOMO		4
> -#else
> -#define NR_IRQS_LOCOMO		0
> -#endif
> -
> -#ifndef NR_IRQS
> -#define NR_IRQS (IRQ_BOARD_START + NR_IRQS_LOCOMO)
> -#endif
> -#define SA1100_NR_IRQS (IRQ_BOARD_START + NR_IRQS_LOCOMO)
> diff --git a/arch/arm/mach-sa1100/include/mach/jornada720.h b/arch/arm/mach-sa1100/include/mach/jornada720.h
> deleted file mode 100644
> index bb22fcab8c6c..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/jornada720.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * arch/arm/mach-sa1100/include/mach/jornada720.h
> - *
> - * SSP/MCU communication definitions for HP Jornada 710/720/728
> - *
> - * Copyright 2007,2008 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
> - *  Copyright 2000 John Ankcorn <jca@lcs.mit.edu>
> - */
> -
> - /* HP Jornada 7xx microprocessor commands */
> -#define GETBATTERYDATA		0xc0
> -#define GETSCANKEYCODE		0x90
> -#define GETTOUCHSAMPLES		0xa0
> -#define GETCONTRAST		0xD0
> -#define SETCONTRAST		0xD1
> -#define GETBRIGHTNESS		0xD2
> -#define SETBRIGHTNESS		0xD3
> -#define CONTRASTOFF		0xD8
> -#define BRIGHTNESSOFF		0xD9
> -#define PWMOFF			0xDF
> -#define TXDUMMY			0x11
> -#define ERRORCODE		0x00
> -
> -extern void jornada_ssp_start(void);
> -extern void jornada_ssp_end(void);
> -extern int jornada_ssp_inout(u8 byte);
> -extern int jornada_ssp_byte(u8 byte);
> diff --git a/arch/arm/mach-sa1100/include/mach/memory.h b/arch/arm/mach-sa1100/include/mach/memory.h
> deleted file mode 100644
> index 3b19296f5062..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/memory.h
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/mach-sa1100/include/mach/memory.h
> - *
> - * Copyright (C) 1999-2000 Nicolas Pitre <nico@fluxnic.net>
> - */
> -
> -#ifndef __ASM_ARCH_MEMORY_H
> -#define __ASM_ARCH_MEMORY_H
> -
> -#include <linux/sizes.h>
> -
> -/*
> - * Because of the wide memory address space between physical RAM banks on the
> - * SA1100, it's much convenient to use Linux's SparseMEM support to implement
> - * our memory map representation.  Assuming all memory nodes have equal access
> - * characteristics, we then have generic discontiguous memory support.
> - *
> - * The sparsemem banks are matched with the physical memory bank addresses
> - * which are incidentally the same as virtual addresses.
> - * 
> - * 	node 0:  0xc0000000 - 0xc7ffffff
> - * 	node 1:  0xc8000000 - 0xcfffffff
> - * 	node 2:  0xd0000000 - 0xd7ffffff
> - * 	node 3:  0xd8000000 - 0xdfffffff
> - */
> -#define MAX_PHYSMEM_BITS	32
> -#define SECTION_SIZE_BITS	27
> -
> -/*
> - * Cache flushing area - SA1100 zero bank
> - */
> -#define FLUSH_BASE_PHYS		0xe0000000
> -#define FLUSH_BASE		0xf5000000
> -#define FLUSH_BASE_MINICACHE	0xf5100000
> -
> -#endif
> diff --git a/arch/arm/mach-sa1100/include/mach/mtd-xip.h b/arch/arm/mach-sa1100/include/mach/mtd-xip.h
> deleted file mode 100644
> index 85e6a79112d2..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/mtd-xip.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * MTD primitives for XIP support. Architecture specific functions
> - *
> - * Do not include this file directly. It's included from linux/mtd/xip.h
> - * 
> - * Author:	Nicolas Pitre
> - * Created:	Nov 2, 2004
> - * Copyright:	(C) 2004 MontaVista Software, Inc.
> - */
> -
> -#ifndef __ARCH_SA1100_MTD_XIP_H__
> -#define __ARCH_SA1100_MTD_XIP_H__
> -
> -#include <mach/hardware.h>
> -
> -#define xip_irqpending()	(ICIP & ICMR)
> -
> -/* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
> -#define xip_currtime()		readl_relaxed(OSCR)
> -#define xip_elapsed_since(x)	(signed)((readl_relaxed(OSCR) - (x)) / 4)
> -
> -#endif /* __ARCH_SA1100_MTD_XIP_H__ */
> diff --git a/arch/arm/mach-sa1100/include/mach/neponset.h b/arch/arm/mach-sa1100/include/mach/neponset.h
> deleted file mode 100644
> index 18411cfdfe8e..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/neponset.h
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/mach-sa1100/include/mach/neponset.h
> - *
> - * Created 2000/06/05 by Nicolas Pitre <nico@fluxnic.net>
> - *
> - * This file contains the hardware specific definitions for Assabet
> - * Only include this file from SA1100-specific files.
> - *
> - * 2000/05/23 John Dorsey <john+@cs.cmu.edu>
> - *      Definitions for Neponset added.
> - */
> -#ifndef __ASM_ARCH_NEPONSET_H
> -#define __ASM_ARCH_NEPONSET_H
> -
> -/*
> - * Neponset definitions: 
> - */
> -#define NCR_GP01_OFF		(1<<0)
> -#define NCR_TP_PWR_EN		(1<<1)
> -#define NCR_MS_PWR_EN		(1<<2)
> -#define NCR_ENET_OSC_EN		(1<<3)
> -#define NCR_SPI_KB_WK_UP	(1<<4)
> -#define NCR_A0VPP		(1<<5)
> -#define NCR_A1VPP		(1<<6)
> -
> -void neponset_ncr_frob(unsigned int, unsigned int);
> -#define neponset_ncr_set(v)	neponset_ncr_frob(0, v)
> -#define neponset_ncr_clear(v)	neponset_ncr_frob(v, 0)
> -
> -#endif
> diff --git a/arch/arm/mach-sa1100/include/mach/reset.h b/arch/arm/mach-sa1100/include/mach/reset.h
> deleted file mode 100644
> index a6723d45ae2a..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/reset.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_ARCH_RESET_H
> -#define __ASM_ARCH_RESET_H
> -
> -#include "hardware.h"
> -
> -#define RESET_STATUS_HARDWARE	(1 << 0)	/* Hardware Reset */
> -#define RESET_STATUS_WATCHDOG	(1 << 1)	/* Watchdog Reset */
> -#define RESET_STATUS_LOWPOWER	(1 << 2)	/* Exit from Low Power/Sleep */
> -#define RESET_STATUS_GPIO	(1 << 3)	/* GPIO Reset */
> -#define RESET_STATUS_ALL	(0xf)
> -
> -static inline void clear_reset_status(unsigned int mask)
> -{
> -	RCSR = mask;
> -}
> -
> -#endif /* __ASM_ARCH_RESET_H */
> diff --git a/arch/arm/mach-sa1100/include/mach/uncompress.h b/arch/arm/mach-sa1100/include/mach/uncompress.h
> deleted file mode 100644
> index f5eaa90a4576..000000000000
> --- a/arch/arm/mach-sa1100/include/mach/uncompress.h
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/mach-sa1100/include/mach/uncompress.h
> - *
> - * (C) 1999 Nicolas Pitre <nico@fluxnic.net>
> - *
> - * Reorganised to be machine independent.
> - */
> -
> -#include "hardware.h"
> -
> -#define IOMEM(x)	(x)
> -
> -/*
> - * The following code assumes the serial port has already been
> - * initialized by the bootloader.  We search for the first enabled
> - * port in the most probable order.  If you didn't setup a port in
> - * your bootloader then nothing will appear (which might be desired).
> - */
> -
> -#define UART(x)		(*(volatile unsigned long *)(serial_port + (x)))
> -
> -static inline void putc(int c)
> -{
> -	unsigned long serial_port;
> -
> -	do {
> -		serial_port = _Ser3UTCR0;
> -		if (UART(UTCR3) & UTCR3_TXE) break;
> -		serial_port = _Ser1UTCR0;
> -		if (UART(UTCR3) & UTCR3_TXE) break;
> -		serial_port = _Ser2UTCR0;
> -		if (UART(UTCR3) & UTCR3_TXE) break;
> -		return;
> -	} while (0);
> -
> -	/* wait for space in the UART's transmitter */
> -	while (!(UART(UTSR1) & UTSR1_TNF))
> -		barrier();
> -
> -	/* send the character out. */
> -	UART(UTDR) = c;
> -}
> -
> -static inline void flush(void)
> -{
> -}
> -
> -/*
> - * Nothing to do for these
> - */
> -#define arch_decomp_setup()
> diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
> deleted file mode 100644
> index e259298d9465..000000000000
> --- a/arch/arm/mach-sa1100/jornada720.c
> +++ /dev/null
> @@ -1,380 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * linux/arch/arm/mach-sa1100/jornada720.c
> - *
> - * HP Jornada720 init code
> - *
> - * Copyright (C) 2007 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
> - * Copyright (C) 2006 Filip Zyzniewski <filip.zyzniewski@tefnet.pl>
> - *  Copyright (C) 2005 Michael Gernoth <michael@gernoth.net>
> - */
> -
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/tty.h>
> -#include <linux/delay.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/platform_data/sa11x0-serial.h>
> -#include <linux/platform_device.h>
> -#include <linux/ioport.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/partitions.h>
> -#include <video/s1d13xxxfb.h>
> -
> -#include <asm/hardware/sa1111.h>
> -#include <asm/page.h>
> -#include <asm/mach-types.h>
> -#include <asm/setup.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/flash.h>
> -#include <asm/mach/map.h>
> -
> -#include <mach/hardware.h>
> -#include <mach/irqs.h>
> -
> -#include "generic.h"
> -
> -/*
> - * HP Documentation referred in this file:
> - * http://www.jlime.com/downloads/development/docs/jornada7xx/jornada720.txt
> - */
> -
> -/* line 110 of HP's doc */
> -#define TUCR_VAL	0x20000400
> -
> -/* memory space (line 52 of HP's doc) */
> -#define SA1111REGSTART	0x40000000
> -#define SA1111REGLEN	0x00002000
> -#define EPSONREGSTART	0x48000000
> -#define EPSONREGLEN	0x00100000
> -#define EPSONFBSTART	0x48200000
> -/* 512kB framebuffer */
> -#define EPSONFBLEN	512*1024
> -
> -static struct s1d13xxxfb_regval s1d13xxxfb_initregs[] = {
> -	/* line 344 of HP's doc */
> -	{0x0001,0x00},	// Miscellaneous Register
> -	{0x01FC,0x00},	// Display Mode Register
> -	{0x0004,0x00},	// General IO Pins Configuration Register 0
> -	{0x0005,0x00},	// General IO Pins Configuration Register 1
> -	{0x0008,0x00},	// General IO Pins Control Register 0
> -	{0x0009,0x00},	// General IO Pins Control Register 1
> -	{0x0010,0x01},	// Memory Clock Configuration Register
> -	{0x0014,0x11},	// LCD Pixel Clock Configuration Register
> -	{0x0018,0x01},	// CRT/TV Pixel Clock Configuration Register
> -	{0x001C,0x01},	// MediaPlug Clock Configuration Register
> -	{0x001E,0x01},	// CPU To Memory Wait State Select Register
> -	{0x0020,0x00},	// Memory Configuration Register
> -	{0x0021,0x45},	// DRAM Refresh Rate Register
> -	{0x002A,0x01},	// DRAM Timings Control Register 0
> -	{0x002B,0x03},	// DRAM Timings Control Register 1
> -	{0x0030,0x1c},	// Panel Type Register
> -	{0x0031,0x00},	// MOD Rate Register
> -	{0x0032,0x4F},	// LCD Horizontal Display Width Register
> -	{0x0034,0x07},	// LCD Horizontal Non-Display Period Register
> -	{0x0035,0x01},	// TFT FPLINE Start Position Register
> -	{0x0036,0x0B},	// TFT FPLINE Pulse Width Register
> -	{0x0038,0xEF},	// LCD Vertical Display Height Register 0
> -	{0x0039,0x00},	// LCD Vertical Display Height Register 1
> -	{0x003A,0x13},	// LCD Vertical Non-Display Period Register
> -	{0x003B,0x0B},	// TFT FPFRAME Start Position Register
> -	{0x003C,0x01},	// TFT FPFRAME Pulse Width Register
> -	{0x0040,0x05},	// LCD Display Mode Register (2:4bpp,3:8bpp,5:16bpp)
> -	{0x0041,0x00},	// LCD Miscellaneous Register
> -	{0x0042,0x00},	// LCD Display Start Address Register 0
> -	{0x0043,0x00},	// LCD Display Start Address Register 1
> -	{0x0044,0x00},	// LCD Display Start Address Register 2
> -	{0x0046,0x80},	// LCD Memory Address Offset Register 0
> -	{0x0047,0x02},	// LCD Memory Address Offset Register 1
> -	{0x0048,0x00},	// LCD Pixel Panning Register
> -	{0x004A,0x00},	// LCD Display FIFO High Threshold Control Register
> -	{0x004B,0x00},	// LCD Display FIFO Low Threshold Control Register
> -	{0x0050,0x4F},	// CRT/TV Horizontal Display Width Register
> -	{0x0052,0x13},	// CRT/TV Horizontal Non-Display Period Register
> -	{0x0053,0x01},	// CRT/TV HRTC Start Position Register
> -	{0x0054,0x0B},	// CRT/TV HRTC Pulse Width Register
> -	{0x0056,0xDF},	// CRT/TV Vertical Display Height Register 0
> -	{0x0057,0x01},	// CRT/TV Vertical Display Height Register 1
> -	{0x0058,0x2B},	// CRT/TV Vertical Non-Display Period Register
> -	{0x0059,0x09},	// CRT/TV VRTC Start Position Register
> -	{0x005A,0x01},	// CRT/TV VRTC Pulse Width Register
> -	{0x005B,0x10},	// TV Output Control Register
> -	{0x0060,0x03},	// CRT/TV Display Mode Register (2:4bpp,3:8bpp,5:16bpp)
> -	{0x0062,0x00},	// CRT/TV Display Start Address Register 0
> -	{0x0063,0x00},	// CRT/TV Display Start Address Register 1
> -	{0x0064,0x00},	// CRT/TV Display Start Address Register 2
> -	{0x0066,0x40},	// CRT/TV Memory Address Offset Register 0
> -	{0x0067,0x01},	// CRT/TV Memory Address Offset Register 1
> -	{0x0068,0x00},	// CRT/TV Pixel Panning Register
> -	{0x006A,0x00},	// CRT/TV Display FIFO High Threshold Control Register
> -	{0x006B,0x00},	// CRT/TV Display FIFO Low Threshold Control Register
> -	{0x0070,0x00},	// LCD Ink/Cursor Control Register
> -	{0x0071,0x01},	// LCD Ink/Cursor Start Address Register
> -	{0x0072,0x00},	// LCD Cursor X Position Register 0
> -	{0x0073,0x00},	// LCD Cursor X Position Register 1
> -	{0x0074,0x00},	// LCD Cursor Y Position Register 0
> -	{0x0075,0x00},	// LCD Cursor Y Position Register 1
> -	{0x0076,0x00},	// LCD Ink/Cursor Blue Color 0 Register
> -	{0x0077,0x00},	// LCD Ink/Cursor Green Color 0 Register
> -	{0x0078,0x00},	// LCD Ink/Cursor Red Color 0 Register
> -	{0x007A,0x1F},	// LCD Ink/Cursor Blue Color 1 Register
> -	{0x007B,0x3F},	// LCD Ink/Cursor Green Color 1 Register
> -	{0x007C,0x1F},	// LCD Ink/Cursor Red Color 1 Register
> -	{0x007E,0x00},	// LCD Ink/Cursor FIFO Threshold Register
> -	{0x0080,0x00},	// CRT/TV Ink/Cursor Control Register
> -	{0x0081,0x01},	// CRT/TV Ink/Cursor Start Address Register
> -	{0x0082,0x00},	// CRT/TV Cursor X Position Register 0
> -	{0x0083,0x00},	// CRT/TV Cursor X Position Register 1
> -	{0x0084,0x00},	// CRT/TV Cursor Y Position Register 0
> -	{0x0085,0x00},	// CRT/TV Cursor Y Position Register 1
> -	{0x0086,0x00},	// CRT/TV Ink/Cursor Blue Color 0 Register
> -	{0x0087,0x00},	// CRT/TV Ink/Cursor Green Color 0 Register
> -	{0x0088,0x00},	// CRT/TV Ink/Cursor Red Color 0 Register
> -	{0x008A,0x1F},	// CRT/TV Ink/Cursor Blue Color 1 Register
> -	{0x008B,0x3F},	// CRT/TV Ink/Cursor Green Color 1 Register
> -	{0x008C,0x1F},	// CRT/TV Ink/Cursor Red Color 1 Register
> -	{0x008E,0x00},	// CRT/TV Ink/Cursor FIFO Threshold Register
> -	{0x0100,0x00},	// BitBlt Control Register 0
> -	{0x0101,0x00},	// BitBlt Control Register 1
> -	{0x0102,0x00},	// BitBlt ROP Code/Color Expansion Register
> -	{0x0103,0x00},	// BitBlt Operation Register
> -	{0x0104,0x00},	// BitBlt Source Start Address Register 0
> -	{0x0105,0x00},	// BitBlt Source Start Address Register 1
> -	{0x0106,0x00},	// BitBlt Source Start Address Register 2
> -	{0x0108,0x00},	// BitBlt Destination Start Address Register 0
> -	{0x0109,0x00},	// BitBlt Destination Start Address Register 1
> -	{0x010A,0x00},	// BitBlt Destination Start Address Register 2
> -	{0x010C,0x00},	// BitBlt Memory Address Offset Register 0
> -	{0x010D,0x00},	// BitBlt Memory Address Offset Register 1
> -	{0x0110,0x00},	// BitBlt Width Register 0
> -	{0x0111,0x00},	// BitBlt Width Register 1
> -	{0x0112,0x00},	// BitBlt Height Register 0
> -	{0x0113,0x00},	// BitBlt Height Register 1
> -	{0x0114,0x00},	// BitBlt Background Color Register 0
> -	{0x0115,0x00},	// BitBlt Background Color Register 1
> -	{0x0118,0x00},	// BitBlt Foreground Color Register 0
> -	{0x0119,0x00},	// BitBlt Foreground Color Register 1
> -	{0x01E0,0x00},	// Look-Up Table Mode Register
> -	{0x01E2,0x00},	// Look-Up Table Address Register
> -	/* not sure, wouldn't like to mess with the driver */
> -	{0x01E4,0x00},	// Look-Up Table Data Register
> -	/* jornada doc says 0x00, but I trust the driver */
> -	{0x01F0,0x10},	// Power Save Configuration Register
> -	{0x01F1,0x00},	// Power Save Status Register
> -	{0x01F4,0x00},	// CPU-to-Memory Access Watchdog Timer Register
> -	{0x01FC,0x01},	// Display Mode Register(0x01:LCD, 0x02:CRT, 0x03:LCD&CRT)
> -};
> -
> -static struct s1d13xxxfb_pdata s1d13xxxfb_data = {
> -	.initregs		= s1d13xxxfb_initregs,
> -	.initregssize		= ARRAY_SIZE(s1d13xxxfb_initregs),
> -	.platform_init_video	= NULL
> -};
> -
> -static struct resource s1d13xxxfb_resources[] = {
> -	[0] = DEFINE_RES_MEM(EPSONFBSTART, EPSONFBLEN),
> -	[1] = DEFINE_RES_MEM(EPSONREGSTART, EPSONREGLEN),
> -};
> -
> -static struct platform_device s1d13xxxfb_device = {
> -	.name		= S1D_DEVICENAME,
> -	.id		= 0,
> -	.dev		= {
> -		.platform_data	= &s1d13xxxfb_data,
> -	},
> -	.num_resources	= ARRAY_SIZE(s1d13xxxfb_resources),
> -	.resource	= s1d13xxxfb_resources,
> -};
> -
> -static struct gpiod_lookup_table jornada_pcmcia_gpiod_table = {
> -	.dev_id = "1800",
> -	.table = {
> -		GPIO_LOOKUP("sa1111", 0, "s0-power", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("sa1111", 1, "s1-power", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("sa1111", 2, "s0-3v", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("sa1111", 3, "s1-3v", GPIO_ACTIVE_HIGH),
> -		{ },
> -	},
> -};
> -
> -static struct resource sa1111_resources[] = {
> -	[0] = DEFINE_RES_MEM(SA1111REGSTART, SA1111REGLEN),
> -	[1] = DEFINE_RES_IRQ(IRQ_GPIO1),
> -};
> -
> -static struct sa1111_platform_data sa1111_info = {
> -	.disable_devs	= SA1111_DEVID_PS2_MSE,
> -};
> -
> -static u64 sa1111_dmamask = 0xffffffffUL;
> -
> -static struct platform_device sa1111_device = {
> -	.name		= "sa1111",
> -	.id		= 0,
> -	.dev		= {
> -		.dma_mask = &sa1111_dmamask,
> -		.coherent_dma_mask = 0xffffffff,
> -		.platform_data = &sa1111_info,
> -	},
> -	.num_resources	= ARRAY_SIZE(sa1111_resources),
> -	.resource	= sa1111_resources,
> -};
> -
> -static struct platform_device jornada_ssp_device = {
> -	.name           = "jornada_ssp",
> -	.id             = -1,
> -};
> -
> -static struct resource jornada_kbd_resources[] = {
> -	DEFINE_RES_IRQ(IRQ_GPIO0),
> -};
> -
> -static struct platform_device jornada_kbd_device = {
> -	.name		= "jornada720_kbd",
> -	.id		= -1,
> -	.num_resources	= ARRAY_SIZE(jornada_kbd_resources),
> -	.resource	= jornada_kbd_resources,
> -};
> -
> -static struct gpiod_lookup_table jornada_ts_gpiod_table = {
> -	.dev_id		= "jornada_ts",
> -	.table		= {
> -		GPIO_LOOKUP("gpio", 9, "penup", GPIO_ACTIVE_HIGH),
> -	},
> -};
> -
> -static struct platform_device jornada_ts_device = {
> -	.name		= "jornada_ts",
> -	.id		= -1,
> -};
> -
> -static struct platform_device *devices[] __initdata = {
> -	&sa1111_device,
> -	&jornada_ssp_device,
> -	&s1d13xxxfb_device,
> -	&jornada_kbd_device,
> -	&jornada_ts_device,
> -};
> -
> -static int __init jornada720_init(void)
> -{
> -	int ret = -ENODEV;
> -
> -	if (machine_is_jornada720()) {
> -		/* we want to use gpio20 as input to drive the clock of our uart 3 */
> -		GPDR |= GPIO_GPIO20;	/* Clear gpio20 pin as input */
> -		TUCR = TUCR_VAL;
> -		GPSR = GPIO_GPIO20;	/* start gpio20 pin */
> -		udelay(1);
> -		GPCR = GPIO_GPIO20;	/* stop gpio20 */
> -		udelay(1);
> -		GPSR = GPIO_GPIO20;	/* restart gpio20 */
> -		udelay(20);		/* give it some time to restart */
> -
> -		gpiod_add_lookup_table(&jornada_ts_gpiod_table);
> -		gpiod_add_lookup_table(&jornada_pcmcia_gpiod_table);
> -
> -		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
> -	}
> -
> -	return ret;
> -}
> -
> -arch_initcall(jornada720_init);
> -
> -static struct map_desc jornada720_io_desc[] __initdata = {
> -	{	/* Epson registers */
> -		.virtual	= 0xf0000000,
> -		.pfn		= __phys_to_pfn(EPSONREGSTART),
> -		.length		= EPSONREGLEN,
> -		.type		= MT_DEVICE
> -	}, {	/* Epson frame buffer */
> -		.virtual	= 0xf1000000,
> -		.pfn		= __phys_to_pfn(EPSONFBSTART),
> -		.length		= EPSONFBLEN,
> -		.type		= MT_DEVICE
> -	}
> -};
> -
> -static void __init jornada720_map_io(void)
> -{
> -	sa1100_map_io();
> -	iotable_init(jornada720_io_desc, ARRAY_SIZE(jornada720_io_desc));
> -
> -	sa1100_register_uart(0, 3);
> -	sa1100_register_uart(1, 1);
> -}
> -
> -static struct mtd_partition jornada720_partitions[] = {
> -	{
> -		.name		= "JORNADA720 boot firmware",
> -		.size		= 0x00040000,
> -		.offset		= 0,
> -		.mask_flags	= MTD_WRITEABLE, /* force read-only */
> -	}, {
> -		.name		= "JORNADA720 kernel",
> -		.size		= 0x000c0000,
> -		.offset		= 0x00040000,
> -	}, {
> -		.name		= "JORNADA720 params",
> -		.size		= 0x00040000,
> -		.offset		= 0x00100000,
> -	}, {
> -		.name		= "JORNADA720 initrd",
> -		.size		= 0x00100000,
> -		.offset		= 0x00140000,
> -	}, {
> -		.name		= "JORNADA720 root cramfs",
> -		.size		= 0x00300000,
> -		.offset		= 0x00240000,
> -	}, {
> -		.name		= "JORNADA720 usr cramfs",
> -		.size		= 0x00800000,
> -		.offset		= 0x00540000,
> -	}, {
> -		.name		= "JORNADA720 usr local",
> -		.size		= 0, /* will expand to the end of the flash */
> -		.offset		= 0x00d00000,
> -	}
> -};
> -
> -static void jornada720_set_vpp(int vpp)
> -{
> -	if (vpp)
> -		/* enabling flash write (line 470 of HP's doc) */
> -		PPSR |= PPC_LDD7;
> -	else
> -		/* disabling flash write (line 470 of HP's doc) */
> -		PPSR &= ~PPC_LDD7;
> -	PPDR |= PPC_LDD7;
> -}
> -
> -static struct flash_platform_data jornada720_flash_data = {
> -	.map_name	= "cfi_probe",
> -	.set_vpp	= jornada720_set_vpp,
> -	.parts		= jornada720_partitions,
> -	.nr_parts	= ARRAY_SIZE(jornada720_partitions),
> -};
> -
> -static struct resource jornada720_flash_resource =
> -	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M);
> -
> -static void __init jornada720_mach_init(void)
> -{
> -	sa11x0_register_mtd(&jornada720_flash_data, &jornada720_flash_resource, 1);
> -}
> -
> -MACHINE_START(JORNADA720, "HP Jornada 720")
> -	/* Maintainer: Kristoffer Ericson <Kristoffer.Ericson@gmail.com> */
> -	.atag_offset	= 0x100,
> -	.map_io		= jornada720_map_io,
> -	.nr_irqs	= SA1100_NR_IRQS,
> -	.init_irq	= sa1100_init_irq,
> -	.init_time	= sa1100_timer_init,
> -	.init_machine	= jornada720_mach_init,
> -	.init_late	= sa11x0_init_late,
> -#ifdef CONFIG_SA1111
> -	.dma_zone_size	= SZ_1M,
> -#endif
> -	.restart	= sa11x0_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
> deleted file mode 100644
> index d94810217095..000000000000
> --- a/arch/arm/mach-sa1100/jornada720_ssp.c
> +++ /dev/null
> @@ -1,202 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  arch/arm/mac-sa1100/jornada720_ssp.c
> - *
> - *  Copyright (C) 2006/2007 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
> - *   Copyright (C) 2006 Filip Zyzniewski <filip.zyzniewski@tefnet.pl>
> - *
> - *  SSP driver for the HP Jornada 710/720/728
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/errno.h>
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/sched.h>
> -#include <linux/io.h>
> -
> -#include <mach/hardware.h>
> -#include <mach/jornada720.h>
> -#include <asm/hardware/ssp.h>
> -
> -static DEFINE_SPINLOCK(jornada_ssp_lock);
> -static unsigned long jornada_ssp_flags;
> -
> -/**
> - * jornada_ssp_reverse - reverses input byte
> - * @byte: input byte to reverse
> - *
> - * we need to reverse all data we receive from the mcu due to its physical location
> - * returns : 01110111 -> 11101110
> - */
> -inline u8 jornada_ssp_reverse(u8 byte)
> -{
> -	return
> -		((0x80 & byte) >> 7) |
> -		((0x40 & byte) >> 5) |
> -		((0x20 & byte) >> 3) |
> -		((0x10 & byte) >> 1) |
> -		((0x08 & byte) << 1) |
> -		((0x04 & byte) << 3) |
> -		((0x02 & byte) << 5) |
> -		((0x01 & byte) << 7);
> -};
> -EXPORT_SYMBOL(jornada_ssp_reverse);
> -
> -/**
> - * jornada_ssp_byte - waits for ready ssp bus and sends byte
> - * @byte: input byte to transmit
> - *
> - * waits for fifo buffer to clear and then transmits, if it doesn't then we will
> - * timeout after <timeout> rounds. Needs mcu running before its called.
> - *
> - * returns : %mcu output on success
> - *	   : %-ETIMEDOUT on timeout
> - */
> -int jornada_ssp_byte(u8 byte)
> -{
> -	int timeout = 400000;
> -	u16 ret;
> -
> -	while ((GPLR & GPIO_GPIO10)) {
> -		if (!--timeout) {
> -			printk(KERN_WARNING "SSP: timeout while waiting for transmit\n");
> -			return -ETIMEDOUT;
> -		}
> -		cpu_relax();
> -	}
> -
> -	ret = jornada_ssp_reverse(byte) << 8;
> -
> -	ssp_write_word(ret);
> -	ssp_read_word(&ret);
> -
> -	return jornada_ssp_reverse(ret);
> -};
> -EXPORT_SYMBOL(jornada_ssp_byte);
> -
> -/**
> - * jornada_ssp_inout - decide if input is command or trading byte
> - * @byte: input byte to send (may be %TXDUMMY)
> - *
> - * returns : (jornada_ssp_byte(byte)) on success
> - *         : %-ETIMEDOUT on timeout failure
> - */
> -int jornada_ssp_inout(u8 byte)
> -{
> -	int ret, i;
> -
> -	/* true means command byte */
> -	if (byte != TXDUMMY) {
> -		ret = jornada_ssp_byte(byte);
> -		/* Proper return to commands is TxDummy */
> -		if (ret != TXDUMMY) {
> -			for (i = 0; i < 256; i++)/* flushing bus */
> -				if (jornada_ssp_byte(TXDUMMY) == -1)
> -					break;
> -			return -ETIMEDOUT;
> -		}
> -	} else /* Exchange TxDummy for data */
> -		ret = jornada_ssp_byte(TXDUMMY);
> -
> -	return ret;
> -};
> -EXPORT_SYMBOL(jornada_ssp_inout);
> -
> -/**
> - * jornada_ssp_start - enable mcu
> - *
> - */
> -void jornada_ssp_start(void)
> -{
> -	spin_lock_irqsave(&jornada_ssp_lock, jornada_ssp_flags);
> -	GPCR = GPIO_GPIO25;
> -	udelay(50);
> -	return;
> -};
> -EXPORT_SYMBOL(jornada_ssp_start);
> -
> -/**
> - * jornada_ssp_end - disable mcu and turn off lock
> - *
> - */
> -void jornada_ssp_end(void)
> -{
> -	GPSR = GPIO_GPIO25;
> -	spin_unlock_irqrestore(&jornada_ssp_lock, jornada_ssp_flags);
> -	return;
> -};
> -EXPORT_SYMBOL(jornada_ssp_end);
> -
> -static int jornada_ssp_probe(struct platform_device *dev)
> -{
> -	int ret;
> -
> -	GPSR = GPIO_GPIO25;
> -
> -	ret = ssp_init();
> -
> -	/* worked fine, lets not bother with anything else */
> -	if (!ret) {
> -		printk(KERN_INFO "SSP: device initialized with irq\n");
> -		return ret;
> -	}
> -
> -	printk(KERN_WARNING "SSP: initialization failed, trying non-irq solution \n");
> -
> -	/* init of Serial 4 port */
> -	Ser4MCCR0 = 0;
> -	Ser4SSCR0 = 0x0387;
> -	Ser4SSCR1 = 0x18;
> -
> -	/* clear out any left over data */
> -	ssp_flush();
> -
> -	/* enable MCU */
> -	jornada_ssp_start();
> -
> -	/* see if return value makes sense */
> -	ret = jornada_ssp_inout(GETBRIGHTNESS);
> -
> -	/* seems like it worked, just feed it with TxDummy to get rid of data */
> -	if (ret == TXDUMMY)
> -		jornada_ssp_inout(TXDUMMY);
> -
> -	jornada_ssp_end();
> -
> -	/* failed, lets just kill everything */
> -	if (ret == -ETIMEDOUT) {
> -		printk(KERN_WARNING "SSP: attempts failed, bailing\n");
> -		ssp_exit();
> -		return -ENODEV;
> -	}
> -
> -	/* all fine */
> -	printk(KERN_INFO "SSP: device initialized\n");
> -	return 0;
> -};
> -
> -static void jornada_ssp_remove(struct platform_device *dev)
> -{
> -	/* Note that this doesn't actually remove the driver, since theres nothing to remove
> -	 * It just makes sure everything is turned off */
> -	GPSR = GPIO_GPIO25;
> -	ssp_exit();
> -};
> -
> -struct platform_driver jornadassp_driver = {
> -	.probe	= jornada_ssp_probe,
> -	.remove = jornada_ssp_remove,
> -	.driver	= {
> -		.name	= "jornada_ssp",
> -	},
> -};
> -
> -static int __init jornada_ssp_init(void)
> -{
> -	return platform_driver_register(&jornadassp_driver);
> -}
> -
> -module_init(jornada_ssp_init);
> diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
> deleted file mode 100644
> index 9e8a3284a6cf..000000000000
> --- a/arch/arm/mach-sa1100/neponset.c
> +++ /dev/null
> @@ -1,438 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * linux/arch/arm/mach-sa1100/neponset.c
> - */
> -#include <linux/err.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/gpio/gpio-reg.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/init.h>
> -#include <linux/ioport.h>
> -#include <linux/irq.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/pm.h>
> -#include <linux/serial_core.h>
> -#include <linux/slab.h>
> -#include <linux/smc91x.h>
> -
> -#include <asm/mach-types.h>
> -#include <asm/mach/map.h>
> -#include <asm/hardware/sa1111.h>
> -#include <linux/sizes.h>
> -
> -#include <mach/hardware.h>
> -#include <mach/assabet.h>
> -#include <mach/neponset.h>
> -#include <mach/irqs.h>
> -
> -#define NEP_IRQ_SMC91X	0
> -#define NEP_IRQ_USAR	1
> -#define NEP_IRQ_SA1111	2
> -#define NEP_IRQ_NR	3
> -
> -#define WHOAMI		0x00
> -#define LEDS		0x10
> -#define SWPK		0x20
> -#define IRR		0x24
> -#define KP_Y_IN		0x80
> -#define KP_X_OUT	0x90
> -#define NCR_0		0xa0
> -#define MDM_CTL_0	0xb0
> -#define MDM_CTL_1	0xb4
> -#define AUD_CTL		0xc0
> -
> -#define IRR_ETHERNET	(1 << 0)
> -#define IRR_USAR	(1 << 1)
> -#define IRR_SA1111	(1 << 2)
> -
> -#define NCR_NGPIO	7
> -#define MDM_CTL0_NGPIO	4
> -#define MDM_CTL1_NGPIO	6
> -#define AUD_NGPIO	2
> -
> -extern void sa1110_mb_disable(void);
> -
> -#define to_neponset_gpio_chip(x) container_of(x, struct neponset_gpio_chip, gc)
> -
> -static const char *neponset_ncr_names[] = {
> -	"gp01_off", "tp_power", "ms_power", "enet_osc",
> -	"spi_kb_wk_up", "a0vpp", "a1vpp"
> -};
> -
> -static const char *neponset_mdmctl0_names[] = {
> -	"rts3", "dtr3", "rts1", "dtr1",
> -};
> -
> -static const char *neponset_mdmctl1_names[] = {
> -	"cts3", "dsr3", "dcd3", "cts1", "dsr1", "dcd1"
> -};
> -
> -static const char *neponset_aud_names[] = {
> -	"sel_1341", "mute_1341",
> -};
> -
> -struct neponset_drvdata {
> -	void __iomem *base;
> -	struct platform_device *sa1111;
> -	struct platform_device *smc91x;
> -	unsigned irq_base;
> -	struct gpio_chip *gpio[4];
> -};
> -
> -static struct gpiod_lookup_table neponset_uart1_gpio_table = {
> -	.dev_id = "sa11x0-uart.1",
> -	.table = {
> -		GPIO_LOOKUP("neponset-mdm-ctl0", 2, "rts", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("neponset-mdm-ctl0", 3, "dtr", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("neponset-mdm-ctl1", 3, "cts", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("neponset-mdm-ctl1", 4, "dsr", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("neponset-mdm-ctl1", 5, "dcd", GPIO_ACTIVE_LOW),
> -		{ },
> -	},
> -};
> -
> -static struct gpiod_lookup_table neponset_uart3_gpio_table = {
> -	.dev_id = "sa11x0-uart.3",
> -	.table = {
> -		GPIO_LOOKUP("neponset-mdm-ctl0", 0, "rts", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("neponset-mdm-ctl0", 1, "dtr", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("neponset-mdm-ctl1", 0, "cts", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("neponset-mdm-ctl1", 1, "dsr", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("neponset-mdm-ctl1", 2, "dcd", GPIO_ACTIVE_LOW),
> -		{ },
> -	},
> -};
> -
> -static struct gpiod_lookup_table neponset_pcmcia_table = {
> -	.dev_id = "1800",
> -	.table = {
> -		GPIO_LOOKUP("sa1111", 1, "a0vcc", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("sa1111", 0, "a1vcc", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("neponset-ncr", 5, "a0vpp", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("neponset-ncr", 6, "a1vpp", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("sa1111", 2, "b0vcc", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("sa1111", 3, "b1vcc", GPIO_ACTIVE_HIGH),
> -		{ },
> -	},
> -};
> -
> -static struct neponset_drvdata *nep;
> -
> -void neponset_ncr_frob(unsigned int mask, unsigned int val)
> -{
> -	struct neponset_drvdata *n = nep;
> -	unsigned long m = mask, v = val;
> -
> -	if (nep)
> -		n->gpio[0]->set_multiple(n->gpio[0], &m, &v);
> -	else
> -		WARN(1, "nep unset\n");
> -}
> -EXPORT_SYMBOL(neponset_ncr_frob);
> -
> -/*
> - * Install handler for Neponset IRQ.  Note that we have to loop here
> - * since the ETHERNET and USAR IRQs are level based, and we need to
> - * ensure that the IRQ signal is deasserted before returning.  This
> - * is rather unfortunate.
> - */
> -static void neponset_irq_handler(struct irq_desc *desc)
> -{
> -	struct neponset_drvdata *d = irq_desc_get_handler_data(desc);
> -	unsigned int irr;
> -
> -	while (1) {
> -		/*
> -		 * Acknowledge the parent IRQ.
> -		 */
> -		desc->irq_data.chip->irq_ack(&desc->irq_data);
> -
> -		/*
> -		 * Read the interrupt reason register.  Let's have all
> -		 * active IRQ bits high.  Note: there is a typo in the
> -		 * Neponset user's guide for the SA1111 IRR level.
> -		 */
> -		irr = readb_relaxed(d->base + IRR);
> -		irr ^= IRR_ETHERNET | IRR_USAR;
> -
> -		if ((irr & (IRR_ETHERNET | IRR_USAR | IRR_SA1111)) == 0)
> -			break;
> -
> -		/*
> -		 * Since there is no individual mask, we have to
> -		 * mask the parent IRQ.  This is safe, since we'll
> -		 * recheck the register for any pending IRQs.
> -		 */
> -		if (irr & (IRR_ETHERNET | IRR_USAR)) {
> -			desc->irq_data.chip->irq_mask(&desc->irq_data);
> -
> -			/*
> -			 * Ack the interrupt now to prevent re-entering
> -			 * this neponset handler.  Again, this is safe
> -			 * since we'll check the IRR register prior to
> -			 * leaving.
> -			 */
> -			desc->irq_data.chip->irq_ack(&desc->irq_data);
> -
> -			if (irr & IRR_ETHERNET)
> -				generic_handle_irq(d->irq_base + NEP_IRQ_SMC91X);
> -
> -			if (irr & IRR_USAR)
> -				generic_handle_irq(d->irq_base + NEP_IRQ_USAR);
> -
> -			desc->irq_data.chip->irq_unmask(&desc->irq_data);
> -		}
> -
> -		if (irr & IRR_SA1111)
> -			generic_handle_irq(d->irq_base + NEP_IRQ_SA1111);
> -	}
> -}
> -
> -/* Yes, we really do not have any kind of masking or unmasking */
> -static void nochip_noop(struct irq_data *irq)
> -{
> -}
> -
> -static struct irq_chip nochip = {
> -	.name = "neponset",
> -	.irq_ack = nochip_noop,
> -	.irq_mask = nochip_noop,
> -	.irq_unmask = nochip_noop,
> -};
> -
> -static int neponset_init_gpio(struct gpio_chip **gcp,
> -	struct device *dev, const char *label, void __iomem *reg,
> -	unsigned num, bool in, const char *const * names)
> -{
> -	struct gpio_chip *gc;
> -
> -	gc = gpio_reg_init(dev, reg, -1, num, label, in ? 0xffffffff : 0,
> -			   readl_relaxed(reg), names, NULL, NULL);
> -	if (IS_ERR(gc))
> -		return PTR_ERR(gc);
> -
> -	*gcp = gc;
> -
> -	return 0;
> -}
> -
> -static struct sa1111_platform_data sa1111_info = {
> -	.disable_devs	= SA1111_DEVID_PS2_MSE,
> -};
> -
> -static int neponset_probe(struct platform_device *dev)
> -{
> -	struct neponset_drvdata *d;
> -	struct resource *nep_res, *sa1111_res, *smc91x_res;
> -	struct resource sa1111_resources[] = {
> -		DEFINE_RES_MEM(0x40000000, SZ_8K),
> -		{ .flags = IORESOURCE_IRQ },
> -	};
> -	struct platform_device_info sa1111_devinfo = {
> -		.parent = &dev->dev,
> -		.name = "sa1111",
> -		.id = 0,
> -		.res = sa1111_resources,
> -		.num_res = ARRAY_SIZE(sa1111_resources),
> -		.data = &sa1111_info,
> -		.size_data = sizeof(sa1111_info),
> -		.dma_mask = 0xffffffffUL,
> -	};
> -	struct resource smc91x_resources[] = {
> -		DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS,
> -			0x02000000, "smc91x-regs"),
> -		DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS + 0x02000000,
> -			0x02000000, "smc91x-attrib"),
> -		{ .flags = IORESOURCE_IRQ },
> -	};
> -	struct smc91x_platdata smc91x_platdata = {
> -		.flags = SMC91X_USE_8BIT | SMC91X_IO_SHIFT_2 | SMC91X_NOWAIT,
> -	};
> -	struct platform_device_info smc91x_devinfo = {
> -		.parent = &dev->dev,
> -		.name = "smc91x",
> -		.id = 0,
> -		.res = smc91x_resources,
> -		.num_res = ARRAY_SIZE(smc91x_resources),
> -		.data = &smc91x_platdata,
> -		.size_data = sizeof(smc91x_platdata),
> -	};
> -	int ret, irq;
> -
> -	if (nep)
> -		return -EBUSY;
> -
> -	irq = ret = platform_get_irq(dev, 0);
> -	if (ret < 0)
> -		goto err_alloc;
> -
> -	nep_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> -	smc91x_res = platform_get_resource(dev, IORESOURCE_MEM, 1);
> -	sa1111_res = platform_get_resource(dev, IORESOURCE_MEM, 2);
> -	if (!nep_res || !smc91x_res || !sa1111_res) {
> -		ret = -ENXIO;
> -		goto err_alloc;
> -	}
> -
> -	d = kzalloc_obj(*d);
> -	if (!d) {
> -		ret = -ENOMEM;
> -		goto err_alloc;
> -	}
> -
> -	d->base = ioremap(nep_res->start, SZ_4K);
> -	if (!d->base) {
> -		ret = -ENOMEM;
> -		goto err_ioremap;
> -	}
> -
> -	if (readb_relaxed(d->base + WHOAMI) != 0x11) {
> -		dev_warn(&dev->dev, "Neponset board detected, but wrong ID: %02x\n",
> -			 readb_relaxed(d->base + WHOAMI));
> -		ret = -ENODEV;
> -		goto err_id;
> -	}
> -
> -	ret = irq_alloc_descs(-1, IRQ_BOARD_START, NEP_IRQ_NR, -1);
> -	if (ret <= 0) {
> -		dev_err(&dev->dev, "unable to allocate %u irqs: %d\n",
> -			NEP_IRQ_NR, ret);
> -		if (ret == 0)
> -			ret = -ENOMEM;
> -		goto err_irq_alloc;
> -	}
> -
> -	d->irq_base = ret;
> -
> -	irq_set_chip_and_handler(d->irq_base + NEP_IRQ_SMC91X, &nochip,
> -		handle_simple_irq);
> -	irq_clear_status_flags(d->irq_base + NEP_IRQ_SMC91X, IRQ_NOREQUEST | IRQ_NOPROBE);
> -	irq_set_chip_and_handler(d->irq_base + NEP_IRQ_USAR, &nochip,
> -		handle_simple_irq);
> -	irq_clear_status_flags(d->irq_base + NEP_IRQ_USAR, IRQ_NOREQUEST | IRQ_NOPROBE);
> -	irq_set_chip(d->irq_base + NEP_IRQ_SA1111, &nochip);
> -
> -	irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
> -	irq_set_chained_handler_and_data(irq, neponset_irq_handler, d);
> -
> -	/* Disable GPIO 0/1 drivers so the buttons work on the Assabet */
> -	writeb_relaxed(NCR_GP01_OFF, d->base + NCR_0);
> -
> -	neponset_init_gpio(&d->gpio[0], &dev->dev, "neponset-ncr",
> -			   d->base + NCR_0, NCR_NGPIO, false,
> -			   neponset_ncr_names);
> -	neponset_init_gpio(&d->gpio[1], &dev->dev, "neponset-mdm-ctl0",
> -			   d->base + MDM_CTL_0, MDM_CTL0_NGPIO, false,
> -			   neponset_mdmctl0_names);
> -	neponset_init_gpio(&d->gpio[2], &dev->dev, "neponset-mdm-ctl1",
> -			   d->base + MDM_CTL_1, MDM_CTL1_NGPIO, true,
> -			   neponset_mdmctl1_names);
> -	neponset_init_gpio(&d->gpio[3], &dev->dev, "neponset-aud-ctl",
> -			   d->base + AUD_CTL, AUD_NGPIO, false,
> -			   neponset_aud_names);
> -
> -	gpiod_add_lookup_table(&neponset_uart1_gpio_table);
> -	gpiod_add_lookup_table(&neponset_uart3_gpio_table);
> -	gpiod_add_lookup_table(&neponset_pcmcia_table);
> -
> -	/*
> -	 * We would set IRQ_GPIO25 to be a wake-up IRQ, but unfortunately
> -	 * something on the Neponset activates this IRQ on sleep (eth?)
> -	 */
> -#if 0
> -	enable_irq_wake(irq);
> -#endif
> -
> -	dev_info(&dev->dev, "Neponset daughter board, providing IRQ%u-%u\n",
> -		 d->irq_base, d->irq_base + NEP_IRQ_NR - 1);
> -	nep = d;
> -
> -	/* Ensure that the memory bus request/grant signals are setup */
> -	sa1110_mb_disable();
> -
> -	sa1111_resources[0].parent = sa1111_res;
> -	sa1111_resources[1].start = d->irq_base + NEP_IRQ_SA1111;
> -	sa1111_resources[1].end = d->irq_base + NEP_IRQ_SA1111;
> -	d->sa1111 = platform_device_register_full(&sa1111_devinfo);
> -
> -	smc91x_resources[0].parent = smc91x_res;
> -	smc91x_resources[1].parent = smc91x_res;
> -	smc91x_resources[2].start = d->irq_base + NEP_IRQ_SMC91X;
> -	smc91x_resources[2].end = d->irq_base + NEP_IRQ_SMC91X;
> -	d->smc91x = platform_device_register_full(&smc91x_devinfo);
> -
> -	platform_set_drvdata(dev, d);
> -
> -	return 0;
> -
> - err_irq_alloc:
> - err_id:
> -	iounmap(d->base);
> - err_ioremap:
> -	kfree(d);
> - err_alloc:
> -	return ret;
> -}
> -
> -static void neponset_remove(struct platform_device *dev)
> -{
> -	struct neponset_drvdata *d = platform_get_drvdata(dev);
> -	int irq = platform_get_irq(dev, 0);
> -
> -	if (!IS_ERR(d->sa1111))
> -		platform_device_unregister(d->sa1111);
> -	if (!IS_ERR(d->smc91x))
> -		platform_device_unregister(d->smc91x);
> -
> -	gpiod_remove_lookup_table(&neponset_pcmcia_table);
> -	gpiod_remove_lookup_table(&neponset_uart3_gpio_table);
> -	gpiod_remove_lookup_table(&neponset_uart1_gpio_table);
> -
> -	irq_set_chained_handler(irq, NULL);
> -	irq_free_descs(d->irq_base, NEP_IRQ_NR);
> -	nep = NULL;
> -	iounmap(d->base);
> -	kfree(d);
> -}
> -
> -#ifdef CONFIG_PM_SLEEP
> -static int neponset_resume(struct device *dev)
> -{
> -	struct neponset_drvdata *d = dev_get_drvdata(dev);
> -	int i, ret = 0;
> -
> -	for (i = 0; i < ARRAY_SIZE(d->gpio); i++) {
> -		ret = gpio_reg_resume(d->gpio[i]);
> -		if (ret)
> -			break;
> -	}
> -
> -	return ret;
> -}
> -
> -static const struct dev_pm_ops neponset_pm_ops = {
> -	.resume_noirq = neponset_resume,
> -	.restore_noirq = neponset_resume,
> -};
> -#define PM_OPS &neponset_pm_ops
> -#else
> -#define PM_OPS NULL
> -#endif
> -
> -static struct platform_driver neponset_device_driver = {
> -	.probe		= neponset_probe,
> -	.remove		= neponset_remove,
> -	.driver		= {
> -		.name	= "neponset",
> -		.pm	= PM_OPS,
> -	},
> -};
> -
> -static int __init neponset_init(void)
> -{
> -	return platform_driver_register(&neponset_device_driver);
> -}
> -
> -subsys_initcall(neponset_init);
> diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
> deleted file mode 100644
> index 9495fc109baa..000000000000
> --- a/arch/arm/mach-sa1100/pm.c
> +++ /dev/null
> @@ -1,128 +0,0 @@
> -/*
> - * SA1100 Power Management Routines
> - *
> - * Copyright (c) 2001 Cliff Brake <cbrake@accelent.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License.
> - *
> - * History:
> - *
> - * 2001-02-06:	Cliff Brake         Initial code
> - *
> - * 2001-02-25:	Sukjae Cho <sjcho@east.isi.edu> &
> - * 		Chester Kuo <chester@linux.org.tw>
> - * 			Save more value for the resume function! Support
> - * 			Bitsy/Assabet/Freebird board
> - *
> - * 2001-08-29:	Nicolas Pitre <nico@fluxnic.net>
> - * 			Cleaned up, pushed platform dependent stuff
> - * 			in the platform specific files.
> - *
> - * 2002-05-27:	Nicolas Pitre	Killed sleep.h and the kmalloced save array.
> - * 				Storage is local on the stack now.
> - */
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/suspend.h>
> -#include <linux/errno.h>
> -#include <linux/time.h>
> -
> -#include <mach/hardware.h>
> -#include <asm/page.h>
> -#include <asm/suspend.h>
> -#include <asm/mach/time.h>
> -
> -#include "generic.h"
> -
> -extern int sa1100_finish_suspend(unsigned long);
> -
> -#define SAVE(x)		sleep_save[SLEEP_SAVE_##x] = x
> -#define RESTORE(x)	x = sleep_save[SLEEP_SAVE_##x]
> -
> -/*
> - * List of global SA11x0 peripheral registers to preserve.
> - * More ones like CP and general purpose register values are preserved
> - * on the stack and then the stack pointer is stored last in sleep.S.
> - */
> -enum {	SLEEP_SAVE_GPDR, SLEEP_SAVE_GAFR,
> -	SLEEP_SAVE_PPDR, SLEEP_SAVE_PPSR, SLEEP_SAVE_PPAR, SLEEP_SAVE_PSDR,
> -
> -	SLEEP_SAVE_Ser1SDCR0,
> -
> -	SLEEP_SAVE_COUNT
> -};
> -
> -
> -static int sa11x0_pm_enter(suspend_state_t state)
> -{
> -	unsigned long gpio, sleep_save[SLEEP_SAVE_COUNT];
> -
> -	gpio = GPLR;
> -
> -	/* save vital registers */
> -	SAVE(GPDR);
> -	SAVE(GAFR);
> -
> -	SAVE(PPDR);
> -	SAVE(PPSR);
> -	SAVE(PPAR);
> -	SAVE(PSDR);
> -
> -	SAVE(Ser1SDCR0);
> -
> -	/* Clear previous reset status */
> -	RCSR = RCSR_HWR | RCSR_SWR | RCSR_WDR | RCSR_SMR;
> -
> -	/* set resume return address */
> -	PSPR = __pa_symbol(cpu_resume);
> -
> -	/* go zzz */
> -	cpu_suspend(0, sa1100_finish_suspend);
> -
> -	/*
> -	 * Ensure not to come back here if it wasn't intended
> -	 */
> -	RCSR = RCSR_SMR;
> -	PSPR = 0;
> -
> -	/*
> -	 * Ensure interrupt sources are disabled; we will re-init
> -	 * the interrupt subsystem via the device manager.
> -	 */
> -	ICLR = 0;
> -	ICCR = 1;
> -	ICMR = 0;
> -
> -	/* restore registers */
> -	RESTORE(GPDR);
> -	RESTORE(GAFR);
> -
> -	RESTORE(PPDR);
> -	RESTORE(PPSR);
> -	RESTORE(PPAR);
> -	RESTORE(PSDR);
> -
> -	RESTORE(Ser1SDCR0);
> -
> -	GPSR = gpio;
> -	GPCR = ~gpio;
> -
> -	/*
> -	 * Clear the peripheral sleep-hold bit.
> -	 */
> -	PSSR = PSSR_PH;
> -
> -	return 0;
> -}
> -
> -static const struct platform_suspend_ops sa11x0_pm_ops = {
> -	.enter		= sa11x0_pm_enter,
> -	.valid		= suspend_valid_only_mem,
> -};
> -
> -int __init sa11x0_pm_init(void)
> -{
> -	suspend_set_ops(&sa11x0_pm_ops);
> -	return 0;
> -}
> diff --git a/arch/arm/mach-sa1100/sleep.S b/arch/arm/mach-sa1100/sleep.S
> deleted file mode 100644
> index 85863741ef8b..000000000000
> --- a/arch/arm/mach-sa1100/sleep.S
> +++ /dev/null
> @@ -1,143 +0,0 @@
> -/*
> - * SA11x0 Assembler Sleep/WakeUp Management Routines
> - *
> - * Copyright (c) 2001 Cliff Brake <cbrake@accelent.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License.
> - *
> - * History:
> - *
> - * 2001-02-06: Cliff Brake         Initial code
> - *
> - * 2001-08-29:	Nicolas Pitre	Simplified.
> - *
> - * 2002-05-27:	Nicolas Pitre	Revisited, more cleanup and simplification.
> - *				Storage is on the stack now.
> - */
> -
> -#include <linux/linkage.h>
> -#include <asm/assembler.h>
> -#include <mach/hardware.h>
> -
> -		.text
> -/*
> - * sa1100_finish_suspend()
> - *
> - * Causes sa11x0 to enter sleep state
> - *
> - * Must be aligned to a cacheline.
> - */
> -	.balign	32
> -ENTRY(sa1100_finish_suspend)
> -	@ disable clock switching
> -	mcr	p15, 0, r1, c15, c2, 2
> -
> -	ldr	r6, =MDREFR
> -	ldr	r4, [r6]
> -	orr     r4, r4, #MDREFR_K1DB2
> -	ldr	r5, =PPCR
> -
> -	@ Pre-load __loop_udelay into the I-cache
> -	mov	r0, #1
> -	bl	__loop_udelay
> -	mov	r0, r0
> -
> -	@ The following must all exist in a single cache line to
> -	@ avoid accessing memory until this sequence is complete,
> -	@ otherwise we occasionally hang.
> -
> -	@ Adjust memory timing before lowering CPU clock
> -	str     r4, [r6]
> -
> -	@ delay 90us and set CPU PLL to lowest speed
> -	@ fixes resume problem on high speed SA1110
> -	mov	r0, #90
> -	bl	__loop_udelay
> -	mov	r1, #0
> -	str	r1, [r5]
> -	mov	r0, #90
> -	bl	__loop_udelay
> -
> -	/*
> -	 * SA1110 SDRAM controller workaround.  register values:
> -	 *
> -	 * r0  = &MSC0
> -	 * r1  = &MSC1
> -	 * r2  = &MSC2
> -	 * r3  = MSC0 value
> -	 * r4  = MSC1 value
> -	 * r5  = MSC2 value
> -	 * r6  = &MDREFR
> -	 * r7  = first MDREFR value
> -	 * r8  = second MDREFR value
> -	 * r9  = &MDCNFG
> -	 * r10 = MDCNFG value
> -	 * r11 = third MDREFR value
> -	 * r12 = &PMCR
> -	 * r13 = PMCR value (1)
> -	 */
> -
> -	ldr	r0, =MSC0
> -	ldr	r1, =MSC1
> -	ldr	r2, =MSC2
> -
> -	ldr	r3, [r0]
> -	bic	r3, r3, #FMsk(MSC_RT)
> -	bic	r3, r3, #FMsk(MSC_RT)<<16
> -
> -	ldr	r4, [r1]
> -	bic	r4, r4, #FMsk(MSC_RT)
> -	bic	r4, r4, #FMsk(MSC_RT)<<16
> -
> -	ldr	r5, [r2]
> -	bic	r5, r5, #FMsk(MSC_RT)
> -	bic	r5, r5, #FMsk(MSC_RT)<<16
> -
> -	ldr	r7, [r6]
> -	bic	r7, r7, #0x0000FF00
> -	bic	r7, r7, #0x000000F0
> -	orr	r8, r7, #MDREFR_SLFRSH
> -
> -	ldr	r9, =MDCNFG
> -	ldr	r10, [r9]
> -	bic	r10, r10, #(MDCNFG_DE0+MDCNFG_DE1)
> -	bic	r10, r10, #(MDCNFG_DE2+MDCNFG_DE3)
> -
> -	bic	r11, r8, #MDREFR_SLFRSH
> -	bic	r11, r11, #MDREFR_E1PIN
> -
> -	ldr	r12, =PMCR
> -
> -	mov	r13, #PMCR_SF
> -
> -	b	sa1110_sdram_controller_fix
> -
> -	.align 5
> -sa1110_sdram_controller_fix:
> -
> -	@ Step 1 clear RT field of all MSCx registers
> -	str 	r3, [r0]
> -	str	r4, [r1]
> -	str	r5, [r2]
> -
> -	@ Step 2 clear DRI field in MDREFR
> -	str	r7, [r6]
> -
> -	@ Step 3 set SLFRSH bit in MDREFR
> -	str	r8, [r6]
> -
> -	@ Step 4 clear DE bis in MDCNFG
> -	str	r10, [r9]
> -
> -	@ Step 5 clear DRAM refresh control register
> -	str	r11, [r6]
> -
> -	@ Wow, now the hardware suspend request pins can be used, that makes them functional for
> -	@ about 7 ns out of the	entire time that the CPU is running!
> -
> -	@ Step 6 set force sleep bit in PMCR
> -
> -	str	r13, [r12]
> -
> -20:	b	20b			@ loop waiting for sleep
> diff --git a/arch/arm/mach-sa1100/ssp.c b/arch/arm/mach-sa1100/ssp.c
> deleted file mode 100644
> index 613fd767afcf..000000000000
> --- a/arch/arm/mach-sa1100/ssp.c
> +++ /dev/null
> @@ -1,240 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  linux/arch/arm/mach-sa1100/ssp.c
> - *
> - *  Copyright (C) 2003 Russell King.
> - *
> - *  Generic SSP driver.  This provides the generic core for simple
> - *  IO-based SSP applications.
> - */
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/sched.h>
> -#include <linux/errno.h>
> -#include <linux/interrupt.h>
> -#include <linux/ioport.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -
> -#include <mach/hardware.h>
> -#include <mach/irqs.h>
> -#include <asm/hardware/ssp.h>
> -
> -#define TIMEOUT 100000
> -
> -static irqreturn_t ssp_interrupt(int irq, void *dev_id)
> -{
> -	unsigned int status = Ser4SSSR;
> -
> -	if (status & SSSR_ROR)
> -		printk(KERN_WARNING "SSP: receiver overrun\n");
> -
> -	Ser4SSSR = SSSR_ROR;
> -
> -	return status ? IRQ_HANDLED : IRQ_NONE;
> -}
> -
> -/**
> - * ssp_write_word - write a word to the SSP port
> - * @data: 16-bit, MSB justified data to write.
> - *
> - * Wait for a free entry in the SSP transmit FIFO, and write a data
> - * word to the SSP port.  Wait for the SSP port to start sending
> - * the data.
> - *
> - * The caller is expected to perform the necessary locking.
> - *
> - * Returns:
> - *   %-ETIMEDOUT	timeout occurred
> - *   0			success
> - */
> -int ssp_write_word(u16 data)
> -{
> -	int timeout = TIMEOUT;
> -
> -	while (!(Ser4SSSR & SSSR_TNF)) {
> -	        if (!--timeout)
> -	        	return -ETIMEDOUT;
> -		cpu_relax();
> -	}
> -
> -	Ser4SSDR = data;
> -
> -	timeout = TIMEOUT;
> -	while (!(Ser4SSSR & SSSR_BSY)) {
> -	        if (!--timeout)
> -	        	return -ETIMEDOUT;
> -		cpu_relax();
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * ssp_read_word - read a word from the SSP port
> - *
> - * Wait for a data word in the SSP receive FIFO, and return the
> - * received data.  Data is LSB justified.
> - *
> - * Note: Currently, if data is not expected to be received, this
> - * function will wait for ever.
> - *
> - * The caller is expected to perform the necessary locking.
> - *
> - * Returns:
> - *   %-ETIMEDOUT	timeout occurred
> - *   16-bit data	success
> - */
> -int ssp_read_word(u16 *data)
> -{
> -	int timeout = TIMEOUT;
> -
> -	while (!(Ser4SSSR & SSSR_RNE)) {
> -	        if (!--timeout)
> -	        	return -ETIMEDOUT;
> -		cpu_relax();
> -	}
> -
> -	*data = (u16)Ser4SSDR;
> -
> -	return 0;
> -}
> -
> -/**
> - * ssp_flush - flush the transmit and receive FIFOs
> - *
> - * Wait for the SSP to idle, and ensure that the receive FIFO
> - * is empty.
> - *
> - * The caller is expected to perform the necessary locking.
> - *
> - * Returns:
> - *   %-ETIMEDOUT	timeout occurred
> - *   0			success
> - */
> -int ssp_flush(void)
> -{
> -	int timeout = TIMEOUT * 2;
> -
> -	do {
> -		while (Ser4SSSR & SSSR_RNE) {
> -		        if (!--timeout)
> -		        	return -ETIMEDOUT;
> -			(void) Ser4SSDR;
> -		}
> -	        if (!--timeout)
> -	        	return -ETIMEDOUT;
> -	} while (Ser4SSSR & SSSR_BSY);
> -
> -	return 0;
> -}
> -
> -/**
> - * ssp_enable - enable the SSP port
> - *
> - * Turn on the SSP port.
> - */
> -void ssp_enable(void)
> -{
> -	Ser4SSCR0 |= SSCR0_SSE;
> -}
> -
> -/**
> - * ssp_disable - shut down the SSP port
> - *
> - * Turn off the SSP port, optionally powering it down.
> - */
> -void ssp_disable(void)
> -{
> -	Ser4SSCR0 &= ~SSCR0_SSE;
> -}
> -
> -/**
> - * ssp_save_state - save the SSP configuration
> - * @ssp: pointer to structure to save SSP configuration
> - *
> - * Save the configured SSP state for suspend.
> - */
> -void ssp_save_state(struct ssp_state *ssp)
> -{
> -	ssp->cr0 = Ser4SSCR0;
> -	ssp->cr1 = Ser4SSCR1;
> -
> -	Ser4SSCR0 &= ~SSCR0_SSE;
> -}
> -
> -/**
> - * ssp_restore_state - restore a previously saved SSP configuration
> - * @ssp: pointer to configuration saved by ssp_save_state
> - *
> - * Restore the SSP configuration saved previously by ssp_save_state.
> - */
> -void ssp_restore_state(struct ssp_state *ssp)
> -{
> -	Ser4SSSR = SSSR_ROR;
> -
> -	Ser4SSCR0 = ssp->cr0 & ~SSCR0_SSE;
> -	Ser4SSCR1 = ssp->cr1;
> -	Ser4SSCR0 = ssp->cr0;
> -}
> -
> -/**
> - * ssp_init - setup the SSP port
> - *
> - * initialise and claim resources for the SSP port.
> - *
> - * Returns:
> - *   %-ENODEV	if the SSP port is unavailable
> - *   %-EBUSY	if the resources are already in use
> - *   %0		on success
> - */
> -int ssp_init(void)
> -{
> -	int ret;
> -
> -	if (!(PPAR & PPAR_SPR) && (Ser4MCCR0 & MCCR0_MCE))
> -		return -ENODEV;
> -
> -	if (!request_mem_region(__PREG(Ser4SSCR0), 0x18, "SSP")) {
> -		return -EBUSY;
> -	}
> -
> -	Ser4SSSR = SSSR_ROR;
> -
> -	ret = request_irq(IRQ_Ser4SSP, ssp_interrupt, 0, "SSP", NULL);
> -	if (ret)
> -		goto out_region;
> -
> -	return 0;
> -
> - out_region:
> -	release_mem_region(__PREG(Ser4SSCR0), 0x18);
> -	return ret;
> -}
> -
> -/**
> - * ssp_exit - undo the effects of ssp_init
> - *
> - * release and free resources for the SSP port.
> - */
> -void ssp_exit(void)
> -{
> -	Ser4SSCR0 &= ~SSCR0_SSE;
> -
> -	free_irq(IRQ_Ser4SSP, NULL);
> -	release_mem_region(__PREG(Ser4SSCR0), 0x18);
> -}
> -
> -MODULE_AUTHOR("Russell King");
> -MODULE_DESCRIPTION("SA11x0 SSP PIO driver");
> -MODULE_LICENSE("GPL");
> -
> -EXPORT_SYMBOL(ssp_write_word);
> -EXPORT_SYMBOL(ssp_read_word);
> -EXPORT_SYMBOL(ssp_flush);
> -EXPORT_SYMBOL(ssp_enable);
> -EXPORT_SYMBOL(ssp_disable);
> -EXPORT_SYMBOL(ssp_save_state);
> -EXPORT_SYMBOL(ssp_restore_state);
> -EXPORT_SYMBOL(ssp_init);
> -EXPORT_SYMBOL(ssp_exit);
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 0cc1bf04686d..bf94f2718293 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -226,11 +226,6 @@ void __init arch_mm_preinit(void)
>  	swiotlb_init(max_pfn > arm_dma_pfn_limit, SWIOTLB_VERBOSE);
>  #endif
>  
> -#ifdef CONFIG_SA1111
> -	/* now that our DMA memory is actually so designated, we can free it */
> -	memblock_phys_free(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
> -#endif
> -
>  	/*
>  	 * Check boundaries twice: Some fundamental inconsistencies can
>  	 * be detected at build time already.
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 23b87b5ef7f1..350f6dcc24cc 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1339,14 +1339,6 @@ void __init arm_mm_memblock_reserve(void)
>  	 * and can only be in node 0.
>  	 */
>  	memblock_reserve(__pa(swapper_pg_dir), SWAPPER_PG_DIR_SIZE);
> -
> -#ifdef CONFIG_SA1111
> -	/*
> -	 * Because of the SA1111 DMA bug, we want to preserve our
> -	 * precious DMA-able memory...
> -	 */
> -	memblock_reserve(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
> -#endif
>  }
>  
>  /*
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 05b9233b9418..55ffee3d75ce 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1541,8 +1541,8 @@ config RTC_DRV_EP93XX
>  	  will be called rtc-ep93xx.
>  
>  config RTC_DRV_SA1100
> -	tristate "SA11x0/PXA2xx/PXA910"
> -	depends on ARCH_SA1100 || ARCH_PXA || ARCH_MMP
> +	tristate "PXA2xx/PXA910"
> +	depends on ARCH_PXA || ARCH_MMP
>  	help
>  	  If you say Y here you will get access to the real time clock
>  	  built into your SA11x0 or PXA2xx CPU.
> diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
> index 26b2f4184ecc..dc98484dbe27 100644
> --- a/drivers/rtc/rtc-sa1100.c
> +++ b/drivers/rtc/rtc-sa1100.c
> @@ -275,18 +275,10 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -	if (IS_ENABLED(CONFIG_ARCH_SA1100) ||
> -	    of_device_is_compatible(pdev->dev.of_node, "mrvl,sa1100-rtc")) {
> -		info->rcnr = base + 0x04;
> -		info->rtsr = base + 0x10;
> -		info->rtar = base + 0x00;
> -		info->rttr = base + 0x08;
> -	} else {
> -		info->rcnr = base + 0x0;
> -		info->rtsr = base + 0x8;
> -		info->rtar = base + 0x4;
> -		info->rttr = base + 0xc;
> -	}
> +	info->rcnr = base + 0x0;
> +	info->rtsr = base + 0x8;
> +	info->rtar = base + 0x4;
> +	info->rttr = base + 0xc;
>  
>  	platform_set_drvdata(pdev, info);
>  	device_init_wakeup(&pdev->dev, true);
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f7d0a0c2c0ef..0ab0dcc6d27d 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -614,16 +614,16 @@ config S3C2410_WATCHDOG
>  	  be called s3c2410_wdt.
>  
>  config SA1100_WATCHDOG
> -	tristate "SA1100/PXA2xx watchdog"
> -	depends on ARCH_SA1100 || ARCH_PXA || COMPILE_TEST
> +	tristate "PXA2xx watchdog"
> +	depends on ARCH_PXA || COMPILE_TEST
>  	help
> -	  Watchdog timer embedded into SA11x0 and PXA2xx chips. This will
> -	  reboot your system when timeout is reached.
> +	  Watchdog timer embedded PXA2xx chips. This will reboot your
> +	  system when timeout is reached.
>  
>  	  NOTE: once enabled, this timer cannot be disabled.
>  
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called sa1100_wdt.
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called sa1100_wdt.
>  
>  config DW_WATCHDOG
>  	tristate "Synopsys DesignWare watchdog"
> -- 
> 2.53.0
> 
> 
