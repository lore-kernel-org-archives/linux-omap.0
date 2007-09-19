From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: HS USB support for 2.6.14 V4 kernel
Date: Wed, 19 Sep 2007 11:42:11 -0400
Message-ID: <31e679430709190842s1b92e1d2yac9765d2c48c14c3@mail.gmail.com>
References: <c04186510709190826x7d5d5c0fwf934f52b30c0136@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <c04186510709190826x7d5d5c0fwf934f52b30c0136@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: sandeep prabhu <sandeep.mitian@gmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 9/19/07, sandeep prabhu <sandeep.mitian@gmail.com> wrote:
> Hello all,
>
> I am using 2.6.14 V4 kernel on 2430SDP board, trying to bring up the High
> Speed USB (Inventra core) on ISP1504 OTG.
> I could able to configure and detect the SDP board as ethernet Gadget
> device, but I could not use ISP1504 as USB-Host.
>
> I am using the following DIP switch settings:
>
> S6 - 2 ------> ON
> S6 - 6 ------> OFF
> S6 - 7 ------> OFF
>
> I am getting "musb_hdrc.0" interrupts when I plug an USB Hub, but  no
> interrupts are generated when
> I insert a device like mouse or memory stick.
>
> Could anyone able to use ISP1504 as USB host ? is there any other kernel
> version
> where the High Speed USB on ISP1504 OTG is working ?

increase the verbosity of output a bit:

echo D3 > /proc/driver/musb_hdrc

you'll see every interrupt happening.

also, try to attach a self-powered hub to 2430 and the mouse to the
hub. It might help also.

report again with dmesg output regarding tusb/musb:
dmesg | grep usb

>
> --
> Thanks in Advance,
> Sandeep
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
