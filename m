From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Date: Thu, 14 Feb 2019 15:03:24 +0200
Message-ID: <20190214130322.GB32249@khorivan>
References: <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
 <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
 <20181204234236.GA3507@khorivan>
 <4cf42ef9-7136-15ff-1244-1d946acd07ae@gmail.com>
 <20190122131239.GC3125@khorivan>
 <20190213161715.GA32249@khorivan>
 <BF485558-C29E-4F25-84B5-4C6C80BDF337@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BF485558-C29E-4F25-84B5-4C6C80BDF337@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 13, 2019 at 08:49:39PM -0800, Florian Fainelli wrote:
>
>
>On February 13, 2019 8:17:16 AM PST, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>>On Tue, Jan 22, 2019 at 03:12:41PM +0200, Ivan Khoronzhuk wrote:
>>>On Mon, Jan 21, 2019 at 03:37:41PM -0800, Florian Fainelli wrote:
>>>>On 12/4/18 3:42 PM, Ivan Khoronzhuk wrote:
>>>>>On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:
>>>
>>>[...]
>>>
>>>>
>>>>Ivan, based on the recent submission I copied you on [1], it sounds
>>like
>>>>we want to move ahead with your proposal to extend netdev_hw_addr
>>with a
>>>>vid member.
>>>>
>>>>On second thought, your approach is good and if we enclose the vid
>>>>member within an #if IS_ENABLED(CONFIG_VLAN)8021Q) we should be good
>>for
>>>>most foreseeable use cases, if not, we can always introduce a
>>variable
>>>>size/defined context in the future.
>>>>
>>>>Can you resubmit this patch series as non-RFC in the next few days so
>>I
>>>>can also repost mine [1] and take advantage of these changes for
>>>>multicast over VLAN when VLAN filtering is globally enabled on the
>>device.
>>>>
>>>>[1]: https://www.spinics.net/lists/netdev/msg544722.html
>>>>
>>>>Thanks!
>>>
>>>Yes, sure. I can start to do that in several days.
>>>Just a little busy right now.
>>>
>>>Just before doing this, maybe some comments could be added as it has
>>more
>>>attention now. Meanwhile I can send alternative variant but based on
>>>real dev splitting addresses between vlans. In this approach it leaves
>>address
>>>space w/o vid extension but requires more changes to vlan core.
>>Drawback here
>>>that to change one address alg traverses all related vlan addresses,
>>it can be
>>>cpu/time wasteful, if it's done regularly, but saves memory....
>>>
>>>Basically it's implemented locally in cpsw and requires more changes
>>to move
>>>it as some vlan core auxiliary functions to be reused. But it can work
>>only
>>>with vlans directly on top of real dev, which is fixable.
>>>
>>>Core function here:
>>>__hw_addr_ref_sync_dev
>>>it is called only for address the link of which was
>>increased/decreased, thus
>>>update made only on one address, comparing it for every vlan dev.
>>>
>>>It was added with this patch:
>>>[1] net: core: dev_addr_lists: add auxiliary func to handle reference
>>>address update e7946760de5852f32
>>>
>>>And used by this patch:
>>>[2] net: ethernet: ti: cpsw: fix vlan mcast 15180eca569bfe1d4d
>>>
>>>So, idea is to move [2] to be vlan core auxiliary function to be
>>reused
>>>by NIC drivers.
>>>
>>>But potentially it can bring a little more changes I assume:
>>>
>>>1) add priv_flag |= IFF_IV_FLT (independent vlan filtering). It allows
>>to reuse
>>>this flag for farther changes, probably for per vlan allmulti or so.
>>>
>>>2) real dev has to have complete list for vlans, not only their vids,
>>but also
>>>all vlandevs in device chain above it. So changes in add_vid can be
>>required.
>>>Vlan core can assign vlan dev pointer to real device only after it's
>>completely
>>>initialized. And for propagation reasons it requires every device in
>>>infrastructure to be aware. That seems doable, but depends not only on
>>me.
>>>
>>>3) Move code from [2] to be auxiliary vlan core API for setting mc and
>>uc.
>>>From this patch only one function is cpsw specific: cpsw_set_mc(). The
>>rest can
>>>be applicable on every NIC supporting IFF_IV_FLT.
>>>
>>>4) Move code from link below to do the same but for uc addresses:
>>>https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/commit/?h=ucast_vlan_fix&id=ebc88a7d8758759322d9ff88f25f8bac51ce7219
>>>here only one func cpsw specific: cpsw_set_uc()
>>>the rest can be generic.
>>>
>>>As third alternative, we can think about how to reduce memory for
>>addresses by
>>>reusing them or else, but this is as continuation of addr+vid
>>approach, and API
>>>probably would be the same.
>>>
>>>Then all this can be compared for proper decision.
>>
>>
>>Hi Florian,
>>
>>After several more investigations and tries probably better left this
>>idea as is.
>
>Thank you for keeping the thread alive, does that mean you are going to resubmit this patch series as-is (rebased) or are you saying that you are abandoning the idea and leaving the situation the way it is in cpsw?

I will resubmit this one. But:

I have to try one more approach before this.
The idea is to create simple rx flt device tree while mc/us sync.
Then use it at real device to dispatch addresses.

It increases hw_addr struct a little and code base,
But:
- no need to keep linearly all vlan addresses in one address space.
- replicates RX filtering struct of net devices,
  (but not logical tree of netdevs)
- keeps devs info per address.
- no need to change addr lenth and modify existent API
- access at any net dev to above rx flt device structure per address
- potentially can be use not only for vlan devs identification but for
  other rx path offloads.

Idea is simple but not completely verified it yet,
need a little bit more time to prove/clean ...or drop it.

>
>>
>>Here actually several explanations for this:
>>1) If even assume that we can get access to vlan devices in the above
>>ndev
>>tree (we can) that doesn't guarantee that receive vlan filters are set
>>replicating this structure. For example bond device can have one active
>>slave
>>but both of them in the tree having vid set, in this case addresses are
>>syched only with active slave, no filters should be applied to not
>>active slave.
>>this can be achieved only each address has vid context.
>>
>>2) According to 1) rx filters device structure can be created while
>>mc_sync()
>>in each rx_mode(), and then used as orthogonal info. I've tried and it
>>looks
>>not cool and consumes anyway memory and even if it's less it's still
>>not very
>>scalable. (+ no normal signal "in complex structure case" when address
>>should
>>be undated to avoid redundant cpu cycles). Not sure it can have
>>practical
>>results and be universal enouph.
>>
>>3) Assuming that every device in the tree (bond, team or else) is legal
>>to
>>modify its own address space, the real end device cannot be sure the
>>vlan device
>>address spaces reflects vid addresses that device tree want's from him.
>>According to this each address in address space must hold its own
>>context at
>>every device and this context is comparable with address size.
>>
>>>-- Regards,
>>>Ivan Khoronzhuk
>
>-- 
>Florian

-- 
Regards,
Ivan Khoronzhuk
