From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [FAILURE] omap4430-sdp allnoconfig
Date: Thu, 1 Aug 2013 15:01:09 -0400
Message-ID: <51FAB075.4020807@ti.com>
References: <20130801175214.GA23053@n2100.arm.linux.org.uk>
 <51FAA4C6.10203@ti.com> <20130801182707.GB23053@n2100.arm.linux.org.uk>
 <51FAA985.3000809@ti.com> <51FAAA31.6020903@codeaurora.org>
 <51FAAAFD.6000706@codeaurora.org> <51FAAD73.3030103@ti.com>
 <20130801185956.GK8868@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130801185956.GK8868@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 01 August 2013 02:59 PM, Stephen Boyd wrote:
> On 08/01, Santosh Shilimkar wrote:
>> This one looks fine for me. Can you send above in
>> a proper patch ? Let me know if you want me to
>> send it.
>>
> 
> Here's a proper patch. Olof, can you please apply this on top of
> the merge (and maybe you can fix the merge again to handle the
> HAVE_CAN problem I mentioned earlier).
> 
> ---8<---
> Subject: [PATCH] ARM: OMAP2+: Fix fallout from localtimer divorce and SMP=n
> 
> A recent patch ef3160c (ARM: OMAP2+: Divorce from local timer
> API, 2013-03-04) broke the omap build when SMP=n because the TWD
> functions are only compiled on SMP=y builds. Stub out the TWD
> calls when the TWD isn't built in to to keep everything building.
> 
> arch/arm/mach-omap2/built-in.o: In function
> `omap4_local_timer_init':
> dss-common.c:(.init.text+0x1d90): undefined reference to
> `twd_local_timer_register'
> 
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
Thanks Stephen
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
