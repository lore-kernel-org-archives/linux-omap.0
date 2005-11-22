From: "xuxian" <lsfdxuxian@gmail.com>
Subject: RE: OSK5912 USB Port Problem
Date: Tue, 22 Nov 2005 11:21:39 +0800
Message-ID: <43828ec8.6210a9fa.19df.1266@mx.gmail.com>
References: <20051121174914.GA7680@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20051121174914.GA7680@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>, 'Jose Manuel Cano Garcia' <jcgarcia@uma.es>
Cc: 'Linux OMAP Open Source' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

The patch work. Now the OSK can detect the USB key automatically.
Thanks much.

xuxian

-----Original Message-----
From: linux-omap-open-source-bounces+lsfdxuxian=gmail.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+lsfdxuxian=gmail.com@linux.omap.com]
On Behalf Of Tony Lindgren
Sent: Tuesday, November 22, 2005 1:49 AM
To: Jose Manuel Cano Garcia
Cc: Linux OMAP Open Source
Subject: Re: OSK5912 USB Port Problem

* Jose Manuel Cano Garcia <jcgarcia@uma.es> [051121 02:14]:
> Hi,
> 
> I had problems with an USB flash memory, too. I tried several solutions
> and kernels which did not work until I recently read a post on the Linux
> Omap mailing list regarding USB clock malfunction on kernels
> 2.6.12-2.6.14 (which were the ones I have tried). Then, I tried kernel
> 2.6.11 an it worked.

I've noticed that having CONFIG_OMAP_RESET_CLOCKS on kills OHCI at least
on OSK. Juha's patch from few months ago probably helps with that as it
turns on dc_clk:

http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004818.ht
ml

Can you please check if it's caused by this combination? We should get
Juha's patch integrated...

Tony
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
