From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 1/4] omapdrm: fix compatible string for td028ttec1
Date: Thu, 16 Nov 2017 17:10:56 +0100
Message-ID: <908C52B9-83E2-49B3-B5B4-D8F27A96ECD6@goldelico.com>
References: <cover.1510822218.git.hns@goldelico.com>
 <474bfc72b67e1d0e2a223084a69f04d2baa1dda8.1510822218.git.hns@goldelico.com>
 <4753a425-d050-7f2d-35ae-b387accfd99e@ti.com>
 <130D3B71-C0CE-4755-BF06-971681F630BC@goldelico.com>
 <d90ee1ee-8a33-de04-bb8b-2f10e0a80a61@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d90ee1ee-8a33-de04-bb8b-2f10e0a80a61@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, letux-kernel@openphoenux.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, Sean Paul <seanpaul@chromium.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

> Am 16.11.2017 um 16:53 schrieb Andrew F. Davis <afd@ti.com>:
> 
> On 11/16/2017 07:43 AM, H. Nikolaus Schaller wrote:
>> 
>>> Am 16.11.2017 um 13:32 schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
>>> 
>>> On 16/11/17 10:50, H. Nikolaus Schaller wrote:
>>>> The vendor name was "toppoly" but other panels and the vendor list
>>>> have defined it as "tpo". So let's fix it in driver and bindings.
>>>> 
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>> 
>>> 
>>>> -MODULE_ALIAS("spi:toppoly,td028ttec1");
>>>> +MODULE_ALIAS("spi:tpo,td028ttec1");
>>> 
>>> Doesn't this mean that the module won't load if you have old bindings?
>> 
>> Hm.
>> 
>> Well, I think it can load but doesn't automatically from DT strings which might
>> be unexpected.
>> 
>>> Can't we have two module aliases?
>> 
>> I think we can. Just a random example:
>> https://elixir.free-electrons.com/linux/latest/source/drivers/w1/slaves/w1_therm.c#L754
>> 
>> So we should keep both.
> 
> Even better would be to drop both MODULE_ALIAS and let the
> MODULE_DEVICE_TABLE macro define them for your from the SPI id table.

Why would that be better?

As far as I see it will need more code and changes than adding one line of
MODULE_ALIAS.

> Although it doesn't look like this driver has an SPI id table, you
> should probably add one, I be interested to see if this module is always
> being matched through the "spi" or the "of" alias..

Could you please propose how that code should look like, so that I can test?

BR and thanks,
Nikolaus Schaller

> 
>> 
>> Should I submit a new version?
>> 
>> BR,
>> Nikolaus
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
