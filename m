From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: omap flash programming
Date: Mon, 03 Dec 2007 23:28:30 -0600
Message-ID: <4754E57E.5090306@css-design.us>
References: <851794.82307.qm@web7711.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <851794.82307.qm@web7711.mail.in.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kathirvel nachimuthu <use.kathir@yahoo.co.in>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kathir,

There are several ways to accomplish this.  If your board has a working
u-boot flashed in it, then you can do it from the u-boot prompts via
kermit, or tftp.

If you don't have u-boot working yet, then I recommend the u-boot.out
file that comes on the CD.  If you load it and run it, it should flash
u-boot into the system.  Then you can use the kermit/tftp from u-boot to
flash your own bootloader.  Another approach is the USB bootloader,
which will reflash a new u-boot into your board.

I strongly recommend you look at the OSK5912 newbie guide.  Search for
this:  "osk5912 newbie guide" on the web and you get an excellent
document that should help you accomplish what you need.

Steve Poulsen
Communication Systems Solutions

kathirvel nachimuthu wrote:
> hi,
>  I am working with omap5912 based new development.
>  how can flash my boot loader in to my target board.
>  i have ccs version 3.1. 
>  
>  thanks in advance
>  kathir
>  
>  
>        
> ---------------------------------
>  Unlimited freedom, unlimited storage. Get it now
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>   
