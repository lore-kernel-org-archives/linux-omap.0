From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 30 Oct 2012 10:55:34 +0000
Message-ID: <508FB226.20604@mimc.co.uk>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 30/10/12 02:36, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.7-rc3.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc3/20121028162003/
> 
> 
> Passing tests
> -------------
> 
> Boot to userspace: 2420n800, 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
>                    4430es2panda, 5912osk, am335xbone
> 
> PM ret/off, suspend + dynamic idle: (none)
> 
> 
> Failing tests: fixed by posted patches
> --------------------------------------
> 
> Boot tests:
> 
> * 2430sdp: vfp_reload_hw oops during MMC initialization
>   - Kernel attempts to save FP registers that don't exist; fix posted:
>     - http://www.spinics.net/lists/arm-kernel/msg200646.html
>     - added to rmk's patch system as 7566/1
> 
> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>   - Due to GPMC missing support for DT
>   - Temporary workaround at http://www.spinics.net/lists/arm-kernel/msg200787.html
>   - May be fixed now, pending retest:
>     - http://marc.info/?l=linux-omap&m=135082257727502&w=2

At what point is booting from MMC on the BeagleBone going to start working ?

I only ask, since, by default, a new BeagleBone is setup to boot from MMC, so anyone testing a new
kernel will probably expect the same setup to work.

Cheers
Mark JACKSON
