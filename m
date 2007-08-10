From: Kevin Hilman <khilman@mvista.com>
Subject: Re: WARNING at kernel/irq/resend.c:70 check_irq_resend() on OSK
Date: Fri, 10 Aug 2007 14:37:01 -0700
Message-ID: <46BCDA7D.9060004@mvista.com>
References: <46BC9999.30805@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46BC9999.30805@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme wrote:
> 
> While booting on OSK, I get stuff below. Any idea? Note that kernel goes
> on booting and nothing feels broken.
> 

FWIW, I see this on 2430 too.

This is from  some temporary debug code added[1] that made it into
2.6.23-rc2, but was recently removed by Linus[2]

Kevin

[1]
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0fc4969b866671dfe39b1a9119d0fdc7ea0f63e5
[2]
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=88ffc3505988196ef5cfdc0278ad89025c2a7b1a
