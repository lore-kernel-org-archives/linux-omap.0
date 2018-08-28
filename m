From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix file permission for am335x-osd3358-sm-red.dts
Date: Tue, 28 Aug 2018 08:53:51 -0700
Message-ID: <20180828155351.GN7523@atomide.com>
References: <20180828153816.1152-1-neeraj.dantu@octavosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180828153816.1152-1-neeraj.dantu@octavosystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Neeraj Dantu <dantuguf14105@gmail.com>
Cc: devicetree@vger.kernel.org, Jason Kridner <jkridner@gmail.com>, Neeraj Dantu <neeraj.dantu@octavosystems.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Neeraj Dantu <dantuguf14105@gmail.com> [180828 15:42]:
> OSD3358-SM-RED is a dev board for OSD335x System-in-Package(SiP) devices from
> Octavo Systems.
> 
> This board family can be indentified by the A335BNLTOS00 in the at24 eeprom:
> A2: [aa 55 33 ee 41 33 33 35  42 4e 4c 54 4f 53 30 30 |.U3.A335BNLTOS00|]
> 
> https://octavosystems.com/octavo_products/osd3358-sm-red/

Hmm can you please repost with a correct patch description?
Something along the lines of:

Fix wrong mode for dts file added by commit bb3e3fbbac86
("ARM: dts: Add DT support for Octavo Systems OSD3358-SM-RED
based on TI AM335x").

Regards,

Tony

> Signed-off-by: Neeraj Dantu <neeraj.dantu@octavosystems.com>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Robert Nelson <robertcnelson@gmail.com>
> CC: Jason Kridner <jkridner@gmail.com>
> ---
> Changes:
> - Fix file permission
> ---
>  arch/arm/boot/dts/am335x-osd3358-sm-red.dts | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 => 100644 arch/arm/boot/dts/am335x-osd3358-sm-red.dts
> 
> diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
> old mode 100755
> new mode 100644
> -- 
> 2.7.4
> 
