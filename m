From: Tony Lindgren <tony@atomide.com>
Subject: Build failure with verify size in next-20171102
Date: Thu, 2 Nov 2017 12:30:27 -0700
Message-ID: <20171102193027.GB28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Russeell,

I think you're already aware of the build failure caused by commit
078c0927485e ("ARM: verify size of zImage"), but here's info just
in case.

arm-unknown-linux-musleabi-ld.bfd: error: zImage file size is incorrect
make[2]: *** [arch/arm/boot/compressed/Makefile:185: arch/arm/boot/compressed/vmlinux] Error 1
make[1]: *** [arch/arm/boot/Makefile:64: arch/arm/boot/compressed/vmlinux] Error 2
make: *** [arch/arm/Makefile:335: zImage] Error 2

Other than that I was surprised that next actually booted for me
after a few week break with Linux next! :)

Regards,

Tony
