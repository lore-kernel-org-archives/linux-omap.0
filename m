From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [net-next PATCH 1/3] drivers: of: add phy fixup support in DT
Date: Thu, 25 Apr 2013 15:34:42 +0530
Message-ID: <5178FFBA.8050301@ti.com>
References: <1366654838-26479-1-git-send-email-mugunthanvnm@ti.com> <1366654838-26479-2-git-send-email-mugunthanvnm@ti.com> <20130425.035649.1109561373283256109.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20130425.035649.1109561373283256109.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 4/25/2013 1:26 PM, David Miller wrote:
> From: Mugunthan V N <mugunthanvnm@ti.com>
> Date: Mon, 22 Apr 2013 23:50:36 +0530
>
>> In earlier case phy fixup are added in board file as this is no more the case
>> so adding support for phy register fixup in Device Tree
>>
>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> When people put a series of undocumented PHY register writes using
> constants, we tell them it's firmware.
>
> If these PHY registers are actually documented in the driver, write a
> function in that driver which does the programming sequence, then add
> a property that the driver looks for in order to determine whether to
> call that sequence or not.
>
> I don't want people putting random PHY raw programming sequences and
> other crap like that into the OF device nodes.  It's extremely
> inelegant and inviting abuse.
>
Will modify the source as per your comments and will submit v2 patch set.

Regards
Mugunthan V N
