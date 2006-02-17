From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: problems compiling u-Boot 1.1.4 (2)
Date: Fri, 17 Feb 2006 09:56:43 +0900 (JST)
Message-ID: <20060217.095643.71082850.kaminaga@sm.sony.co.jp>
References: <ae36f8040602151401j4776aaccge3bd4818a95c60c5@mail.gmail.com>
	<20060216.123750.18297871.kaminaga@sm.sony.co.jp>
	<ae36f8040602160414s1af05cdcmf64b14448a894ff3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040602160414s1af05cdcmf64b14448a894ff3@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lvcargnini@ieee.org, lvcargnini@gmail.com
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

> so about toolchain i must recreate the gcc without some options ?

Will you try:
$ arm-linux-gcc -v
and see if there is `--with-float=soft'?

If you can't find this, or --without-float or --with-float=hard, then
your gcc is compiled with hardware FP.
add --with-float=soft when you configure gcc, rebuild gcc, and try again. 

Hope this helps.


Best Regards,

HK.
--
