From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 3/4] Revert "ARM: OMAP4: remove dead kconfig option
 OMAP4_ERRATA_I688"
Date: Wed, 22 Jul 2015 20:13:08 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF740BB3AD2@DLEE11.ent.ti.com>
References: <20150715174647.GA7557@n2100.arm.linux.org.uk>
 <E1ZFQmH-0006GH-22@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1ZFQmH-0006GH-22@rmk-PC.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces@lists.infradead.org] On Behalf Of Russell King
> Sent: Wednesday, July 15, 2015 12:47 PM

> This reverts commit 606da4826b89b044b51e3a84958b802204cfe4c7.
> 
> We actually need this code for proper behaviour of OMAP4, and it needs
> fixing a different way other than just removing the code.  Disabling code
> which is necessary in the hopes of persuing multiplatform kernels is a stupid
> approach.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

The series looks good.  It improves code generation and fixes race issues which have been see production devices running Linux.

Acked-by: Richard Woodruff <r-woodruff2@ti.com>
