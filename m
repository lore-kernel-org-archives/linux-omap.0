From: Kristian Mueller <Kristian-M@kristian-m.de>
Subject: Re: kernel modules needed while compiling kernel
Date: Wed, 07 Dec 2005 03:17:32 +0100
Message-ID: <1133921853.3008.22.camel@pismo>
References: <4395507f.46b2ece5.78e3.2fb4@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4395507f.46b2ece5.78e3.2fb4@mx.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Li Weichen <iaadoa@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Li

> I encountered a problem while compiling buidroot.  If I select the hotplug
> package, the compiling will lookup the root/lib/modules/2.6.x directory.
> Does it mean that I should compile the kernel here first?

I found that there is also a "diet hotplug", which could be more
suitable for small systems and can be even used in initd.rd images.
Although it seems to be in an early state and has not changed since
August 2001.

Anyway hotplug needs the kernel include files and the modules to link.
Maybe you can append the INSTALL_MOD_PATH=`pwd`/modules/ 
to your kernel make after you finished building buildroot without
hotplug and build hotplug (udev) after that.


Best Regards
Kristian
