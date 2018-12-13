From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] ARM: omap2: remove unnecessary boot_lock
Date: Thu, 13 Dec 2018 09:05:48 -0800
Message-ID: <20181213170548.GP6707@atomide.com>
References: <E1gXPaa-00063v-L6@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1gXPaa-00063v-L6@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King <rmk+kernel@armlinux.org.uk> [181213 11:55]:
> The boot_lock is something that was required for ARM development
> platforms to ensure that the delay calibration worked properly.  This
> is not necessary for modern platforms that have better bus bandwidth
> and do not need to calibrate the delay loop for secondary cores.
> Remove the boot_lock entirely.

Yup, you're right, this is unnecessary:

Acked-by: Tony Lindgren <tony@atomide.com>
