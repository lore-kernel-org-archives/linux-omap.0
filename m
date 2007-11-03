From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH 01/14] MMC: OMAP: Introduce new structs for mmc multislot
 support
Date: Sat, 03 Nov 2007 17:45:05 -0400
Message-ID: <472CEBE1.8010008@indt.org.br>
References: <46F28BA8.9060409@indt.org.br> <47282C21.20604@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <47282C21.20604@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Khem Raj <kraj@mvista.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

ext Khem Raj wrote:
> Carlos Aguiar wrote:
>
> >> +
> >> +    mmc->caps = MMC_CAP_BYTEBLOCK | MMC_CAP_MULTIWRITE |
> >> +            MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
>
Hi Khem,

Well, according with commit 255d01af9a990fd5166f04ed0cc0b30b7b67e81e [1]
from Linux-OMAP tree, the BYTEBLOCK capability was removed by Pierre
Ossman.

I've to update this patch and I'll resend it asap with BYTEBLOCK
capability removed.

BR,

Carlos.

[1]
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=255d01af9a990fd5166f04ed0cc0b30b7b67e81e

>
> MMC_CAP_BYTEBLOCK is new define which is used here but not defined.
> Probably it should be defined in ./include/linux/mmc/host.h  ? or is it
> in one of remaining patches.
>
> -Khem
>
> -- 
> Carlos Eduardo Aguiar
> Nokia Institute of Technology - INdT
> Open Source Mobile Research Center - OSMRC - Manaus
> Core Team
> Phone: +55 92 2126-1079
> Mobile: +55 92 8127-1797
> E-mail: carlos.aguiar@indt.org.br
>
