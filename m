From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/4] regulator: tps65917/palmas: Cleanups and bugfixes
Date: Fri, 6 May 2016 14:01:54 -0500
Message-ID: <572CEA22.2090300@ti.com>
References: <1462494592-27909-1-git-send-email-nm@ti.com>
 <572C444F.9070304@nvidia.com> <20160506171453.GX6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160506171453.GX6292@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-omap@vger.kernel.org

On 05/06/2016 12:14 PM, Mark Brown wrote:
> On Fri, May 06, 2016 at 12:44:23PM +0530, Laxman Dewangan wrote:
> 
>> When you are here, can you implement the dt parsing with the new method from
>> regulator framework.
>> Regulator FW calls callback to parse customized DT property, just need to
>> pass the node and pointer when registering.
> 
>> This will helps lots in cleanups and readability.
> 
> Yes, please.
> 
yeah, the driver has started showing it's age, it will be good to do a
refactor.

-- 
Regards,
Nishanth Menon
