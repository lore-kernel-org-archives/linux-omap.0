From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 0/3] OMAP MMU framework patches
Date: Tue, 20 Feb 2007 13:51:10 +0530
Message-ID: <5d5443650702200021x304d2004jb9e98d186684608b@mail.gmail.com>
References: <5d5443650702192251k1cf06891x4414b0188ede7216@mail.gmail.com>
	<20070220095420.5d93f64c.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070220095420.5d93f64c.Hiroshi.DOYU@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Doyu-San,

On 2/20/07, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:

> First off, though this code was enough tested with N800(omap2), it can
> _break_ omap1 compatibility. So we should make sure that this would work
> fine with omap1, at least with some dspgw test programs, preferably N770.

I don't have access to OMAP1 or N770. I only have H4, 2430 and soon OMAP3.

>
> Secondly, this MMU framework can be used with iva and camera
> driver. So kernel config should be separated as CONFIG_OMAP_MMU_FRW or
> something.

Yes, I am aware of this. It is on my TO-DO list, including seq_bit
simplification.

>
> Thirdly, it's necessary to make sure that this can be compiled as
> kernel module, along with dspgw and mailbox compiled as kernel module.

Yes, I wanted to push this drivers to mailing list so that others can
start reviewing it, but again I am going to make it compile as module.
So, expect patches on above items.

>
> For reference I've attached the patch for omap1, but I havn't had
> enough time to test this with N770, probably something is still
> missing.

Thanx. Let's see what Tony suggest. If he wants to me to integrate all
above changes and re-produce the patches OR submit them as incremental
patches.

-- 
--Trilok Soni
