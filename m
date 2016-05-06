From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 0/4] regulator: tps65917/palmas: Cleanups and bugfixes
Date: Fri, 6 May 2016 12:44:23 +0530
Message-ID: <572C444F.9070304@nvidia.com>
References: <1462494592-27909-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462494592-27909-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

On Friday 06 May 2016 05:59 AM, Nishanth Menon wrote:
> While attempting to try and get each of the regulator nodes of palmas
> to be capable of using vin-supply, I noticed a few cleanups and
> associated bug fixes.
>
> The series is based on next-20160504 and is split up to aid
> readability of the patch.
>
> Tested on OMAP5-uevm and DRA7 platform.
>

When you are here, can you implement the dt parsing with the new method 
from regulator framework.
Regulator FW calls callback to parse customized DT property, just need 
to pass the node and pointer when registering.

This will helps lots in cleanups and readability.
