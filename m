From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561 regulator
 support
Date: Tue, 28 May 2019 15:23:41 +0530
Message-ID: <1712197d-7d43-38a8-efde-11b99537eae9@ti.com>
References: <20190516043218.8222-1-j-keerthy@ti.com>
 <20190516043218.8222-4-j-keerthy@ti.com>
 <20190522153528.GG8582@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522153528.GG8582@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, lee.jones@linaro.org
Cc: robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On 22/05/19 9:05 PM, Mark Brown wrote:
> On Thu, May 16, 2019 at 10:02:18AM +0530, Keerthy wrote:
>> The LP8756x family has a single output 4-phase regulator
>> configuration. Add support for the same. The control
>> lies in the master buck which is buck0 for 4-phase
>> configuration. Enable/disable/voltage set happen via
>> buck0 registers.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Mark/Lee,

This patch will come via the mfd branch?

- Keerthy

> 
