From: "Kyungmin Park" <kmpark@infradead.org>
Subject: Re: Reg X-loader compilation Problem
Date: Sat, 22 Sep 2007 15:36:42 +0900
Message-ID: <9c9fda240709212336o1d9b58a0hc8be51f062331cc2@mail.gmail.com>
References: <19B9278CA74D6D4B889A1687EE639202079559@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <19B9278CA74D6D4B889A1687EE639202079559@BLR-SGM-MSG01.wipro.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "aravind.boinpally@wipro.com" <aravind.boinpally@wipro.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

It's simple just use the -mabi=apcs-gnu instead of -mapcs-32.

It is defined arch/arm/Makefile in kernel.
ifeq ((CONFIG_AEABI),y)
CFLAGS_ABI      :=-mabi=aapcs-linux -mno-thumb-interwork
else
CFLAGS_ABI      :=$(call cc-option,-mapcs-32,-mabi=apcs-gnu) $(call
cc-option,-mno-thumb-interwork,)
endif

FYI: Now I posted the OneNAND Initial Program Loader (IPL) support at U-boot

see following URL.
http://permalink.gmane.org/gmane.comp.boot-loaders.u-boot/31896

Thank you,
Kyungmin Park

On 9/21/07, aravind.boinpally@wipro.com <aravind.boinpally@wipro.com> wrote:
> Hi all,
>
> I am facing compilation problem with X-loader.
>
> I have downloaded the X-loader from Linux.omap.com ""x-load_11SEP.tgz"".
>
> Then I have untarred it and changed the ""include/configs/om  file for
> ONENAND support.
>
> After this I tried to compile this using cross tool chain
> "arm-none-Linux-gnueabi-" ,but after doing this i am getting
>
> error like
>
> ""error: unrecognized command line option "-mapcs-32""".
>
> can some one suggest me what could be the problem.
>
> is it problem with tool chain.???
>
> I compiled this code using make3.80 tool.
>
> but when i compiled with make 3.81 also same problem ..
>
> and also version of gcc is 4.1.1
>
> Please give me some inputs
> thanking you.
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
