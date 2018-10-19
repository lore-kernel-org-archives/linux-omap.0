From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: don't flush mcast
 entries while switch promisc mode
Date: Fri, 19 Oct 2018 12:23:28 -0500
Message-ID: <36da9bb2-38b7-cc70-9569-8895e20c6d1f@ti.com>
References: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
 <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
 <20181019120408.GA3909@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019120408.GA3909@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/19/18 7:04 AM, Ivan Khoronzhuk wrote:
> On Thu, Oct 18, 2018 at 07:03:06PM -0500, Grygorii Strashko wrote:
>>
>>
>> On 10/18/18 1:00 PM, Ivan Khoronzhuk wrote:
>>> No need now to flush mcast entries in switch mode while toggling to
>>> promiscuous mode. It's not needed as vlan reg_mcast = ALL_PORTS
>>> and mcast/vlan ports = ALL_PORTS, the same happening for vlan
>>> unreg_mcast, it's set to ALL_PORT_MASK just after calling promisc
>>> mode routine by calling set allmulti. I suppose main reason to flush
>>> them is to use unreg_mcast to receive all to host port. Thus, now, all
>>> mcast packets are received anyway and no reason to flush mcast entries
>>> unsafely, as they were synced with __dev_mc_sync() previously and are
>>> not restored. Another way is to _dev_mc_unsync() them, but no need.
>>
>> User have possibility to add additional mcast entries or edit existing 
>> in switch-mode, which is now done using custom tool. So, Host in promisc
>> mode will not receive packets for mcast address X if port mask for this
>> addr set to (ALL_PORTS - HOST_PORT). Am I missing smth?
> 
> I didn't take into account the custom tool changing entries directly,
> but even in this case there is at least a couple of interesting
> questions:
> 
> 1) Before the patch applied only several days ago -
>    5da1948969bc1991920987ce4361ea56046e5a98
>    "ti: cpsw: fix lost of mcast packets while rx_mode update"
>    It was impossible to do correctly anyway, as all mcast entries not
>    in the mc list were flushed (after rx_mode cb), by:
>    cpsw_ale_flush_multicast(cpsw->ale, ALE_ALL_PORTS, vid);
>    and those in mc, rewritten by adding them back in corrected form.
>    ... or this cb was not supposed to be called at all ...

It's not allowed to manipulate ALE table in dual_mac mode, so your
patches are safe in dual_mac mode. For switch-mode (unless we  move
forward with switch dev) standard linux interfaces allows create
default mcast entries which then (if required) corrected using custom
tool now.

> 
> 2) What is the reason to add mcast switch entires
>    (ALL_PORTS - HOST_PORT) if its function is added anyway by
>    unreq_mcast & (ALL_PORTS - HOST_PORT) ?
>    So, doesn't matter it's added or not - it will work :-|.

because in switch mode not all traffic directed to the Host port -
only in promisc mode. Reason safety and performance - Host should not
receive traffic which is not designated for it.

promiscuous in switch mode:
- disables learning
- enables unicast flooding to Host port
- enables unregistered multi-cast flooding to the Host port
In other words, CPSW will continue forwarding packets between P1&P2, but 
also will "duplicate" packets to Host port. This will work only for
vlans which have host port as member.

> 
> 3) Even so, toggling promisc mode will clear all these changes anyway,
>    even I will call _dev_mc_unsync() after flushing them.

there can be records which are not under control of Linux now.

> 
> 4) If user can tune ALE table by hand, what stops him do it after moving
>    to promisc mode, seems he knows what he's doing?
> 
> 5) It could be possible only for not default vlan entries, but mcast
>    vlan support is not supported yet. Who is gona restore those
>    entries after promisc off?
> 
> This behaviour is arguable, and flushing mcast entries can bring more
> issues then leaving. For me it doesn't matter, I can archive the same
> by adding after flush one line, it's even shorter:
> __dev_mc_unsync(priv->ndev, NULL);

Again, unless we move forward with switch dev you can't assume that
Linux stack has full control over ALE table. Sry, hence this patch is
not a fix and can introduce changes in current behavior and cause
regression reports - NACK.

-- 
regards,
-grygorii
