From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/2] ARM: Kconfig: remove useless "default n"
Date: Wed, 07 Nov 2018 08:57:51 +0100
Message-ID: <87zhull3pc.fsf@belgarion.home>
References: <E1gK0nc-0007fv-En@rmk-PC.armlinux.org.uk>
 <20181106152916.GA56134@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181106152916.GA56134@atomide.com> (Tony Lindgren's message of
 "Tue, 6 Nov 2018 07:29:16 -0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-omap@vger.kernel.org, Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Russell King <rmk+kernel@armlinux.org.uk> [181106 12:49]:
>> The default for Kconfig options is always n, so there's no need to
>> explicitly state a "n" default.
>> 
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> Acked-by: Tony Lindgren <tony@atomide.com>
For mach-pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
