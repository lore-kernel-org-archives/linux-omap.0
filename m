From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: How to use omap keypad driver function
Date: Sat, 19 Aug 2006 19:14:34 +0300
Message-ID: <44E738EA.2080904@cc.jyu.fi>
References: <OF3B719B48.C78BC6D7-ON652571CF.003E457F-652571CF.003EE797@flextronicssoftware.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <OF3B719B48.C78BC6D7-ON652571CF.003E457F-652571CF.003EE797@flextronicssoftware.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Devendra Kumar Madhesia <devendra.madhesia@flextronicssoftware.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Devendra Kumar Madhesia wrote:
>
>
> Hi,
> Thanks for giving such useful idea.
>
> But I have also some doubt.
> The omap keypad driver is based on interrupt.
> Will this idea also useful for  omap keypad driver?
>
> Plz find source code for omap keypad driver from:
> /usr/src/armlinux/linux-2.6.16/drivers/input/keyboard/omap-keypad.c
>
> Best Regards,
> Devendra
>   
Yes, that driver receives creates /dev/input/event(number) to userspace.
(by calling input_allocate_device() method)
and starts listening irq's from the key presses. When it receives irq,
it checks which key was really pressed and uses
input_report_key() method for passing that information to userspace via
/dev/input/event(number) interface.

Note that in this level, you can desire which key events you send to
userspace. In my device I have for example an joypad
that sends always couple of irq's to driver and sending them directly to
userspace would mess apps like gpe-window manager.
(For me the press to right would generate "up-right" and "bottom-right"
events, and instead of passing them, I only send one event
indicating that "right" key were pressed.)

I have not send that driver to omap list because I am not sure would the
omap-keypad driver be the best location for that code.

Mika
