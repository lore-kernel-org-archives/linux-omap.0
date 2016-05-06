From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 2/2] ARM: dts: igep0020: Add SD card write-protect pin.
Date: Fri, 6 May 2016 17:07:55 -0400
Message-ID: <CABxcv==70_0smsRshOP+T4GSNMV1V5aUw9S9FcNcHEgr9Vnymw@mail.gmail.com>
References: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
	<1462568554-7868-2-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462568554-7868-2-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hello Enric,

On Fri, May 6, 2016 at 5:02 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> A host device that supports write protection should refuse to write to
> an SD card that is designated read-only when write-protect is set. This
> is an optional feature of the SD specification.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
