From: Marc Zyngier <maz@misterjones.org>
Subject: Re: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
Date: Fri, 12 Jun 2009 18:26:30 +0200
Message-ID: <20090612182630.21cb2eac@life-in-the-fast-lane>
References: <1244768030-23022-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1244768030-23022-1-git-send-email-vikram.pandita@ti.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 11 Jun 2009 19:53:50 -0500
Vikram Pandita <vikram.pandita@ti.com> wrote:

> Boards with serial irq High/Low/Rising/Falling IRQ requirement
> do not work today
> 
> 8250 serial driver does not have provision to pass on IRQ flags
> from platform_device
> 
> This is requred for OMAP Zoom2 board for which Serial IRQ trigger
> is IRQF_TRIGGER_HIGH
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

Arcom Viper (pxa255 based) has the same kind of requirement (triggers
on rising edge), and currently uses a couple of "set_irq_type" that I'd
love to get rid of.

So a patch like this one should definitely be considered.

Best regards,

	M.
-- 
We don't mess around.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
