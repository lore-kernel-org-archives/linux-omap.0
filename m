From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw-phy-sel: check
 bus_find_device() ret value
Date: Tue, 15 May 2018 18:11:49 -0500
Message-ID: <623a9ea1-3caa-3eeb-718b-e1e82fbfa87f@ti.com>
References: <20180515230149.6547-1-grygorii.strashko@ti.com>
 <CAHp75VdXjiis9R6a1EZO9q3fawB_nSmJhqRSvv_7yggTr-EBOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdXjiis9R6a1EZO9q3fawB_nSmJhqRSvv_7yggTr-EBOA@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 05/15/2018 06:07 PM, Andy Shevchenko wrote:
> On Wed, May 16, 2018 at 2:01 AM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> This fixes klockworks warnings: Pointer 'dev' returned from call to
>> function 'bus_find_device' at line 179 may be NULL and will be dereferenced
>> at line 181.
> 
>> +               dev_err(dev, "unable to find platform device for %s\n",
>> +                       of_node_full_name(node));
> 
> Sorry, isn't %pOF works for this?
> 

Thanks, will update.

-- 
regards,
-grygorii
