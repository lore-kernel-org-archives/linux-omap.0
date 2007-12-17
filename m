From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Remove omap_sram_idle()
Date: Mon, 17 Dec 2007 10:25:25 -0800
Message-ID: <20071217182525.GH7388@atomide.com>
References: <11977918242059-git-send-email-vivek.kutal@celunite.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742902CC143D@dlee13.ent.ti.com>
	<47661618.9030405@celunite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <47661618.9030405@celunite.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vivek Kutal <vivek.kutal@celunite.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Vivek Kutal <vivek.kutal@celunite.com> [071216 22:23]:
> Woodruff, Richard wrote:
>>> 	This patch removes omap_sram_idle().
>>>     
>>
>> Why?
>>
>>   
> The function called in pm_idle is omap_sram_suspend, omap_sram_idle() is 
> not used anywhere in omap1.
> previously discussed here 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-September/011422.html

Indeed, this code seems to be dead code nowadays :) Pushing today.

Tony
