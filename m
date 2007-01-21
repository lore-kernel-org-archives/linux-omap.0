From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: early printk
Date: Sun, 21 Jan 2007 17:32:48 +0100
Message-ID: <45B395B0.9050702@googlemail.com>
References: <20070118101336.18C6B80778@linux.omap.com><0AB0CB5257FF3C43A27E201CC8AADA8602D085A0@dnce02.ent.ti.com>	<20070118170721.GB14425@atomide.com>	<EA12F909C0431D458B9D18A176BEE4A50969C4F1@dlee02.ent.ti.com>
	<0AB0CB5257FF3C43A27E201CC8AADA8602D09073@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <0AB0CB5257FF3C43A27E201CC8AADA8602D09073@dnce02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Saint-Etienne, Eric" <e-saint-etienne@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Saint-Etienne, Eric wrote:
>>>Did someone already released an early-printk patch?
>>
>>[...] Or it's a straight forward as CONFIG_DEBUG_LL
>>
> 
> 
> CONFIG_DEBUG_LL doesn't work for me, have to debug.

Just guessing, don't know OMAP2:

On OMAP1 we fixed [1] to get CONFIG_DEBUG_LL to work again. 
Maybe it's worth checking anything similiar on OMAP2, too?

What does "CONFIG_DEBUG_LL doesn't work for me" mean? No 
output at all?

Cheers

Dirk

[1] 
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=0f0421b9c44c558ee2c8c58bd2f86231f93d3ed6
