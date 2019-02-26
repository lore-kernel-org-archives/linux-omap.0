From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/4] bus: ti-sysc: Add support for PRUSS SYSC type
Date: Tue, 26 Feb 2019 16:16:24 +0200
Message-ID: <7b762f7d-75af-a615-a18d-6f3854bc099a@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-3-git-send-email-rogerq@ti.com>
 <20190225212600.GA12346@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212600.GA12346@bogus>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: tony@atomide.com, s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 25/02/2019 23:26, Rob Herring wrote:
> On Mon, Feb 04, 2019 at 05:53:55PM +0200, Roger Quadros wrote:
>> The PRUSS module has a SYSCFG which is unique. Add
>> support for it.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/bus/ti-sysc.c                 | 77 +++++++++++++++++++++++++++++++++++
>>  include/dt-bindings/bus/ti-sysc.h     | 11 -----
> 
> Did you intend to remove what you just added?

Yes, it was a mistake.

> 
>>  include/linux/platform_data/ti-sysc.h |  1 +
>>  3 files changed, 78 insertions(+), 11 deletions(-)

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
