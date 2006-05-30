From: Jonathan McDowell <noodles@earth.li>
Subject: Re: USB on OMAP 1510 Innovator
Date: Tue, 30 May 2006 10:04:48 +0100
Message-ID: <20060530090448.GA14634@earth.li>
References: <fd1e34b0605290244n498d81a1ua964ee28eddcd617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fd1e34b0605290244n498d81a1ua964ee28eddcd617@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, May 29, 2006 at 03:14:24PM +0530, James Selvam wrote:
> I am trying to use a USB peripheral with USB 2 host on the OMAP 1510
> Innovator. But I am unable to see the device being registered (or
> recognised).
> 
> -> The USB peripheral device be registered in the first place, when system
> boots?
> -> Has anyone successfully used the USB (2) Host with Innovator 1510?

The 1510 only has USB 1 (though a USB 2 peripheral should work, just at
a slower speed). What kernel version are you using? There's a patch that
went into 2.6.16-omap2 that I believe is required for USB to work on the
1510 (it certainly is for the 5910).

You should see some indication in the kernel boot messages about whether
the USB is successfully working or not.

> -> Does the patch submitted by Hiroshi DOYU on this forum on May 8,
> necessarily be applied?

No.

J.

-- 
/-\                             |    Sorry for the inconvenience.
|@/  Debian GNU/Linux Developer |
\-                              |
