From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [RFC PATCH net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
Date: Wed, 17 Oct 2018 23:11:35 +0300
Message-ID: <20181017201133.GA13816@khorivan>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
 <92ab4728-109f-01cc-09db-3da4d8c8e92e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <92ab4728-109f-01cc-09db-3da4d8c8e92e@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 16, 2018 at 02:38:33PM -0500, Grygorii Strashko wrote:
>
>
>On 10/16/2018 01:20 PM, Ivan Khoronzhuk wrote:
>>The cpsw holds separate mcast entires for vlan entries. At this moment
>>driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
>>As result mcast for vlans doesn't work. It can be fixed by adding same
>>mcast entries for every created vlan, but this patchseries uses more
>>sophisticated way and allows to create mcast entries only for vlans
>>that really require it. Generic functions from this series can be
>>reused for fixing vlan and macvlan unicast.
>
>I assume this is first of all for dual_mac mode.
Mainly yes, but affects on switch mode also (and single port) adding
appropriate mcast entries.

-- Regards,
Ivan Khoronzhuk
