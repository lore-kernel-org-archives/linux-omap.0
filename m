From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3 3/6] OMAP3+: use DPLL's round_rate when setting rate
Date: Wed, 28 Sep 2011 10:50:44 -0500
Message-ID: <4E834254.9040802@ti.com>
References: <1316195281-14988-1-git-send-email-jon-hunter@ti.com>
	<alpine.DEB.2.00.1109280059380.4399@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1109280059380.4399@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 9/28/2011 2:02, Paul Walmsley wrote:
> Hi,
>
> On Fri, 16 Sep 2011, Jon Hunter wrote:
>
>> From: Mike Turquette<mturquette@ti.com>
>>
>> omap3_noncore_dpll_set_rate uses omap2_dpll_round_rate explicitly.  Instead
>> use the struct clk pointer's round_rate function to allow for DPLL's with
>> special needs.
>>
>> Also the rounded rate can differ from target rate, so to better reflect
>> reality set clk->rate equal to the rounded rate when setting DPLL frequency.
>> This avoids issues where the DPLL frequency is slightly different than what
>> debugfs clock tree reports using the old target rate.
>>
>> An example of both of these needs is DPLL_ABE on OMAP4 which can have a 4x
>> multiplier on top of the usual MN dividers depending on register settings.
>> This requires a special round_rate function that might yield a rate
>> different from the initial target.
>>
>> Signed-off-by: Mike Turquette<mturquette@ti.com>
>> Signed-off-by: Jon Hunter<jon-hunter@ti.com>
>
> The two separate changes in this patch have been separated out into two
> patches - both included below.  Please let me know if you have any
> comments; otherwise, I'll queue for 3.2.

Yes, looks good to me. Thanks. Jon
