From: Nishanth Menon <nm@ti.com>
Subject: Re: next-20150511 / omap2-mcspi: regression for sdp4430 boot
Date: Mon, 11 May 2015 14:00:08 -0500
Message-ID: <5550FC38.6020801@ti.com>
References: <5550DDCB.8010303@ti.com> <20150511170742.GA6616@deathray>
 <5550F47C.1030902@ti.com> <20150511183032.GA8085@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150511183032.GA8085@deathray>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michael Welling <mwelling@ieee.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-next <linux-next@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/11/2015 01:30 PM, Michael Welling wrote:
> On Mon, May 11, 2015 at 01:27:08PM -0500, Nishanth Menon wrote:
>> On 05/11/2015 12:07 PM, Michael Welling wrote:
>>> On Mon, May 11, 2015 at 11:50:19AM -0500, Nishanth Menon wrote:
>>>> Hi,
>>>>
>>>> SDP4430 uses a SPI based network chip ks8851.
>>>>
>>>> next-20150508:
>>>> https://github.com/nmenon/kernel-test-logs/blob/next-20150508/omap2plus_defconfig/sdp4430.txt
>>>>
>>>> However, next-20150511:
>>>> https://github.com/nmenon/kernel-test-logs/blob/next-20150511/omap2plus_defconfig/sdp4430.txt
>>>>
>>>
>>> I will look into this but it is going to be difficult to debug with access to the hardware.
>>> This is what I get for changing a driver that effects so many SoCs.
>>>
>>
>> Let me know if there is any test patch you'd want me to run. The board
>> is on a remote "board farm" which most of TI folks have access to as
>> well.. So, if you need anything run, just send out a debug patch OR a
>> potential fix and we can help try it out and provide logs back for
>> your debug.
> 
> Okay.
> 
> It looks like you revert the patches in the wrong order above.
> 
> The GPIO patch should apply after the transfer_one patch so it should
> logically be reverted in the reverse order.
> 
Apologies on a slow response, was tracking another LPAE regression down.

I did do that -> but logged it in reverse - unfortunately it seems to
have caused a little more confusion :(. is there something else you'd
like me to do?

git log  next-20150508..next-20150511 drivers/spi
Tells me:

commit bc7f9bbc80bcc77745b3f54ec4e7103e3e142bb9
Author: Michael Welling <mwelling@ieee.org>
Date:   Fri May 8 13:31:01 2015 -0500

    spi: omap2-mcspi: Add gpio_request and init CS

    If GPIO chip select is specified, request the GPIO in the setup
function
    and release it in the cleanup function.

    Signed-off-by: Michael Welling <mwelling@ieee.org>
    Signed-off-by: Mark Brown <broonie@kernel.org>

commit b28cb9414db9f8e42ac18c9e360e4e99cda42489
Author: Michael Welling <mwelling@ieee.org>
Date:   Thu May 7 18:36:53 2015 -0500

    spi: omap2-mcspi: Switch driver to use transfer_one

    Switches from transfer_one_message to transfer_one to prepare
driver for
    use of GPIO chip selects.

    Signed-off-by: Michael Welling <mwelling@ieee.org>
    Signed-off-by: Mark Brown <broonie@kernel.org>



my tested git log looks as follows: (redid it just to be sure):

a4617b41e04c Revert "spi: omap2-mcspi: Switch driver to use transfer_one"
http://paste.ubuntu.org.cn/2595136

b49011271c7f Revert "spi: omap2-mcspi: Add gpio_request and init CS"
http://paste.ubuntu.org.cn/2595142


012034602bd6 HACK: Makefile: Build a uImage with dtb already appended
f17107cb8886 Add linux-next specific files for 20150511

012034602bd6 commit is
https://github.com/nmenon/linux-2.6-playground/commit/177f5f71b3f2 ->
for legacy platforms needing uImage based booting.

-- 
Regards,
Nishanth Menon
