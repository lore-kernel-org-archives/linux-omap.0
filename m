From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: CONFIG_PREEMPT_RT patch on Apollon (OMAP2)
Date: Mon, 27 Nov 2006 20:09:54 +0100
Message-ID: <456B3802.1000101@gmail.com>
References: <11115895.486281164610759448.JavaMail.weblogic@ep_ml20>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11115895.486281164610759448.JavaMail.weblogic@ep_ml20>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: kyungmin.park@samsung.com, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Kyungmin Park wrote:
> As you mentioned, I tried to use CONFIG_PREEMPT_RT patch.

Great!

> But there's some issues.

Yep, CONFIG_PREEMPT_RT still looks experimental on our 
platform. Hopefully we contribute to improvement by testing it.

> 1. ethernet flags
>   - After change from IRQF_RISING to IRQF_HIGH in recent OMAP2 patch. it occurs the GPIO bug message in line 1005.
>     So I reverted IRQF_RISING as before. then it's working.

Maybe David has an idea here? [1]

Regarding ethernet I'm unsure. On OSK/OMAP1 my testcase is 
playing MP3 over NFS. While writing my previous mail, I 
never reached the end of MP3 because of NFS timeouts and 
connection losses.

Today, I tried again to get the exact error message and now 
no NFS issues any more. MP3 properly finishes.

> 2. Too many loads???
>   - After booting. I think the system is too slow. and also it's unstable. After some opeartions. it's hang.

Can't say this for OSK, feeling is same speed or even 
faster. For me, ALSA was unstable because I missed to 
convert some spinlocks to raw_spinlocks. Maybe you should 
check if you found all?

What's your testcase? For which operations does it hang?

> 3. ARMv6 support
>   - current cmpxchg support for under ARMv6 only.

Don't know anything about ARMv6.

Cheers

Dirk

[1] 
http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008270.html
