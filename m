From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/3] [media] include/media: move platform_data to
 linux/platform_data/media
Date: Mon, 16 Nov 2015 13:28:10 +0100
Message-ID: <4084946.Zz4s9XrKbs@wuerfel>
References: <013152dcb3d4eaddd39aa4a37868430567bdc2d6.1447671420.git.mchehab@osg.samsung.com>
 <b8bd73bedde742571b1ab8a7c0917a732dbf2ca1.1447671420.git.mchehab@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b8bd73bedde742571b1ab8a7c0917a732dbf2ca1.1447671420.git.mchehab@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Hans Verkuil <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones <lee.jones@linaro.org>, devel@driverdev.osuosl.org, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Jiri Slaby <jslaby@suse.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Tomasz Stanislawski <t.stanislaws@samsung.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Eduardo Valentin <edubezval@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-omap@vger.kernel.org, linux-arm-
List-Id: linux-omap@vger.kernel.org

On Monday 16 November 2015 09:00:45 Mauro Carvalho Chehab wrote:
> Let's not mix platform_data headers with the core headers. Instead, let's
> create a subdir at linux/platform_data and move the headers to that
> common place, adding it to MAINTAINERS.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I think we can also move some of the existing platform data headers to the same
place, but that could be a separate patch:

$ git grep linux/platform_data drivers/media/
drivers/media/platform/coda/coda-common.c:#include <linux/platform_data/coda.h>
drivers/media/platform/soc_camera/mx2_camera.c:#include <linux/platform_data/camera-mx2.h>
drivers/media/platform/soc_camera/mx3_camera.c:#include <linux/platform_data/camera-mx3.h>
drivers/media/platform/soc_camera/mx3_camera.c:#include <linux/platform_data/dma-imx.h>
drivers/media/platform/soc_camera/pxa_camera.c:#include <linux/platform_data/camera-pxa.h>
drivers/media/platform/soc_camera/rcar_vin.c:#include <linux/platform_data/camera-rcar.h>

	Arnd
