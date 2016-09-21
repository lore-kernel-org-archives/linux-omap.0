From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 5/9] dmaengine/ARM: omap-dma: Fix the DMAengine compile
 test on non OMAP configs
Date: Wed, 21 Sep 2016 10:34:34 +0300
Message-ID: <498a255b-27a7-20fe-9736-ede2b5bdebe6@ti.com>
References: <20160916083324.29133-1-peter.ujfalusi@ti.com>
 <20160916083324.29133-6-peter.ujfalusi@ti.com>
 <20160921035131.GD2609@localhost> <20160921035326.GF2609@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160921035326.GF2609@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: arnd@arndb.de, tony@atomide.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/21/16 06:53, Vinod Koul wrote:
> On Wed, Sep 21, 2016 at 09:21:32AM +0530, Vinod Koul wrote:
>> On Fri, Sep 16, 2016 at 11:33:20AM +0300, Peter Ujfalusi wrote:
>>> The DMAengine driver for omap-dma use three function calls from the
>>> plat-omap legacy driver. When the DMAengine driver is built when ARCH_O=
MAP
>>> is not set, the compilation will fail due to missing symbols.
>>> Add empty inline functions to allow the DMAengine driver to be compiled
>>> with COMPILE_TEST.
>>
>> Peter,
>>
>> This should be before you enable COMPILE_TEST otherwise build will break!
> =

> Ah never mind, you have three drivers in this series so I think this is f=
ine
> before the omap one :)

Yep, patch 1-4 is for eDMA, patch 5-6 is for omap-dma and the remaining is =
for
ti-dma-crossbar.

I wanted to have them separate (including when I enable the COMPILE_TEST) so
we can revert easily if needed.

If I move the 'enable COMPILE_TEST' patches at the end of the series, I thi=
nk
I will still have them as separate as they are enabling the test for three
different driver.

-- =

P=E9ter
