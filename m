From: Kevin Hilman <khilman@mvista.com>
Subject: Re: CONFIG_PREEMPT_RT patch on Apollon (OMAP2)
Date: Mon, 27 Nov 2006 23:08:00 -0800
Message-ID: <456BE050.5050404@mvista.com>
References: <11115895.486281164610759448.JavaMail.weblogic@ep_ml20>
	<456BD3C2.2080807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <456BD3C2.2080807@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme wrote:
> Kyungmin Park wrote:
>> 2. Too many loads???
>>   - After booting. I think the system is too slow. and also it's
>> unstable. After some opeartions. it's hang.
> 
> Two additional things:
> 
> - Do you converted OMAP2 timer to clocksource as well (timer-gp.c)? I
> think our clocksource patch only covers OMAP1 (Kevin?).

Correct, only OMAP1 clocksource/clockevent done so far.

Kevin
