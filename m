From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: input: ti-tsc-adc: Add new compatible
 for AM654 SoCs
Date: Mon, 11 Feb 2019 14:10:11 -0800
Message-ID: <20190211221011.GA149505@dtor-ws>
References: <20190108052631.4169-1-vigneshr@ti.com>
 <3623af02-063d-9077-1e59-99d8cfe93ddd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3623af02-063d-9077-1e59-99d8cfe93ddd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Vignesh,

On Mon, Feb 11, 2019 at 11:10:59AM +0530, Vignesh R wrote:
> Hi Dmitry,
> 
> On 08/01/19 10:56 AM, Vignesh R wrote:
> > AM654 SoCs has ADC IP which is similar to AM335x, but without the
> > touchscreen part. Add new compatible to handle AM654 SoCs. Also, it
> > seems that existing compatible strings used in the kernel DTs were never
> > documented. So, document them now.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> 
> If there are no comments, could you queue this bindings patch? This will
> help me in getting ADC DT nodes to be merged into ARM SoC tree.

Sorry I did not realize you waited for me. Yes, please feel free to
merge through your tree.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks,

-- 
Dmitry
