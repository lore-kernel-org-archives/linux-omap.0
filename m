From: Roger Quadros <rogerq@ti.com>
Subject: Re: [GIT PULL] omap-gpmc fixes for v4.7 rc cycle
Date: Mon, 20 Jun 2016 10:22:59 +0300
Message-ID: <576799D3.8000107@ti.com>
References: <57626DF2.70907@ti.com> <20160619060106.GB16376@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160619060106.GB16376@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, arm@kernel.org, SebastienOcquidant@Eaton.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Olof,

On 19/06/16 09:01, Olof Johansson wrote:
> On Thu, Jun 16, 2016 at 12:14:26PM +0300, Roger Quadros wrote:
>> Hi Arnd/Olof,
>>
>> The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:
>>
>>   Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/rogerq/linux.git tags/gpmc-omap-fixes-for-v4.7
>>
>> for you to fetch changes up to 8f50b8e57442d28e41bb736c173d8a2490549a82:
>>
>>   memory: omap-gpmc: Fix omap gpmc EXTRADELAY timing (2016-06-16 11:43:48 +0300)
>>
>> ----------------------------------------------------------------
>> OMAP-GPMC: Fixes for for v4.7-rc cycle:
>>
>> - Fix omap gpmc EXTRADELAY timing. The DT provided timings
>> were wrongly used causing devices requiring extra delay timing
>> to fail.
> 
> So, our fixes branch is at 4.7-rc1, so now you force us to bring in -rc3 just
> because of this one patch. That's a little annoying. Base your branch on an
> older release if it makes sense, and/or take a look at what release our
> branch is on if you think of it. :)

My apologies for not checking that your fixes branch is at v4.7-rc1.

> 
> It's not a huge deal but the main disadvantage is that git request-pull
> sometimes gets confused of what's actually in the branch and not, so it might
> produce an incorrect pull request. We normally don't have to deal with that on
> fixes, only what we stage for the merge windows.
> 
> Anyhow, I've merged this for now.
> 

Thanks a lot :).

cheers,
-roger
