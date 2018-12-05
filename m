From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Date: Wed, 5 Dec 2018 02:04:51 +0200
Message-ID: <20181205000450.GB3507@khorivan>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
 <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:

...

>>
>> I was thinking also about pinned list of vlans to the address, but in
>> this case this information also has to be synced by members of device
>> chain,
>> because it can be modified on any device level and it looks not very
>> friendly,
>> and at the end address space has addresses with pinned lists of vlans with
>> their pointers. But keeping this stuff in sync is not simplest decision.
>>
>>
>
>I really think we are not communicating properly, it really seems to me
>that if you had the information about the upper device trying to add an
>address to the lower device filter's either through notification or call
>to ndo_set_rxmode, you could be solving your problems. What are we
>missing here?

Sry, missed this one. The problem in getting  the owner of address.
Just simple case: vlan/macvlan/real_dev or vlan/.../.../real_dev

The real dev hasn't simple way to get vid the address belong to, or it has?



>--
>Florian

-- 
Regards,
Ivan Khoronzhuk
