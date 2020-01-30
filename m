From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2] mfd: syscon: Use a unique name with regmap_config
Date: Thu, 30 Jan 2020 11:08:53 -0600
Message-ID: <99a04c52-1ff6-1611-5cf6-2c71b810ba43@ti.com>
References: <20200127231208.1443-1-s-anna@ti.com>
 <CAHp75VfaOfBZYjQa960keORW=VjOn2PdwoYpJMG7SsN83daSJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfaOfBZYjQa960keORW=VjOn2PdwoYpJMG7SsN83daSJg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Lechner <david@lechnology.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Andy,

On 1/30/20 9:34 AM, Andy Shevchenko wrote:
> On Tue, Jan 28, 2020 at 1:14 AM Suman Anna <s-anna@ti.com> wrote:
>>
>> The DT node full name is currently being used in regmap_config
>> which in turn is used to create the regmap debugfs directories.
>> This name however is not guaranteed to be unique and the regmap
>> debugfs registration can fail in the cases where the syscon nodes
>> have the same unit-address but are present in different DT node
>> hierarchies. Replace this logic using the syscon reg resource
>> address instead (inspired from logic used while creating platform
>> devices) to ensure a unique name is given for each syscon.
> 
>> -       syscon_config.name = of_node_full_name(np);
>> +       syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", np,
>> +                                      (u64)res.start);
> 
> Explicit castings in printf() usually tell us that something is not okay.

Yes, I agree in general.

> Yes, for resource_size_t we have %pa.

And that was the first thing I tried when doing v2, before moving away
from it. This is not for a console printf statement, but is rather for
the regmap debugfs name. Using a %pa adds the 0x and leading zeros in
the debugfs name, when compared to the name before this patch. The
typecast retains the current format, and replaces the unit-address
without the leading 0s either. Introducing a local-variable to avoid the
typecast is overkill.

> 
> On top of that, I would rather see %pfwn to avoid modification for
> other fwnode types.

Did you mean %pfwP? That can probably be handled when syscon code is
updated to use fwnode API.

regards
Suman
