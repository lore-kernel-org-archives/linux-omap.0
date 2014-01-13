From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/2] ARM: DRA7XX/AM43XX build fixes
Date: Mon, 13 Jan 2014 19:13:20 +0200
Message-ID: <52D41EB0.9010603@ti.com>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
 <20140113162412.GF26950@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140113162412.GF26950@saruman.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/13/2014 06:24 PM, Felipe Balbi wrote:
> On Fri, Jan 10, 2014 at 11:57:28AM +0200, Tero Kristo wrote:
>> The move of clock code from mach-omap2 to drivers/clk/ti introduces
>> a couple of new build errors with AM43XX/DRA7XX only builds. The
>> following patches address these issues by modifying the Kconfig + Makefile
>> under mach-omap2.
>>
>> Also, it seems DRA7XX only build is not possible at the moment, added
>> patch #2 to fix this.
>
> looks like we still need some extra patches since OMAP2-only builds
> still fail :-(
>
> Also omap1_defconfig fails miserably :-(
>
> hoping this can still get fixed in time for 3.14 :-s

Yeah, should be simple enough to fix those... Will look at these tomorrow.

Just wondering, who cares about omap1 / omap2 anyway these days? :) 
Basically I overlooked both with the Makefile setup I did.

-Tero
