From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt/binding: ti-tsc-adc: deprecate ti,charge-delay
 and add binding doc for ti,charge-delay-ns
Date: Mon, 14 Nov 2016 19:54:42 -0600
Message-ID: <20161115015442.pexycr4adco3hnug@rob-hp-laptop>
References: <20161110163515.27598-1-mugunthanvnm@ti.com>
 <20161110163515.27598-2-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110163515.27598-2-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 10, 2016 at 10:05:13PM +0530, Mugunthan V N wrote:
> ti,charge-delay represents the duration that ADC should wait
> before sampling the ADC line to detect the touch location and pen
> up/downs. Currently the ADC clock is set at 3MHz. The device-tree
> entry for ti,charge-delay is based on assumption of ADC clock at
> 3MHz, but it can be operated up to 24MHz clock. Representing the
> charge delay of touchscreen in terms of ADC clocks is incorrect.
> So change this representation to ti,charge-delay-ns, which driver
> can convert it to number clock cycles based on ref clock
> frequency.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
>  .../bindings/input/touchscreen/ti-tsc-adc.txt      | 32 ++++++++++++++--------
>  1 file changed, 21 insertions(+), 11 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
