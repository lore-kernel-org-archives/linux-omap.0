From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Date: Tue, 22 Jan 2019 15:12:41 +0200
Message-ID: <20190122131239.GC3125@khorivan>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
 <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
 <20181204234236.GA3507@khorivan>
 <4cf42ef9-7136-15ff-1244-1d946acd07ae@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4cf42ef9-7136-15ff-1244-1d946acd07ae@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 21, 2019 at 03:37:41PM -0800, Florian Fainelli wrote:
>On 12/4/18 3:42 PM, Ivan Khoronzhuk wrote:
>> On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:

[...]

>
>Ivan, based on the recent submission I copied you on [1], it sounds like
>we want to move ahead with your proposal to extend netdev_hw_addr with a
>vid member.
>
>On second thought, your approach is good and if we enclose the vid
>member within an #if IS_ENABLED(CONFIG_VLAN)8021Q) we should be good for
>most foreseeable use cases, if not, we can always introduce a variable
>size/defined context in the future.
>
>Can you resubmit this patch series as non-RFC in the next few days so I
>can also repost mine [1] and take advantage of these changes for
>multicast over VLAN when VLAN filtering is globally enabled on the device.
>
>[1]: https://www.spinics.net/lists/netdev/msg544722.html
>
>Thanks!

Yes, sure. I can start to do that in several days.
Just a little busy right now.

Just before doing this, maybe some comments could be added as it has more
attention now. Meanwhile I can send alternative variant but based on
real dev splitting addresses between vlans. In this approach it leaves address
space w/o vid extension but requires more changes to vlan core. Drawback here
that to change one address alg traverses all related vlan addresses, it can be
cpu/time wasteful, if it's done regularly, but saves memory....

Basically it's implemented locally in cpsw and requires more changes to move
it as some vlan core auxiliary functions to be reused. But it can work only
with vlans directly on top of real dev, which is fixable.

Core function here:
__hw_addr_ref_sync_dev
it is called only for address the link of which was increased/decreased, thus
update made only on one address, comparing it for every vlan dev.

It was added with this patch:
[1] net: core: dev_addr_lists: add auxiliary func to handle reference address 
update e7946760de5852f32

And used by this patch:
[2] net: ethernet: ti: cpsw: fix vlan mcast 15180eca569bfe1d4d

So, idea is to move [2] to be vlan core auxiliary function to be reused
by NIC drivers.

But potentially it can bring a little more changes I assume:

1) add priv_flag |= IFF_IV_FLT (independent vlan filtering). It allows to reuse
this flag for farther changes, probably for per vlan allmulti or so.

2) real dev has to have complete list for vlans, not only their vids, but also
all vlandevs in device chain above it. So changes in add_vid can be required.
Vlan core can assign vlan dev pointer to real device only after it's completely
initialized. And for propagation reasons it requires every device in
infrastructure to be aware. That seems doable, but depends not only on me.

3) Move code from [2] to be auxiliary vlan core API for setting mc and uc.
>From this patch only one function is cpsw specific: cpsw_set_mc(). The rest can
be applicable on every NIC supporting IFF_IV_FLT.

4) Move code from link below to do the same but for uc addresses:
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/commit/?h=ucast_vlan_fix&id=ebc88a7d8758759322d9ff88f25f8bac51ce7219
here only one func cpsw specific: cpsw_set_uc()
the rest can be generic.

As third alternative, we can think about how to reduce memory for addresses by
reusing them or else, but this is as continuation of addr+vid approach, and API
probably would be the same.

Then all this can be compared for proper decision.

>-- 
>Florian

-- 
Regards,
Ivan Khoronzhuk
