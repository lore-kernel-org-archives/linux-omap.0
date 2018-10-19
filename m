From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: don't flush mcast
 entries while switch promisc mode
Date: Fri, 19 Oct 2018 23:28:44 +0300
Message-ID: <20181019202843.GD3909@khorivan>
References: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
 <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
 <20181019120408.GA3909@khorivan>
 <36da9bb2-38b7-cc70-9569-8895e20c6d1f@ti.com>
 <20181019192453.GC3909@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181019192453.GC3909@khorivan>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Grygorii,

On Fri, Oct 19, 2018 at 10:24:55PM +0300, Ivan Khoronzhuk wrote:
>On Fri, Oct 19, 2018 at 12:23:28PM -0500, Grygorii Strashko wrote:
>>
>>
>>On 10/19/18 7:04 AM, Ivan Khoronzhuk wrote:
>>>On Thu, Oct 18, 2018 at 07:03:06PM -0500, Grygorii Strashko wrote:
>>>>
>>>>
>>>>On 10/18/18 1:00 PM, Ivan Khoronzhuk wrote:
>>>>>No need now to flush mcast entries in switch mode while toggling to
>>>>>promiscuous mode. It's not needed as vlan reg_mcast = ALL_PORTS
>>>>>and mcast/vlan ports = ALL_PORTS, the same happening for vlan
>>>>>unreg_mcast, it's set to ALL_PORT_MASK just after calling promisc
>>>>>mode routine by calling set allmulti. I suppose main reason to flush
>>>>>them is to use unreg_mcast to receive all to host port. Thus, now, all
>>>>>mcast packets are received anyway and no reason to flush mcast entries
>>>>>unsafely, as they were synced with __dev_mc_sync() previously and are
>>>>>not restored. Another way is to _dev_mc_unsync() them, but no need.

I've sent new patch achiving the same but with second viariant described
in this cover letter. Please, look at it. No rush.

-- 
Regards,
Ivan Khoronzhuk
