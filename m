From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH 02/26] ARM: OMAP: dmtimer: Add comments on OMAP1 clock
 framework
Date: Wed, 7 May 2014 16:48:33 -0500
Message-ID: <536AAA31.6080905@ti.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com> <1398375849-6017-3-git-send-email-joelf@ti.com> <20140507152004.GC9502@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140507152004.GC9502@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 05/07/2014 10:20 AM, Tony Lindgren wrote:
> * Joel Fernandes <joelf@ti.com> [140424 14:44]:
>> OMAP1 doesn't support clock framework, add a comment where needed
>> and correct a FIXME.
> 
> This is at least a wrong comment, the original comment seems right
> to me.

Can you elaborate a bit more please on the wrongness of the comment?

I can change the comment to say "common clock" instead of "clock" if
that's the only problem here.

 thanks,

-Joel
