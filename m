From: "rememberme_2000" <rememberme_2000@126.com>
Subject: Is there wrong with io.h???
Date: Tue, 19 Sep 2006 17:00:01 +0800 (CST)
Message-ID: <450FB191.000126.10383@bj126app3.126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 
 
hi:
 i 'd written a simple program.and found some wrong with io.h.
the following code is:
 that:
  #include<asm/arch/gpio.h>
main()
{
omap_request_gpio(3);
omap_set_gpio_direction(3,1);
}  
compile command :
 arm-linux-gcc -I linux-2.6.13.4/include -c main.c
and then i got the following error information:
 linux-2.6.13.4/include/asm/arch/io.h:91 error:parse error before "offset"
 linux-2.6.13.4/include/asm/arch/io.h:97 error:parse error before "offset"
 linux-2.6.13.4/include/asm/arch/io.h:102 error:parse error before "offset".
the toolchains which i used is gcc-3.4.1 for omap 5912,and the kernel is linux-2.6.13.4  for osk.
 Is the file wrong? i'm not sure about it!!!!!!!
            who has interest in it? i hope to get your help. 
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

 
