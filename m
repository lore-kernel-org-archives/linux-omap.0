From: Mark Howell <mhowell@northlink.com>
Subject: Re: OMAP 5912 OSK: request_module error
Date: Sun, 20 Nov 2005 22:54:56 -0700
Message-ID: <43816130.3050903@northlink.com>
References: <1132401717.2528.17.camel@vineet.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1132401717.2528.17.camel@vineet.linux>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Vineet Tuli <vineet@cybernetra.com>
Cc: OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Vineet Tuli wrote:
> I compiled my own Busybox. When i boot OMAP5912 OSK using kernel
> 2.6.14.2 i get the following error
> 
> ......................
> Freeing init memory:108K
> request_module: runaway loop modprobe binfmt-464c
> 
> and then OSK hangs.
> 
> Please help.
> 
> Thanks in advance
> 
> Vineet Tuli
> 
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> 
> 

Hello Vineet, a thought...

Make sure you have a getty turned on at the serial console. An easy
thing to miss when first trying a new rootfs... well for me anyway.

e.g., in /etc/inittab:

ttyS0::respawn:/sbin/getty -L ttyS0 115200 vt100

First time I built a rootfs with buildroot (cousin project to busybox at
uclibc.org), I forgot this, and it looked like the system was hanging in
init, but really everything was fine except the system wasn't listening
to the serial console for logins. In buildroot, the line above exists in
the default inittab, but is commented out.

Cheers,

Mark.
