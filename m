From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Realtime patch on OMAP2
Date: Thu, 21 Dec 2006 10:46:07 +0100
Message-ID: <458A57DF.1020605@gmail.com>
References: <20731908.192991166666790293.JavaMail.weblogic@ep_ml29>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20731908.192991166666790293.JavaMail.weblogic@ep_ml29>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kyungmin.park@samsung.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kyungmin Park wrote:
> With Dirk Behme's mail, I try he realtime preemption patch on OMAP2

Thanks for testing :)

> Second, smc91x timeout problem
> - I found a patch in kernel-mailing list [1].
>   but I'm not sure it's correct patch. but after the patch. it's working.

All: Do we need to fix arch/arm/plat-omap/gpio.c here? [2]

> And it's another issue with ethernet irq flag value
> In clean Linus kernel has IRQF_TRIGGER_RISING. but in OMAP tree has IRQF_TRIGGER_HIGH on apollon.
> As previous mentions. IRQF_TRIGGER_HIGH is not working.

Kyungmin Park: Reading your previous post, Linus' mainline 
is okay (IRQF_TRIGGER_RISING), while our OMAP git 
(IRQF_TRIGGER_HIGH) needs fix for you? Can you test patch I 
sent some minutes ago?

Dirk

> [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=116576871105029&w=2

[2] 
http://www.ussg.iu.edu/hypermail/linux/kernel/0612.1/1036.html
