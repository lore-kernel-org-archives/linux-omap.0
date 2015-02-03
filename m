From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: gpmc: Fix writing in gpmc_cs_set_memconf
Date: Tue, 3 Feb 2015 11:30:17 +0200
Message-ID: <54D09529.2000803@ti.com>
References: <1422131320-1018-1-git-send-email-semen.protsenko@globallogic.com> <54C60A3A.1090008@ti.com> <20150202170827.GD9418@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150202170827.GD9418@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Semen Protsenko <semen.protsenko@globallogic.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/02/15 19:08, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [150126 01:38]:
>> On 24/01/15 22:28, Semen Protsenko wrote:
>>> Some GPMC_CONFIG7 register bits marked as "RESERVED", means they
>>> shouldn't be overwritten. A typical approach to handle such bits called
>>> "Read-Modify-Write". Writing procedure used in gpmc_cs_set_memconf()
>>> utilizes RMW technique, but implemented incorrectly. Due to obvious typo
>>> in code read register value is being rewritten by another value, which
>>> leads to loss of read RESERVED bits. This patch fixes this.
>>>
>>> While at it, replace magic numbers with named constants to improve code
>>> readability.
>>>
>>> Signed-off-by: Semen Protsenko <semen.protsenko@globallogic.com>
>>
>> This is much nicer.
>>
>> Acked-by: Roger Quadros <rogerq@ti.com>
> 
> Roger will queue this so:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
Thanks.
Patches 1 and 2 queued for v3.21.
https://github.com/rogerq/linux/tree/for-v3.21/gpmc-omap

cheers,
-roger
