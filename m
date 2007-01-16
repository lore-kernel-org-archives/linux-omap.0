From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: AW: Help: OMAP5912 RS232 dies after kernel uncompressing.
Date: Mon, 15 Jan 2007 18:58:03 -0600
Message-ID: <45AC231B.5030507@gmail.com>
References: <001201c738e6$c7945890$0700a8c0@NADHHLT01>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <001201c738e6$c7945890$0700a8c0@NADHHLT01>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: JSievers@NADINE-Software.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Juergen Sievers stated on 1/15/2007 2:50 PM:
> But the omap mounts its nfs-root and I can login on the omap by using telnet
>
> So I can not understand how a wrong configured nfs-server might stop the
> ttyS0 
>
>   
Opinion: check your /etc/inittab in the filesystem. maybe you have told
getty to hook on to the wrong terminal... some common issues is the
getty given wrong baud rate OR given tty0 while ttyS0 is being used
etc.. that is a nice place to check.. but do try this: give
"init=/bin/sh" along with ur boot options(given the rest of the
symptoms, this should work).. if u manage to boot off that.. u need to
look deep into ur boot sequence of filesystem -such as rc scripts etc if
you have any.

Regards,
Nishanth Menon
