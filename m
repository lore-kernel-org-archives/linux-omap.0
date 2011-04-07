From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] nohz: delay going tickless under CPU load to favor deeper
 C states
Date: Thu, 07 Apr 2011 12:57:06 -0700
Message-ID: <4D9E1712.5090600@linux.intel.com>
References: <1302200311-24263-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1302200311-24263-1-git-send-email-khilman@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, Len Brown <lenb@kernel.org>, Nicole Chalhoub <n-chalhoub@ti.com>, Vincent Bour <v-bour@ti.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On 4/7/2011 11:18 AM, Kevin Hilman wrote:
> From: Nicole Chalhoub<n-chalhoub@ti.com>
>
> While there is CPU load, continue the periodic tick in order to give
> CPUidle another opportunity to pick a deeper C-state instead of
> spending potentially long i


so I don't really like this patch. It's actually a pretty bad hack (I'm 
sure it'll work somewhat)
[and I mean that in the most positive sense of the word ;-) ]

what we really need instead, and this is inside cpuidle, is the option 
to set a timer when we enter the non-deepest C state,
so that if that timer fires we then reevaluate.
The duration of that timer will be dependent on the C state (so should 
come from the C state structure of the state we pick).

For the most shallow one this will be a relatively short time, but for 
the deepest-but-one this might be a lot longer time.


your patch abuses a completely different, unrelated timer for this, with 
a pretty much unspecified frequency, that also has other side effects 
that we probably don't want.


it shouldn't be hard to do the right thing instead and make it a 
separate timer with a per C state timeout.

(and I would say a default timeout of 10x the break even time that we 
already have in the structure)
