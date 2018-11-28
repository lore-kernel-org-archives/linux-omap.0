From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet
 size
Date: Wed, 28 Nov 2018 14:56:48 -0600
Message-ID: <6047b35d-d3c2-14f7-b42d-754b581a3c55@ti.com>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
 <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com> <20181128044913.GB6730@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128044913.GB6730@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 11/27/18 10:49 PM, Andrew Lunn wrote:
>> [1] https://e2e.ti.com/support/arm/sitara_arm/f/791/t/701669
> 
> Reading this, the interesting part is:
> 
> 	My guess would be that the driver would have to track the
> 	configuration of the switch hardware to correctly pad the
> 	frame.
> 
> Have you tried that?

This is dynamic configuration related to ALE VLAN entries and
I do not see the way to support its auto-detection with current driver,
unfortunately.

-- 
regards,
-grygorii
