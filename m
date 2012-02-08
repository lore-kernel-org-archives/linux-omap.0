From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3.3] OMAP4: PRM: fix build breakage when CONFIG_OF is
 not defined
Date: Wed, 08 Feb 2012 15:50:30 +0400
Message-ID: <4F326186.8090300@ru.mvista.com>
References: <1328698752-18756-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328698752-18756-1-git-send-email-coelho@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: tony@atomide.com, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 08-02-2012 14:59, Luciano Coelho wrote:

> Since 3.3-rc1, prm44xx.c build breaks if CONFIG_OF is not set:

> arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/prm44xx.o] Error 1

> This is because of a missing include, which is added indirectly if
> CONFIG_OF is defined.  This problem was introduced in commit
> 2f31b51659c2d8315ea2888ba5b93076febe672b

    Please also specify the summary of that commit in parens.

> Cc: Tero Kristo<t-kristo@ti.com>
> Signed-off-by: Luciano Coelho<coelho@ti.com>

WBR, Sergei
