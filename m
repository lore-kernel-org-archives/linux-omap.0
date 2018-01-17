From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2] mfd: omap-usb-tll: Allocate driver data at once
Date: Wed, 17 Jan 2018 17:22:09 +0200
Message-ID: <487553c6-47d5-994e-e09e-ea112f9bfc57@ti.com>
References: <20180115202505.GA2628@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115202505.GA2628@lenoch>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 15/01/18 22:25, Ladislav Michl wrote:
> Allocating memory to store clk array together with driver
> data simplifies error unwinding and allows deleting memory
> allocation failure message as there is now only single point
> of failure already covered by allocation failure report.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> [Markus Elfring: simplified error unwinding, error message removal]
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Link: https://lkml.org/lkml/2018/1/15/411

Acked-by: Roger Quadros <rogerq@ti.com>

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
