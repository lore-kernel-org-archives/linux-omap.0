From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 08/10] mfd: menelaus: Switch all children to threaded_irq
Date: Tue, 17 Dec 2013 10:35:11 +0000
Message-ID: <20131217103511.GC19810@lee--X1>
References: <20131216153936.GQ18769@lee--X1>
 <1387238904-7843-1-git-send-email-balbi@ti.com>
 <1387238904-7843-8-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387238904-7843-8-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

> Now that we have our own irq_chip, all children can use traditional
> request_threaded_irq().

Is it possible to convert these to managed resources (*_devm)?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
