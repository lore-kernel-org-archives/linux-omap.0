From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-bone-common: Fix mmc0 Write Protect
Date: Mon, 2 Jul 2018 23:24:19 -0700
Message-ID: <20180703062419.GB112168@atomide.com>
References: <20180702202143.25343-1-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180702202143.25343-1-robertcnelson@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: devicetree@vger.kernel.org, Drew Fustini <drew@beagleboard.org>, Faiz Abbas <faiz_abbas@ti.com>, Jason Kridner <jkridner@beagleboard.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Robert Nelson <robertcnelson@gmail.com> [180702 20:24]:
> Mainline Commit b74c2b21e1551018af53ee6c1efc051dfce2d788 added the pinmux
> settings for mmc1, however this pin (0x9a0) is routed to P9_42 on the cape
> header. Thus any BeagleBone cape that utilizes P9_42 triggers mmc0's Write
> Protect.

Thanks applying into omap-for-v4.18/fixes. I'll also add a Fixes tag for
it.

Regards,

Tony
