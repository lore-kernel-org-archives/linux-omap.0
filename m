From: "Juergen Sievers" <JSievers@NADINE-Software.com>
Subject: AW: AW: Help: OMAP5912 RS232 dies after kernel uncompressing.
Date: Tue, 16 Jan 2007 13:01:51 +0100
Message-ID: <000101c73966$1d1f33a0$0700a8c0@NADHHLT01>
References: <45AC231B.5030507@gmail.com>
Reply-To: JSievers@NADINE-Software.com
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45AC231B.5030507@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Nishanth Menon' <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Nishanth.

That is a good hint and I did this already but it was not the reason.

Normal, before the ttyS0 was missing, the kernel's initializing messages
were shown on the rs323 line. But now - nothing appears after the kernel
code gets control.

I will try to reset the whole environment block to create a new and well
formatted environment. It seems to me something is wrong on these persistent
environment settings. Possible I have typed in an invisible control
character in one of these settings.

Mfg.
Juergen


> Opinion: check your /etc/inittab in the filesystem. maybe you have told
> getty to hook on to the wrong terminal... some common issues is the
> getty given wrong baud rate OR given tty0 while ttyS0 is being used
> etc.. that is a nice place to check.. but do try this: give
> "init=/bin/sh" along with ur boot options(given the rest of the
> symptoms, this should work).. if u manage to boot off that.. u need to
> look deep into ur boot sequence of filesystem -such as rc scripts etc if
> you have any.
> 
> Regards,
> Nishanth Menon
