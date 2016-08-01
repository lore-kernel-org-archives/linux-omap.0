From: Roger Quadros <rogerq@ti.com>
Subject: Re: [GIT PULL] omap-gpmc changes for v4.8 merge window
Date: Mon, 1 Aug 2016 11:51:17 +0300
Message-ID: <edc2a5dc-c831-b05a-5745-c1e361441b41@ti.com>
References: <5770E51B.8040206@ti.com> <20160705052111.GO1669@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160705052111.GO1669@localhost>
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
Cc: Tony Lindgren <tony@atomide.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-omap <linux-omap@vger.kernel.org>, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/07/16 08:21, Olof Johansson wrote:
> On Mon, Jun 27, 2016 at 11:34:35AM +0300, Roger Quadros wrote:
>> Hi Arnd/Olof,
>>
>> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
>>
>>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/rogerq/linux.git gpmc-omap-for-v4.8
>>
>> for you to fetch changes up to 32dd625a9f3541ee6d390f12f810f28531d016c7:
>>
>>   memory: omap-gpmc: Move gpio functions out of #ifdef CONFIG_OF (2016-06-17 10:26:48 +0300)
>>
>> ----------------------------------------------------------------
>> OMAP-GPMC: driver updates for v4.8
>>
>> * Make GPMC driver non modular as it is going to
>> be built-in only till arch/arm/mach-omap2 users
>> are removed.
>>
>> * Fix build if CONFIG_OF is not defined.
> 
> Merged into next/drivers.
> 
>>
>> ----------------------------------------------------------------
>> Paul Gortmaker (1):
>>       memory: omap-gpmc: make it explicitly non-modular
>>
>> Roger Quadros (1):
>>       memory: omap-gpmc: Move gpio functions out of #ifdef CONFIG_OF
>>
>>  drivers/memory/omap-gpmc.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
> 
> Tip for the future: If you redirect the output through cat, you get the
> diffstat at 80 character lines.

Thanks :).

cheers,
-roger
