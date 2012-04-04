From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH 2/9] ARM: OMAP2+: SmartReflex: move the driver specific
 macros in include/linux/power
Date: Thu, 05 Apr 2012 00:40:01 +0530
Message-ID: <4F7C9C89.9080605@codeaurora.org>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com> <1332173578-27422-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332173578-27422-3-git-send-email-j-pihet@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Jean,

On 3/19/2012 9:42 PM, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> Move the driver specific macros from the smartreflex header file
> (arch/arm/mach-omap2/smartreflex.h) in a new header file
> include/linux/power/smartreflex.h.
>
> This change makes the SmartReflex implementation ready for the move
> to drivers/.

I wonder why someone would need a new directory under drivers/power 
where the code is not about introducing new and generic AVS framework
but it is all about OMAP specific code. What if tomorrow new generic
AVS framework comes from different chip vendor? I am sure this kind
of technology would be common in newer embedded chips.

---Trilok Soni

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
