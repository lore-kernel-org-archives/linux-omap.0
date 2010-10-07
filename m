From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] iovmm: IVA2 MMU range is from 0x11000000 to 0xFFFFFFFF
Date: Thu, 07 Oct 2010 22:14:01 +0300 (EEST)
Message-ID: <20101007.221401.226802875.Hiroshi.DOYU@nokia.com>
References: <1286477021-23169-1-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286477021-23169-1-git-send-email-x0095840@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x0095840@ti.com
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, david.cohen@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: ext Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH] iovmm: IVA2 MMU range is from 0x11000000 to 0xFFFFFFFF
Date: Thu, 7 Oct 2010 20:43:41 +0200

> IV2 MMU capable addresses start from 0x11000000

Wouldn't it be better to add an general API to configure the valid
'da' range in advance?

I don't think that it's a good idea to introduce the iommu
instance("iva2:iommu") specific code here.
