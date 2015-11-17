From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: Re: [PATCH v2 3/3] [media] include/media: move platform_data to
 linux/platform_data/media
Date: Tue, 17 Nov 2015 07:16:56 -0200
Message-ID: <20151117071656.498013a9@recife.lan>
References: <013152dcb3d4eaddd39aa4a37868430567bdc2d6.1447671420.git.mchehab@osg.samsung.com>
	<b8bd73bedde742571b1ab8a7c0917a732dbf2ca1.1447671420.git.mchehab@osg.samsung.com>
	<4084946.Zz4s9XrKbs@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4084946.Zz4s9XrKbs@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomasz Stanislawski <t.stanislaws@samsung.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Hans Verkuil <hverkuil@xs4all.nl>, Eduardo Valentin <edubezval@gmail.com>, Lee Jones <lee.jones@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>, Ulf Hansson <ulf.hansson@linaro.org>, Vinod Koul <vinod.koul@intel.com>Kuninori Morimoto <k>
List-Id: linux-omap@vger.kernel.org

Em Mon, 16 Nov 2015 13:28:10 +0100
Arnd Bergmann <arnd@arndb.de> escreveu:

> I think we can also move some of the existing platform data headers to the same
> place, but that could be a separate patch:
> 
> $ git grep linux/platform_data drivers/media/
> drivers/media/platform/coda/coda-common.c:#include <linux/platform_data/coda.h>
> drivers/media/platform/soc_camera/mx2_camera.c:#include <linux/platform_data/camera-mx2.h>
> drivers/media/platform/soc_camera/mx3_camera.c:#include <linux/platform_data/camera-mx3.h>
> drivers/media/platform/soc_camera/mx3_camera.c:#include <linux/platform_data/dma-imx.h>
> drivers/media/platform/soc_camera/pxa_camera.c:#include <linux/platform_data/camera-pxa.h>
> drivers/media/platform/soc_camera/rcar_vin.c:#include <linux/platform_data/camera-rcar.h>

Fair enough. Just sent a separate patch to address that.

Regards,
Mauro
