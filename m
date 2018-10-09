From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 00/11] net: ethernet: ti: cpsw: replace cpsw-phy-sel
 with phy driver
Date: Tue, 9 Oct 2018 16:12:16 -0500
Message-ID: <6f77b8a2-a973-4a13-8b9e-014648dea2c5@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181009143631.GK5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009143631.GK5662@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/09/2018 09:36 AM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [181008 23:54]:
>> 2) introduce new PHY API for network interface mode selection which will use
>> already defined set of modes from phy_interface_t.
>>
>> Option 2 was selected for this series.
> 
> Looks good to me :) The dts files will cause merge conflicts with
> what I have pending for the ti-sysc changes so please send the dts
> changes in a separate series when posting without RFC.

expected. I did on top of mauster, but will rebase and resend if approved.

-- 
regards,
-grygorii
