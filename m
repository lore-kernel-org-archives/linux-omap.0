From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: get_irq_regs() from soft IRQ
Date: Mon, 29 Jun 2009 19:36:57 +0300
Message-ID: <200906291936.57703.siarhei.siamashka@nokia.com>
References: <200906291631.19562.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
In-Reply-To: <200906291631.19562.jpihet@mvista.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: ext Jean Pihet <jpihet@mvista.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

On Monday 29 June 2009 17:31:18 ext Jean Pihet wrote:
> Hi,
>
> I am trying to get the latest IRQ registers from a timer or a work queue
> but I am running into problems:
> - get_irq_regs() returns NULL in some cases, so it is unsuable and even
> causes crash when trying to get the registers values from the returned ptr
> - I never get user space registers, only kernel
>
> The use case is that the performance unit (PMNC) of the Cortex A8 has some
> serious bug, in short the performance counters overflow IRQ is to be
> avoided. The solution I am implementing is to read and reset the counters
> from a work queue that is triggered by a timer.

Regarding this oprofile related part. I wonder how you can get oprofile
working properly (providing non-bogus results) without performance
counters overflow IRQ generation? 

Are you trying to implement (in a clean way) something similar to
http://marc.info/?l=oprofile-list&m=123688347009580&w=2

Or is it going to be a different workaround?

-- 
Best regards,
Siarhei Siamashka

------------------------------------------------------------------------------
