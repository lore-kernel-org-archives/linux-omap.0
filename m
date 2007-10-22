From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: fix default sys_ck.rate for boot-time
 DPLLdetection
Date: Mon, 22 Oct 2007 15:46:52 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0710221546050.30088@utopia.booyaka.com>
References: <20071019211415.183990583@mvista.com>
	<1193037864.29349.261.camel@localhost.localdomain>
	<3B6D69C3A9EBCA4BA5DA60D9130274290249C536@dlee13.ent.ti.com>
	<471CD547.6090206@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <471CD547.6090206@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, 22 Oct 2007, Kevin Hilman wrote:

> The easier fix is to simply add omap2_sys_clk_recalc() as in the
> following patch (which also reverts my previous patch.)  If that seems
> reasonable, I'll submit it.

I would prefer this second patch; it allows sys_ck to be calculated 
dynamically based on osc_ck.


- Paul
