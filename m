From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 0/5] The series cleans up mainly the regulator driver
 and implements
Date: Wed, 31 Aug 2016 12:11:15 +0100
Message-ID: <20160831111115.GF27357@dell>
References: <1470833545-29462-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470833545-29462-1-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: broonie@kernel.org, tony@atomide.com, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, t-kristo@ti.com, russ.dill@ti.com, d-gerlach@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 10 Aug 2016, Keerthy wrote:

> One of the patch removes redundant read wrapper and makes
> use of regmap_read wherever necessary.

I can't take this series yet, since it relies on a change which was
taken into Mark's Regulator tree.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
