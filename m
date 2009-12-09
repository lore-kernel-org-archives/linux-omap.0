From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Smartreflex: Avoid unnecessary spam
Date: Thu, 10 Dec 2009 01:23:09 +0200
Message-ID: <20091209232309.GA9514@nokia.com>
References: <1260281775-30361-1-git-send-email-tero.kristo@nokia.com>
 <87y6lbsprl.fsf@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31470 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758647AbZLIXXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 18:23:35 -0500
Content-Disposition: inline
In-Reply-To: <87y6lbsprl.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Dec 10, 2009 at 12:15:26AM +0100, ext Kevin Hilman wrote:
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Current warning messages will be constantly printed out during normal operation
>> if smartreflex autocompensation is disabled.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
>Agreed that these warnings are spam, but I think they should be
>replaced by some one-time warning so at least there's a hint someplace
>that SR is not actually being done on a platfrom.

well, there's printk_once()

include/linux/kernel.h:

250 /*       
251  * Print a one-time message (analogous to WARN_ONCE() et al):
252  */                  
253 #define printk_once(x...) ({                    \
254         static bool __print_once = true;        \
255                                                 \
256         if (__print_once) {                     \
257                 __print_once = false;           \
258                 printk(x);                      \
259         }                                       \
260 })

and WARN_ONCE()

include/asm-generic/bug.h:

125 #define WARN_ONCE(condition, format...) ({                      \
126         static int __warned;                                    \
127         int __ret_warn_once = !!(condition);                    \
128                                                                 \
129         if (unlikely(__ret_warn_once))                          \
130                 if (WARN(!__warned, format))                    \
131                         __warned = 1;                           \
132         unlikely(__ret_warn_once);                              \
133 })

I guess printk_once() is better.

-- 
balbi
