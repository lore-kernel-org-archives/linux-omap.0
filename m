From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: Re: about OMAP usb Speed?
Date: Thu, 12 Apr 2007 14:05:53 +0300
Message-ID: <461E1291.4060101@indt.org.br>
References: <bd205c5f0704111728u57837375j22960eed269e4489@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <bd205c5f0704111728u57837375j22960eed269e4489@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Wael Adel <showairovic@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Wael,



ext Wael Adel wrote:
> hi all,
> i have an OMAP-OSK5912, as for its usb bus i know that it is a
> full-speed (12Mbps)
> isnt there any way or any patch that make it support for high-speed 
> (240Mbps)?

The speed of the device is defined by the USB Controller it's using. So 
it's hardware related. To change the speed from USB 1.1 to USB 2.0 you 
should change the controller.

There's no way to do it in software :-)

> 
> or it is an impossible to do that?
> if it is impossible tell me why please?
> 
> thanks in advance
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source


Best Regards,

Felipe Balbi
felipe.lima@indt.org.br
+55 92 2126-1003

Kernel Developers Team
