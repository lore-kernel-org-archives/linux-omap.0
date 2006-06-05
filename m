From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Plea for MMC spec owners
Date: Tue, 06 Jun 2006 00:40:01 +0200
Message-ID: <4484B2C1.6020100@drzeus.cx>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE41CF48@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE41CF48@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Khasim, Syed" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Khasim, Syed wrote:
> Hi Pierre,
>
> Regarding 2GB, the MMC specification doesn't state any thing clearly as
> the SD spec does.
>
>   

That's too bad as I was hoping we could avoid guesswork. :-/

> As per my understanding, MMC (of all sizes) by default should be set to
> operate in 512B (mandatory). This is true for both read and write. With
> this default setup, I feel MMC card (<=2GB) should work as is with BLEN
> set to 512.
>   

That is my feeling as well. But it would have been nice to back it up
with an official spec.

> However, if the size of MMC is greater than 2GB then it switches to
> sector access mode (<=2GB operates in byte access) and we are supposed
> to read from EXT_CSD register for getting the density of card. I was
> wondering if for some reason on some of the cards it's switching to this
> mode and therefore it's not consistent across all the 2GB MMCs.
>
>   

This voodoo you speak of is rather unknown to us since we lack a real
MMC4 spec. ;-)

Rgds
Pierre
