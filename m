From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH 0/8] Flip on multiplatform support for omap2plus for v3.9
Date: Thu, 20 Dec 2012 21:11:10 -0300
Message-ID: <CALF0-+XspOix_RiNkWN7d1L9uxBZi7Zf5SDaKcx0P7P_Z3anqA@mail.gmail.com>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
 <20121220155518.GX4989@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121220155518.GX4989@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello Tony,

On Thu, Dec 20, 2012 at 12:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [121219 11:28]:
>> Hi all,
>>
>> These patches enable multiplatform support for omap2plus.
>>
>> To build and boot it against the current mainline kernel
>> you need the following:
>>
>> [PATCH 1/2] ARM: l2x0: Only set .set_debug on PL310 r3p0 and earlier
>> [PATCH 2/2] ARM: disable errata work-arounds which access secure registers
>> [GIT PULL 1/2] omap fixes for v3.8 merge window
>> [GIT PULL 2/2] omap cleanup for v3.8 merge window
>> [GIT PULL] two trivial omap build error fixes for v3.8 merge window
>> cpts: Fix build error caused by include of plat/clock.h
>

I'm trying this on my IGEP v2 board (using Javier's patches for DT).

I've applied these series on top of your branch
"omap-for-v3.8/fixes-for-merge-window-part2".

However, I'm finding some conflicts (fb.c appears in plat-omap,
some missing headers, etc.)

Could you suggest a better branch to base the series?

Thanks!

    Ezequiel
