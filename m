From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: CONFIG_PREEMPT_RT patch on Apollon (OMAP2)
Date: Tue, 28 Nov 2006 07:14:26 +0100
Message-ID: <456BD3C2.2080807@gmail.com>
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
To: kyungmin.park@samsung.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kyungmin Park wrote:
> 2. Too many loads???
>   - After booting. I think the system is too slow. and also it's unstable. After some opeartions. it's hang.

Two additional things:

- Do you converted OMAP2 timer to clocksource as well 
(timer-gp.c)? I think our clocksource patch only covers 
OMAP1 (Kevin?).

- Do yout get Cyclictest [1] to work?

Dirk

[1] http://rt.wiki.kernel.org/index.php/Cyclictest
