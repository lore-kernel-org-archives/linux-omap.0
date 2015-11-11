From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] [media] include/media: move platform driver headers
 to a separate dir
Date: Wed, 11 Nov 2015 21:26:31 +0100
Message-ID: <4220808.QEkJDXYE1T@wuerfel>
References: <413d2bb0b813a7e62867de7a94b0ab61e16cb1cb.1447261977.git.mchehab@osg.samsung.com>
 <09e182fa61a7122356b790cd2a4a7f622dabb4ce.1447261977.git.mchehab@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <09e182fa61a7122356b790cd2a4a7f622dabb4ce.1447261977.git.mchehab@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sergey Lapin <slapin@ossfans.org>, Sekhar Nori <nsekhar@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Lad,
 Prabhakar" <prabhakar.csengg@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Harald Welte <laforge@openezx.org>, devel@driverdev.osuosl.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, openezx-devel@lists.openezx.org, Russell King <linux@arm.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Kukjin Kim <kgene@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Junghak Sung <jh1009>
List-Id: linux-omap@vger.kernel.org

On Wednesday 11 November 2015 15:14:48 Mauro Carvalho Chehab wrote:
>  rename include/media/{ => platform}/exynos-fimc.h (100%)
>  rename include/media/{ => platform}/mmp-camera.h (100%)
>  rename include/media/{ => platform}/omap1_camera.h (100%)
>  rename include/media/{ => platform}/omap4iss.h (100%)
>  rename include/media/{ => platform}/s3c_camif.h (100%)
>  rename include/media/{ => platform}/s5p_hdmi.h (100%)
>  rename include/media/{ => platform}/sh_mobile_ceu.h (100%)
>  rename include/media/{ => platform}/sh_mobile_csi2.h (100%)
>  rename include/media/{ => platform}/sh_vou.h (100%)
>  rename include/media/{ => platform}/sii9234.h (100%)
>  rename include/media/{ => platform}/soc_camera.h (100%)
>  rename include/media/{ => platform}/soc_camera_platform.h (98%)
>  rename include/media/{ => platform}/soc_mediabus.h (100%)

This still seems to be a mix of various things. Some of these are interfaces
between drivers, while others declare a foo_platform_data structure that
is used to interface between platform code and the driver.

I think the latter should go into include/linux/platform_data/media/*.h instead.

	Arnd
