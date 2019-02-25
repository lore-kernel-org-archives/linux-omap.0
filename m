From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/4] bus: ti-sysc: Add support for PRUSS SYSC type
Date: Mon, 25 Feb 2019 15:30:01 -0600
Message-ID: <0d071f1e-d3ad-9c1c-fb8f-9076df365a5e@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-3-git-send-email-rogerq@ti.com>
 <20190225212600.GA12346@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212600.GA12346@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On 2/25/19 3:26 PM, Rob Herring wrote:
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

This series is not complete, and we will submitting another version once
the issues with AM335x and AM437x are sorted out. Please ignore this.

regards
Suman

> 
>>  include/linux/platform_data/ti-sysc.h |  1 +
>>  3 files changed, 78 insertions(+), 11 deletions(-)
