From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: OMAP tsc210x touchscreens?
Date: Mon, 29 Oct 2007 17:06:00 +0100
Message-ID: <fb249edb0710290906g3819c7cdkcd2f0decc57f8fd2@mail.gmail.com>
References: <4725FC94.6080808@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4725FC94.6080808@googlemail.com>
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

Hi,

On 29/10/2007, Dirk Behme <dirk.behme@googlemail.com> wrote:
>
> Because of [1] I looked into drivers/input/touchscreen/omap/ts_hx.c
> what need to be done there. And, mmh, looks like
>
> drivers/input/touchscreen/omap
>
> can/should be completely removed? I couldn't find any Kconfig using
> TOUCHSCREEN_OMAP, so touchscreen/omap will never compile?
>
> Instead, touchscreen/tsc210x_ts.c should be used? tsc2102_ts.c is
> outdated and replaced by tsc210x_ts.c now as well?

Yes, kindof, the tsc210x* files were supposed to replace tsc2101* and
tsc2102* but tsc210x completely doesn't support audio yet, and there's
probably more work to be done on it (not meaning that the tsc2101 or
tsc2102 drivers in drivers/spi/ are more complete, except audio).

Regards
