From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
Date: Fri, 27 Jul 2018 13:29:52 -0700
Message-ID: <1ccdead80a3a4c7a4032f393f3f9a73623c6656f.camel@perches.com>
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
         <98a6d1cd4d313512d66ced3fc25f438449b3c310.camel@perches.com>
         <20180727193641.GA2619@khorivan>
         <f22d3024773abbd811673c4eb957e4a5ffca1387.camel@perches.com>
         <20180727202348.GC2619@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727202348.GC2619@khorivan>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2018-07-27 at 23:23 +0300, Ivan Khoronzhuk wrote:
> For ARM, situation a little bit different:
> $ arm-linux-gnueabihf-gcc -c -O2 -DSWITCH foo.c
> $ size foo.o
>    text	   data	    bss	    dec	    hex	filename
>      32	      0	      0	     32	     20	foo.o
[]
> $ arm-linux-gnueabihf-gcc -c -O2 foo.c
> $ size foo.o
>    text	   data	    bss	    dec	    hex	filename
>      28	      0	      0	     28	     1c	foo.o
[]
> So, it's shorter.

No worries.

I was kinda surprised the object code wasn't identical anyway.

cheers, Joe
