From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0
 configuration in dual_mac modey
Date: Fri, 30 Nov 2018 15:55:17 +0200
Message-ID: <20181130135516.GE23230@khorivan>
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
 <20181126162644.GA23230@khorivan>
 <7f2c5e66-3b42-f921-c52d-236f5adc44bf@ti.com>
 <20181126200757.GB23230@khorivan>
 <fcc8efa1-1f19-baa3-872d-5c76a1b7dce0@ti.com>
 <20181129152646.GC23230@khorivan>
 <473759d1-09c4-ebc0-8b31-cc5c8bb85faa@ti.com>
 <20181130134228.GD23230@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181130134228.GD23230@khorivan>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 30, 2018 at 03:42:29PM +0200, Ivan Khoronzhuk wrote:
>On Thu, Nov 29, 2018 at 05:23:09PM -0600, Grygorii Strashko wrote:
>>
>>
>>On 11/29/18 9:26 AM, Ivan Khoronzhuk wrote:
>>>On Wed, Nov 28, 2018 at 03:15:46PM -0600, Grygorii Strashko wrote:
>>>>
>>>>
>>>>On 11/26/18 2:07 PM, Ivan Khoronzhuk wrote:
>>>>>On Mon, Nov 26, 2018 at 12:57:20PM -0600, Grygorii Strashko wrote:
>>>>>>
>>>>>>
>>>>>>On 11/26/18 10:26 AM, Ivan Khoronzhuk wrote:
>>>>>>>On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>>>>>>>>In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>>>>>>>>dual mac mode wich are used to configure pvids for each external ports.
>>>>>>>>But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>>>>>>>>ext. ports. As result, it's imposible to use priority tagged packets in
>>>>>>>>dual mac mode.
>>>>>>>>
>>>>>>>>Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>>>>>>>>mac mode functionality and, this way, make it possible to use priority
>>>>>>>>tagged packet in dual mac mode.
>>>>>>>So, now it's enabled to be added via regular ndo.
>>>>>>>I have similar change in mind, but was going to send it after
>>>>>>>mcast/ucast, and - enabling same vlans patch...
>>>>>>>
>>>>>>>2 things stopped me to add this:
>>>>>>>
>>>>>>>1) Moving it to be enabled via regular call is Ok, but in dual mac mode
>>>>>>>it causes overlaps, at least while vid deletion. So decided to wait till
>>>>>>>same vlans series is applied.
>>>>>>
>>>>>>TI driver documentation mentions this restriction
>>>>>>"While adding VLAN id to the eth interfaces,
>>>>>>same VLAN id should not be added in both interfaces which will lead to VLAN
>>>>>>forwarding and act as switch"
>>>>>It's not accurate now.
>>>>>This sw bug "acting like a switch" was fixed indirectly in LKML ).
>>>>>And at least for upstream version, not TISDK, desc should be updated,
>>>>>but better do this when it fixed completely and merged with TISDK.
>>>>>
>>>>>I know about this "written" restriction
>>>>>(for tiSDK, and it's not TRM after all ...),
>>>>>it can be avoided and it's partly avoided now ...
>>>>
>>>>I'd like to clarify point about supporting same VLANs in dual_mac mode,
>>>>to avoid future misunderstanding, overall: it's *not* supported as
>>>>adding same VLAN to both netdevices will cause unknown unicast packets
>>>>leaking between interfaces and it can't be avoided - hw limitation.
>>>
>>>Simple test shows no issues with ucast leaking.
>>>But for current buggy ucast vlan implementation it's not possible to verify,
>>>not sure but probably leaking in your case cuased by hidden toggling of
>>>interface to promisc while added ucast to vlans or other reason or so.
>>>Anyway I just decided to check specifically ucasts
>>>(macst as you know are not normal now).
>>>
>>>For verification you need to apply ucast fix (including vlans) first:
>>>https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=vlan_addr_flt_fix
>>>
>>>This is generic fix (not sure it will be approved, need try RFC) but implement
>>>the same as local fix for vlan ucasts:
>>>https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=ucast_vlan_fix
>>>
>>>Any of those are correct. I've used generic one.
>>>Applied the following scheme:
>>>
>>>                     +--------------------------+
>>>                     | host 74:DA:EA:47:7D:9C   |
>>>                     +--------------------------+
>>>
>>>                        +---------------------+
>>>             |       am572 evm     |
>>>                        |    eth0      eth1   |
>>>                        +----------+----------+
>>>                        | eth0.400 | eth1.400 |
>>>                        +----------+----------+
>>>                            ^          |
>>>                            |          |  +-----------+
>>>+-----------------+        |          |  |     PC    |
>>>| BBB eth0.400    |--------+          +->| Wireshark |
>>>+-----------------+                      +-----------+
>>>
>>>
>>>1) Configure vlans on am572x evm
>>>ip link add link eth0 name eth0.400 type vlan id 400
>>>ip link add link eth1 name eth1.400 type vlan id 400
>>>
>>>2) On BBB side:
>>># ip link add link eth0 name eth0.400 type vlan id 400
>>>Send ucast vlan traffic to the am572 evm, vlan ucast address is unreq on am572.
>>># ./plget -i eth0.400 -t ptpl2 -m tx-lat -n 160 -s 10 -a 74:DA:EA:47:7D:66
>>># ./plget -i eth0.400 -t ptpl2 -m tx-lat -n 160 -s 10 -a 18:03:73:66:87:42
>>>
>>>3) Observe silence on PC wireshark.
>>>
>>>Thus, no see issues with this.
>>>
>>>PS: I'm sure in plget tool, you can use your own.
>>
>>I'm using packeth to generate udp packets (vlan) src=PC dst=unknown
>>if there is record in ALE table which looks like:
>>type: vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x7, unreg_mcast = 0x0, member_list = 0x7
>>then above udp packet will be forwarded to BBB.
>Agree, seems no normal way to avoid ucast leak.

One of the ways could be removing end ports as memembers, leaving only port0:

type: vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x7, unreg_mcast = 0x0, member_list = 0x1

and allow tagged packets to be received by ports beeing non memebers of a vlan:

       cpsw_ale_control_set(cpsw->ale, slave_port,
			    ALE_PORT_DROP_UNKNOWN_VLAN, 0);

So that only unknown vlans are dropped...

>
>>
>>
>>
>>-- 
>>regards,
>>-grygorii
>
>-- 
>Regards,
>Ivan Khoronzhuk

-- 
Regards,
Ivan Khoronzhuk
