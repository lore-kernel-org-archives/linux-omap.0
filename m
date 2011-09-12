From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 10/10] hwspinlock: add MAINTAINERS entries
Date: Mon, 12 Sep 2011 09:58:04 -0700
Message-ID: <1315846684.31609.1.camel@Joe-Laptop>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
	<1315846025-11453-11-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315846025-11453-11-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2011-09-12 at 19:47 +0300, Ohad Ben-Cohen wrote:
> Update MAINTAINERS with entries for hwspinlock/core and hwspinlock/omap
> files.

trivial:

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -2953,6 +2953,14 @@ F:	Documentation/hw_random.txt
[]
> +HARDWARE SPINLOCK CORE
> +M:	Ohad Ben-Cohen <ohad@wizery.com>
> +S:	Maintained
> +F:	Documentation/hwspinlock.h

F:	Documentation/hwspinlock.txt

> +F:	drivers/hwspinlock/hwspinlock_core.c
> +F:	drivers/hwspinlock/hwspinlock_internal.h

Maybe
F:	drivers/hwspinlock/hwspinlock_*

> +F:	include/linux/hwspinlock.h
