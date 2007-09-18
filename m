From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [RFC] [PATCH 0/14] Update OMAP defconfigs
Date: Tue, 18 Sep 2007 18:26:53 +0200
Message-ID: <46EFFC4D.7010402@googlemail.com>
References: <11900606011267-git-send-email-felipe.lima@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11900606011267-git-send-email-felipe.lima@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipe.lima@indt.org.br>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> The following patch series updates the defconfigs for OMAP boards.

Do these updates include functional changes? Or are they only 
non-function-change updates to 2.6.23-rc6-omap1?

E.g. in omap_2430sdp_defconfig there is

-# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_SYSCTL_SYSCALL=y

+CONFIG_OMAP_DEBUG_DEVICES=y

-# CONFIG_MACH_OMAP_H4 is not set
+CONFIG_MACH_OMAP_H4=y

-CONFIG_MACH_OMAP_2430SDP=y
+# CONFIG_MACH_OMAP_2430SDP is not set

-CONFIG_PREEMPT=y
+# CONFIG_PREEMPT is not set

-CONFIG_PM=y
+# CONFIG_PM is not set

-# CONFIG_IRDA is not set
+CONFIG_IRDA=y

...

Regards

Dirk
