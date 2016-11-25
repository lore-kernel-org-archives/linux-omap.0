From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v2 0/3] increase TSCADC clock to 24MHz and fix
 ti,charge-delay to represent in nS
Date: Fri, 25 Nov 2016 10:27:09 +0530
Message-ID: <71482721-fd60-65b2-d601-f1698ce5fa0a@ti.com>
References: <20161110163515.27598-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20161110163515.27598-1-mugunthanvnm@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Dmitry Torokhov,

On Thursday 10 November 2016 10:05 PM, Mugunthan V N wrote:
> This patch series enables ADC to be clocked at 24MHz as the
> TI AM335x ADC driver has already adopted to use DMA to transfer
> ADC samples. Now ADC can generated upto 800K Samples per second
> with the patch [1] on AM335x BBB and AM437x GP EVM.
> 
> when ADC ref clock is set at 24MHz, I am seeing some issue with
> touch screen pointer as the pointer jumps to random locations
> with free draw application. The issue is due to increase in ADC
> clock and charge delay for the touchscreen ADC line duration
> reduced.
> 
> So the notation of ti,charge-delay in terms of ADC clock is
> wrong, it has to be represented in time and driver has to convert
> the charge delay time to ADC clocks based on what ADC clock
> frequency is set.
> 
> Measured the performance with the iio_generic_buffer with the
> patch [2] applied
> 
> Verified the touch screen on AM335x GP EVM and AM335x BBB LCD7
> cape with [3] dts for display and touch screen to work.
> 

Since there are acks from DT and MFD maintainers, can you pull the patch
series if you do not have any more comments.

Regards
Mugunthan V N
