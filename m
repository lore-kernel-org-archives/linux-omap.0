From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Tue, 11 Sep 2018 19:14:15 +0100
Message-ID: <20180911181415.GH4185@dell>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911170825.17789-2-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 11 Sep 2018, Dan Murphy wrote:

> Remove support for the LM3697 LED device
> from the ti-lmu.  The LM3697 will be supported
> via a stand alone LED driver.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v7 - New change for the series based on the comments in https://lore.kernel.org/patchwork/patch/982550/
> 
>  .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
