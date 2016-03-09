From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 00/23] Nokia N950 display support
Date: Wed, 9 Mar 2016 16:19:48 +0000
Message-ID: <CACvgo51ys5DQYKLd4qJv6yFj9TKeZM3cfmsY0ECVVvnS+e_-4g@mail.gmail.com>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On 8 March 2016 at 16:39, Sebastian Reichel <sre@kernel.org> wrote:

>  arch/arm/boot/dts/omap3-n950-n9.dtsi            |  72 +++++++++
>  arch/arm/boot/dts/omap3-n950.dts                |  71 +++++++++
Just a friendly reminder that updating these and one will have to keep
the driver backwards compatible forever.

Tomi, has been in the process of removing all the unneeded cruft,
although omapdrm it is still using the custom panel, dsi and other
code as opposed to the ones provided by DRM. As he gets to reusing
those he might have some fun keeping things compatible.

It's up-to Tomi to decide, just thought I point it out.

Regards,
Emil
