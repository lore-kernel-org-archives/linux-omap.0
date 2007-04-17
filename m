From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: cross compiling for OMAP2430
Date: Tue, 17 Apr 2007 08:16:11 -0500
Message-ID: <782515bb0704170616w6fe8e474q2dded08e31d1e409@mail.gmail.com>
References: <57314e840704151059i69c53b63s3fa0f7ad55f0d9bf@mail.gmail.com>
	<57314e840704152213n60788a5arab91296ff0a675d0@mail.gmail.com>
	<462352E1.10600@balister.org>
	<57314e840704161116j72c659ddh884817692f774364@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <57314e840704161116j72c659ddh884817692f774364@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Budhee,

On 4/16/07, Budhee Jamaich <budheej@gmail.com> wrote:
> Hm. Do I have to use such environment ? Can't I just choose the right
> ./configure parameter and the application will be built for the target ?
you may, but you need to look at a case by case basis. for example, if
u want to cross compile for ARM, busybox will need "make ARCH=ARM
CROSS_COMPILE=arm-none-linux-gnueabi-" etc.. some apps dont know the
existance of CROSS_COMPILE.. and they'd use CC for the same, in which
case u'd have to do "make CC=arm-none-linux-gnueabi-gcc"..

personally, i hand compile most of my own stuff, some places, i'd have
to hack arnd "arm-unaware" apps.. but most places it is
straightforward.

I put some links in this discussion thread:
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008841.html
the compiler link and busybox build info might be useful.

Regards,
Nishanth Menon
