From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for uc and mc address lists
Date: Wed, 13 Feb 2019 20:49:39 -0800
Message-ID: <BF485558-C29E-4F25-84B5-4C6C80BDF337@gmail.com>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org> <20181203184023.3430-3-ivan.khoronzhuk@linaro.org> <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com> <20181203235119.GF23230@khorivan> <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com> <20181204185720.GI23230@khorivan> <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com> <20181204234236.GA3507@khorivan> <4cf42ef9-7136-15ff-1244-1d946acd07ae@gmail.com> <20190122131239.GC3125@khorivan> <20190213161715.GA32249@khorivan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213161715.GA32249@khorivan>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org



On February 13, 2019 8:17:16 AM PST, Ivan Khoronzhuk <ivan=2Ekhoronzhuk@li=
naro=2Eorg> wrote:
>On Tue, Jan 22, 2019 at 03:12:41PM +0200, Ivan Khoronzhuk wrote:
>>On Mon, Jan 21, 2019 at 03:37:41PM -0800, Florian Fainelli wrote:
>>>On 12/4/18 3:42 PM, Ivan Khoronzhuk wrote:
>>>>On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:
>>
>>[=2E=2E=2E]
>>
>>>
>>>Ivan, based on the recent submission I copied you on [1], it sounds
>like
>>>we want to move ahead with your proposal to extend netdev_hw_addr
>with a
>>>vid member=2E
>>>
>>>On second thought, your approach is good and if we enclose the vid
>>>member within an #if IS_ENABLED(CONFIG_VLAN)8021Q) we should be good
>for
>>>most foreseeable use cases, if not, we can always introduce a
>variable
>>>size/defined context in the future=2E
>>>
>>>Can you resubmit this patch series as non-RFC in the next few days so
>I
>>>can also repost mine [1] and take advantage of these changes for
>>>multicast over VLAN when VLAN filtering is globally enabled on the
>device=2E
>>>
>>>[1]: https://www=2Espinics=2Enet/lists/netdev/msg544722=2Ehtml
>>>
>>>Thanks!
>>
>>Yes, sure=2E I can start to do that in several days=2E
>>Just a little busy right now=2E
>>
>>Just before doing this, maybe some comments could be added as it has
>more
>>attention now=2E Meanwhile I can send alternative variant but based on
>>real dev splitting addresses between vlans=2E In this approach it leaves
>address
>>space w/o vid extension but requires more changes to vlan core=2E
>Drawback here
>>that to change one address alg traverses all related vlan addresses,
>it can be
>>cpu/time wasteful, if it's done regularly, but saves memory=2E=2E=2E=2E
>>
>>Basically it's implemented locally in cpsw and requires more changes
>to move
>>it as some vlan core auxiliary functions to be reused=2E But it can work
>only
>>with vlans directly on top of real dev, which is fixable=2E
>>
>>Core function here:
>>__hw_addr_ref_sync_dev
>>it is called only for address the link of which was
>increased/decreased, thus
>>update made only on one address, comparing it for every vlan dev=2E
>>
>>It was added with this patch:
>>[1] net: core: dev_addr_lists: add auxiliary func to handle reference=20
>>address update e7946760de5852f32
>>
>>And used by this patch:
>>[2] net: ethernet: ti: cpsw: fix vlan mcast 15180eca569bfe1d4d
>>
>>So, idea is to move [2] to be vlan core auxiliary function to be
>reused
>>by NIC drivers=2E
>>
>>But potentially it can bring a little more changes I assume:
>>
>>1) add priv_flag |=3D IFF_IV_FLT (independent vlan filtering)=2E It allo=
ws
>to reuse
>>this flag for farther changes, probably for per vlan allmulti or so=2E
>>
>>2) real dev has to have complete list for vlans, not only their vids,
>but also
>>all vlandevs in device chain above it=2E So changes in add_vid can be
>required=2E
>>Vlan core can assign vlan dev pointer to real device only after it's
>completely
>>initialized=2E And for propagation reasons it requires every device in
>>infrastructure to be aware=2E That seems doable, but depends not only on
>me=2E
>>
>>3) Move code from [2] to be auxiliary vlan core API for setting mc and
>uc=2E
>>From this patch only one function is cpsw specific: cpsw_set_mc()=2E The
>rest can
>>be applicable on every NIC supporting IFF_IV_FLT=2E
>>
>>4) Move code from link below to do the same but for uc addresses:
>>https://git=2Elinaro=2Eorg/people/ivan=2Ekhoronzhuk/tsn_kernel=2Egit/com=
mit/?h=3Ducast_vlan_fix&id=3Debc88a7d8758759322d9ff88f25f8bac51ce7219
>>here only one func cpsw specific: cpsw_set_uc()
>>the rest can be generic=2E
>>
>>As third alternative, we can think about how to reduce memory for
>addresses by
>>reusing them or else, but this is as continuation of addr+vid
>approach, and API
>>probably would be the same=2E
>>
>>Then all this can be compared for proper decision=2E
>
>
>Hi Florian,
>
>After several more investigations and tries probably better left this
>idea as is=2E

Thank you for keeping the thread alive, does that mean you are going to re=
submit this patch series as-is (rebased) or are you saying that you are aba=
ndoning the idea and leaving the situation the way it is in cpsw?

>
>Here actually several explanations for this:
>1) If even assume that we can get access to vlan devices in the above
>ndev
>tree (we can) that doesn't guarantee that receive vlan filters are set
>replicating this structure=2E For example bond device can have one active
>slave
>but both of them in the tree having vid set, in this case addresses are
>syched only with active slave, no filters should be applied to not
>active slave=2E
>this can be achieved only each address has vid context=2E
>
>2) According to 1) rx filters device structure can be created while
>mc_sync()
>in each rx_mode(), and then used as orthogonal info=2E I've tried and it
>looks
>not cool and consumes anyway memory and even if it's less it's still
>not very
>scalable=2E (+ no normal signal "in complex structure case" when address
>should
>be undated to avoid redundant cpu cycles)=2E Not sure it can have
>practical
>results and be universal enouph=2E
>
>3) Assuming that every device in the tree (bond, team or else) is legal
>to
>modify its own address space, the real end device cannot be sure the
>vlan device
>address spaces reflects vid addresses that device tree want's from him=2E
>According to this each address in address space must hold its own
>context at
>every device and this context is comparable with address size=2E
>
>>-- Regards,
>>Ivan Khoronzhuk

--=20
Florian
