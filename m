From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: OMAP baseline test results for v3.7-rc5
Date: Fri, 16 Nov 2012 08:47:55 +0100
Message-ID: <20121116074754.GA25218@netboy.at.omicron.at>
References: <alpine.DEB.2.00.1211121921160.12551@utopia.booyaka.com>
 <50A26FC6.4070201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <50A26FC6.4070201@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Igor Mazanov <i.mazanov@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 13, 2012 at 08:05:26PM +0400, Igor Mazanov wrote:
> Paul Walmsley wrote:
> >
> >* AM335x Beaglebone: omap2plus_defconfig kernels don't boot
> >  - May be fixed now, pending retest:
> >    - http://marc.info/?l=linux-omap&m=135082257727502&w=2
> >  - Not yet part of the automated test suite
> >  * May be due to an old U-boot with FDT support problems used here?
> >    Pending local investigation and re-test
> 
> I have the same result with omap2plus_defconfig and kernel 3.7.0-rc5. I dumped
> the kernel log buffer via JTAG and can send this log if it could be useful.

I just got my BeagleBone replaced via RMA, and so I could try a fresh
build of 3.7.0-rc5 with omap2plus_defconfig. It works just fine for me.

A few details:

U-Boot SPL 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)
U-Boot 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)

 setenv ipaddr 192.168.0.77
 setenv serverip 192.168.0.12
 setenv netmask 255.255.255.0
 setenv bootargs console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=16384 earlyprintk=serial
 tftp 81000000 uImage
 tftp 82000000 beaglebone-initrd.gz
 tftp 80000000 am335x-bone.dtb
 bootm 81000000 - 80000000

So I guess just using a recent u-boot will fix whatever issues you are
seeing.

Thanks,
Richard
