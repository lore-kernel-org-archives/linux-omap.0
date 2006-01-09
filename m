From: "Li Weichen" <iaadoa@gmail.com>
Subject: RE: Toolchain select
Date: Mon, 9 Jan 2006 10:10:01 +0800
Message-ID: <43c1c602.744e24c8.3c58.744e@mx.gmail.com>
References: <1136756932.8961.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1136756932.8961.3.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Matthew Percival' <matthew@capgo.com>, 'Linux OMAP Open Source' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

What version of u-boot are you using?  I use the u-boot-1.1.4 and
u-boot-1.1.3, and my steps is,
$tar xjvf u-boot-1.1.x
$cd u-boot-1.1.x
$make omap5912osk_config
$make

I think there is nothing wrong in my process.

And have you tried building the 2.6.15 kernel?

Regards,

Li Weichen
2006-1-9

> 	That is a make error, not a toolchain one: make does not have a rule
to
> make the said file, and so does not know what to do.  That likely
> indicates that it is a file that either should already be there, or
> created by an earlier process (eg running 'make something_config' type
> operations).  In this case, I can see the file in my examples/
> directory, so likely there is something wrong with your process.  Make
> sure you have followed the steps for compiling u-boot correctly, as you
> do not compile it the same as with most programs.
> 
> 	-- Matthew
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
