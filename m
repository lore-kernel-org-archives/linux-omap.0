From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet
 size
Date: Wed, 28 Nov 2018 16:43:40 -0600
Message-ID: <0b70091e-3747-ee8f-15d6-4532e210278e@ti.com>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
 <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com> <20181128044913.GB6730@lunn.ch>
 <6047b35d-d3c2-14f7-b42d-754b581a3c55@ti.com> <20181128220211.GA5037@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128220211.GA5037@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

On 11/28/18 4:02 PM, Andrew Lunn wrote:
>> This is dynamic configuration related to ALE VLAN entries and
>> I do not see the way to support its auto-detection with current driver,
>> unfortunately.
> 
> I think you can subscribe to switchdev events which will tell you.

Thanks a lot for your review and comments.

Unfortunately, we still do not have switchdev in place, but i need to resolve
existing issue somehow. This patch is small, local to CPSW fix which can be
backported to stable. So, if possible, and no strong objection, could we proceed with it?

-- 
regards,
-grygorii
