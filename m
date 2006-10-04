From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: Pending September patches
Date: Wed, 4 Oct 2006 17:55:16 +0200
Message-ID: <fb249edb0610040855n61953dc7s8a23c2683aaeb825@mail.gmail.com>
References: <4523B6F8.3020800@gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4523B6F8.3020800@gmail.com>
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
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 04/10/06, Dirk Behme <dirk.behme@googlemail.com> wrote:
> Hi,
>
> my list of pending OMAP patches for September 2006:
>
> 1. [PATCH] MTD patch, including the latest modifications an
> offical upgrades for MTD
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007889.html
>
> Note: Is this still necessary or does 2.6.18 contain it
> automatically?
>
> 2.[PATCH 1/4] TSC2102 main SPI driver
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007929.html
>
> 3. [PATCH 2/4] TSC2102 Touchscreen
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007931.html
>
> Note: What's about "[PATCH 3/4] TSC2102 hwmon driver"?

The code from it was included in "[PATCH 1/4] TSC2102 main SPI driver".

>
> 4. [PATCH 4/4] TSC2102 OMAP audio driver
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007930.html
>
> 5. [PATCH] Request OMAP MMC Write-protect pin
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007976.html
>
> 6. LCD output from decompressor
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007977.html
>
> Note: Should this be applied or only stay on the list for
> interested people?

It was meant to stay on the list for interested people. One part of
the patch changes the 8x8 font to 8x16 which also affects Acorn
RiscPC. The other part is non-intrusive but estimated interested
people are few.

Greetings,
-- 
balrog 2oo6
