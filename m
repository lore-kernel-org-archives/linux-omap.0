From: keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561 regulator
 support
Date: Sat, 8 Jun 2019 09:26:31 +0530
Message-ID: <e68d9939-a56a-b3c5-7f6d-e5783e16a6de@ti.com>
References: <20190516043218.8222-1-j-keerthy@ti.com>
 <20190516043218.8222-4-j-keerthy@ti.com>
 <20190522153528.GG8582@sirena.org.uk>
 <1712197d-7d43-38a8-efde-11b99537eae9@ti.com>
 <20190528132755.GK2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528132755.GK2456@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On 5/28/2019 6:57 PM, Mark Brown wrote:
> On Tue, May 28, 2019 at 03:23:41PM +0530, Keerthy wrote:
>> On 22/05/19 9:05 PM, Mark Brown wrote:
>>> On Thu, May 16, 2019 at 10:02:18AM +0530, Keerthy wrote:
> 
>>> Acked-by: Mark Brown <broonie@kernel.org>
> 
>> This patch will come via the mfd branch?
> 
> I'd expect so, IIRC it had a build dependency on the earlier patches in
> the series so if that doesn't happen I'll need to merge the relevant MFD
> commits.

Mark,

mfd patches are on linux-next already. Hope you can pull this one now 
that dependencies are met.

- Keerthy
> 
