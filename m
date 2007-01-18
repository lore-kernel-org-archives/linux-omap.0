From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: early printk
Date: Thu, 18 Jan 2007 19:06:02 +0100
Message-ID: <45AFB70A.4010006@googlemail.com>
References: <20070118101336.18C6B80778@linux.omap.com><0AB0CB5257FF3C43A27E201CC8AADA8602D085A0@dnce02.ent.ti.com>	<20070118170721.GB14425@atomide.com>
	<EA12F909C0431D458B9D18A176BEE4A50969C4F1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A50969C4F1@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Saint-Etienne, Eric" <e-saint-etienne@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Woodruff, Richard wrote:
>>>Did someone already released an early-printk patch?
>>
>>Do you mean something other than low level printk?
>>
>>Low level printk should work, see CONFIG_DEBUG_LL and
>>CONFIG_OMAP_LL_DEBUG_UART1 (or 2 or 3).
> 
> 
> Seems like there has been some noise around some RT'ish changes + Timers
> breaking some early printk's on the other lists.  I've not tried a build
> recently to see if it affects OMAP at all.

At least on OSK (OMAP1) CONFIG_DEBUG_LL works with recent 
git. Have no OMAP2 to test though.

Dirk
