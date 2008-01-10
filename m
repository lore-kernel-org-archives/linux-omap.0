From: "Mik Prog" <mikprog@gmail.com>
Subject: Re: OMAP 5912: new kernel, how to create a new file system?
Date: Thu, 10 Jan 2008 09:49:07 +0000
Message-ID: <6a7f58da0801100149jc9462b7r3b844ee3aefa1c1e@mail.gmail.com>
References: <6a7f58da0711200959u1481a90y5b50e9a5c5827c82@mail.gmail.com>
	<4743549A.4070101@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4743549A.4070101@balister.org>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks Phil,

it all worked.
Thanks Jon for your explanation.

Michele

On Nov 20, 2007 9:41 PM, Philip Balister <philip@balister.org> wrote:
> I have a replacement kernel (based on 2.6.22) and root file system here:
>
> http://elinux.org/OSK#Files
>
> Philip
>
> Mik Prog wrote:
>
> > Dear all,
> >
> > I am an absolute beginner with OMAP and Linux (I am working on a OSK 5912).
> > Apologies if some of my questions have already been answered. I do
> > look on google first, but sometime even if the topic has been treated
> > I don't clearly understand...
> >
> > Here my case:
> > 1. I wanted recompile the kernel image using arm-linux-gcc 3.4.1 (I
> > got the kernel sources 2.6.20 and applied the patch
> > patch-2.6.20-omap1)
> > 2. then I enabled on omap_osk-5912_defconf the USB configuration
> > 3. I built the kernel and formatted for u-boot.
> > 4. I transferred that to OMAP using tftpboot
> > 5. $ using uname -a I see that the kernel image is still the old one!
> >
> > Do I need to update the root file system as well?
> > How could I create my own root file system based on the kernel version
> > I've compiled?
> >
> > thanks for any help.
> > Mik
>
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>
