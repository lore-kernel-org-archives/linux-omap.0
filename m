From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: DRA7: beagle-x15: hwmod: Fix boot crash with DEBUG_LL
Date: Tue, 6 Jan 2015 09:17:59 -0600
Message-ID: <54ABFCA7.3080306@ti.com>
References: <1420532690-29340-1-git-send-email-lokeshvutla@ti.com> <20150106140517.GA3897@kahuna> <20150106150851.GB6502@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150106150851.GB6502@saruman>
Sender: stable-owner@vger.kernel.org
To: balbi@ti.com
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 01/06/2015 09:08 AM, Felipe Balbi wrote:
> On Tue, Jan 06, 2015 at 08:05:17AM -0600, Nishanth Menon wrote:
>>> For using DEBUG_LL, enable CONFIG_DEBUG_OMAP4UART3 in menuconfig.
>>>
>>> Fixes: 90020c7 (ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data)
>>
>> Fixes: 90020c7b2c5e ("ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data")
> 
> what's the difference ? why do you want that many more characters if
> those 7 are enough for git to find a uniq commit ? Try this:
> 
> $ git show --abbrev-commit 90020c7b2c5e02200bc752c8cfeba91c4435588c
> 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches#n160


-- 
Regards,
Nishanth Menon
