From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Mon, 21 Jan 2013 16:32:13 +0000
Message-ID: <50FD6D8D.6030106@mimc.co.uk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, mporter@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Vaibhav / Matt

On 20/01/13 21:38, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.8-rc4.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.8-rc4/20130120122039/

<snip>

> Failing tests: needing investigation
> ------------------------------------
> 
> Boot tests:
> 
> * am335xbone: hangs after "Starting kernel"
>   - Cause unknown
>   - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.html

<snip>

> Failing tests: needing local investigation (may be due to testbed issues)
> -------------------------------------------------------------------------
> 
> Boot tests:
> 
> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>   - May be fixed now, pending retest:
>     - http://marc.info/?l=linux-omap&m=135082257727502&w=2
>   - Not yet part of the automated test suite
>   - Nishanth Menon & Vaibhav Hiremath report that it works for them
>   * May be due to an old U-boot with FDT support problems used here?
>     Pending local investigation and re-test

Does anyone know when the BeagleBone support is going to be fixed in mainline ?

I've just tried the latest linux-next git, and no joy.

However, Matt's edma-dmaengine-am33xx-v5 branch on github seems to be working:-

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc3-61978-g108da76-dirty (mpfj@mpfj-nanobone) (gcc version 4.5.4
(Buildroot 2012.11-git-00497-ge48bf89) ) #7 SMP Mon Jan 21 15:52:14 GMT 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone

Are we just waiting for Matt's DMA stuff to be accepted ?

Cheers
Mark J.
