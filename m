From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Tue, 09 Jul 2013 15:02:31 +0200
Message-ID: <51DC09E7.1070302@denx.de>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1366024808-4691-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Roger,

On 04/15/2013 01:20 PM, Roger Quadros wrote:
> On Beagle xM Rev. Ax/Bx, the USB power enable GPIO logic is
> reversed when compared to other revisions i.e. it is
> active high instead of active low.
> 
> Use the beagle_config.usb_pwr_level flag correctly so that
> the power regulator can be configured at runtime.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

I'm currently trying to use an SMSC95xx USB ethernet adapter on the
OMAP3 Beagleboard (old one "Beagle Rev C1/C2/C3") via the OMAP EHCI
controller. And am testing this by trying to mount the rootfs via NFS.
What I see is that the NFS mounting stalls/hangs most of the time quite
early in the mount process:

[    6.425689] VFS: Mounted root (nfs filesystem) on device 0:12.
[    6.435485] devtmpfs: mounted
[    6.440002] Freeing unused kernel memory: 384K (c077a000 - c07da000)
INIT: version 2.88 booting
Starting udev
[  188.311309] nfs: server 10.0.0.152 not responding, still trying
[  188.317687] nfs: server 10.0.0.152 not responding, still trying
...

Only very seldom the rootfs can be mounted successfully to the prompt.

I'm using latest kernel.org for this (git ID d2b4a646 also tested with
v3.10 release). This is with DT-enabled booting and without-DT (same
problem). I also tested some older Linux kernel versions and it fails
there as well. Only v3.2.40 seems to be able to mount this rootfs via
NFS reliably (approx. 10 times success).

Is this a known issue on the Beagleboard? Do you have any ideas what
might cause such an issue (unreliable USB connection, hangup of NFS
mounting)? Any hints/links appretiated.

Thanks,
Stefan
