From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet
 size
Date: Tue, 27 Nov 2018 19:27:15 -0600
Message-ID: <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126022711.GD32164@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

On 11/25/18 8:27 PM, Andrew Lunn wrote:
> On Sun, Nov 25, 2018 at 05:43:15PM -0600, Grygorii Strashko wrote:
>> For proper VLAN packets forwarding CPSW driver uses min tx packet size of
>> 64bytes (VLAN_ETH_ZLEN, excluding ETH_FCS) which was corrected by
>> commit 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size").
>>
>> Unfortunately, this breaks some industrial automation protocols, as
>> reported by TI customers [1], which can work only with min TX packet size
>> from 60 byte (ecluding FCS).
> 
> Hi Grygorii
> 
> excluding...
> 
>> Hence, introduce module boot parameter "tx_packet_min" to allow configure
>> min TX packet size at boot time.
> 
> Module parameters are generally not liked.

not sure how to proceed otherwise. There is always one instance of CPSW per SoC,
so Module parameter is safe here at least.

> 
> What actually happens here with this lower limit? Does the hardware
> send runt packets? Does the protocol actually require runt packets?

I do not have more details in addition to what's described in [1]:
"While for instance the ARP protocol does not seem to have a problem with additional
padding in the payload, some industrial automation protocols seem to be strict in this regard."
"We're basically running a bridge for different industrial protocols like ProfiNet"

As per my understanding there some industrial HW and SW which has very
strict limitation to min packet size and just can't handle other min packet
sizes.

> 
> I'm just wondering if the module parameter can be avoided by setting
> this as the default. 

It was a default value 60 bytes (64 bytes with FCS), but I changed it to 64 byte (68 byte with FCS) 
as per above mentioned commit for proper VLAN tagged packets forwarding support
(which seems legal as per 802.1q - G.2.1 Treatment of PAD fields in IEEE 802.3 frames).

Use case:
 - Port 0 (int) - vlan capable host.
 - Port 1 (ext) - vlan capable network
 - port 2 (ext)- non vlan capable network. pvid is set.
   all egress traffic untagged. CPSW HW can't align packet properly
   when vlan tag is removed, so need to use 68 byte min packet size.

Hence, both use cases need to be supported - this patch posted.
without it TI customers will continue do revert manually when required
which definitely not a good option.

>But we need to ensure ARP packets, which are
> smaller than the minimum MTU are correctly padded.


[1] https://e2e.ti.com/support/arm/sitara_arm/f/791/t/701669

-- 
regards,
-grygorii
