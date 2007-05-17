From: Geoffrey Tam <geoffrey@evertz.com>
Subject: RE: Cannot stall an endpoint 0 control transfer from a data stage
	cal lback function
Date: Thu, 17 May 2007 12:35:32 -0400
Message-ID: <0474A5584072DA1197F50007E90E6B1141D483@PORTIA>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'linux-omap-open-source@linux.omap.com'" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

For some reason, this did not make it into the mailing list archive, so I'm
sending again.

-----Original Message-----
From: Geoffrey Tam 
Sent: Monday, May 14, 2007 2:24 PM
To: 'tony@atomide.com'
Cc: 'linux-omap-open-source@linux.omap.com'
Subject: RE: Cannot stall an endpoint 0 control transfer from a data
stage cal lback function


I have tried using g_ep0.c from the linux-omap git tree
(git://source.mvista.com/git/linux-omap-2.6.git). This resulted in compiler
errors.

So, I tried copying all USB files:
- driver/usb/* using "cp -R drivers/usb/*"
- include/linux using "cp include/linux/usb*" and "cp include/linux/usb/*"
This resulted in compiler errors when building the modules using "make
ARCH=arm CROSS_COMPILE=arm_v5t_le- modules". Building the kernel worked
fine. I'm not sure if there is a problem with my config.

I took a look at the code in the git tree. It did not look like any of my
patch was implemented. Perhaps, I grabbed the wrong git tree?

My main problem is I need to stall endpoint 0 from the callback function
when it is called either in the setup or data stage. The code seems to set
the software state machine back to MGC_END0_STAGE_SETUP before the callback
is called. This prevents software from setting the stall condition using
musb_g_ep0_halt(). Also, the driver signals to the hardware before the
callback is called that the data stage has completed. This prevents the
hardware from setting the stall condition from the callback function.

I am not sure why the mass storage gadget fails to enumerate with my fixes.
Unfortunately, my Davinci eval board does not like Linux 2.6.20 - it hangs
shortly after it is loaded. So, I cannot look into this.

I will try again when I get the chance.

Geoffrey

-----Original Message-----
From: tony@atomide.com [mailto:tony@atomide.com]
Sent: Friday, May 11, 2007 2:11 PM
To: Geoffrey Tam
Cc: 'linux-omap-open-source@linux.omap.com'
Subject: Re: Cannot stall an endpoint 0 control transfer from a data
stage cal lback function


* Geoffrey Tam <geoffrey@evertz.com> [070509 11:12]:
> Also sent to 'linux-usb-devel@lists.sourceforge.net'.
> 
> patch was created as per Documentation/SubmittingPatches.

Thanks, I tried it out quickly and looks like the last part of your
patch is already in the linux-omap git tree.

After applying the other parts, the mass storage gadget did not
enumerate though... I'll look into it again when I have a chance.

Do you have any chance to  try the current linux-omap git
tree and see how it works for you, then see what happens with
your patch?

Regards,

Tony
