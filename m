From: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Date: Tue, 09 Aug 2016 13:48:03 +0200
Message-ID: <87vaza2mfg.fsf@dell.be.48ers.dk>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
	<1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
	(Wolfram Sang's message of "Tue, 9 Aug 2016 13:36:17 +0200")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?utf-8?Q?S=C3=B6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seth Heasley <seth.h>
List-Id: linux-omap@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org> writes:

 > The core will do this for us now.
 > Signed-off-by: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
 > ---
 >  drivers/i2c/busses/i2c-ocores.c         | 4 +---

For i2c-ocores.c:

Acked-by: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>

-- 
Bye, Peter Korsgaard
