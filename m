From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] bus: omap: add MODULE_LICENSE tags
Date: Thu, 11 Jan 2018 08:34:06 -0800
Message-ID: <14681342-c001-b0cd-ba99-ef6a7e898e4b@oracle.com>
References: <20180111093707.2615555-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111093707.2615555-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sricharan R <sricharan@codeaurora.org>, Felipe Balbi <felipe.balbi@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 1/11/2018 1:36 AM, Arnd Bergmann wrote:
> linux-4.15 warns about missing MODULE_LICENSE tags such as these
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/bus/omap_l3_noc.o
> WARNING: modpost: missing MODULE_LICENSE() in drivers/bus/omap_l3_smx.o
> 
> For completeness, I'm also adding MODULE_AUTHOR and MODULE_DESCRIPTION
> tags, but I decided to leave out the email addresses, as all three
> authors are working for other companies now.
> 
> Cc: Sricharan R <sricharan@codeaurora.org>
> Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Unless someone sees a problem here, I'd pick this up into arm-soc
> directly, either the fixes or drivers branch
> ---
Fine by me.
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
