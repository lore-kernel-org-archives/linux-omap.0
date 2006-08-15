From: David Brownell <david-b@pacbell.net>
Subject: Re: Application to test USB Driver (Linux2.6.16 ) for OMAP5912
Date: Tue, 15 Aug 2006 09:09:49 -0700
Message-ID: <200608150909.50490.david-b@pacbell.net>
References: <BAY21-F6E1F9C570A4A214FB146CF84F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <BAY21-F6E1F9C570A4A214FB146CF84F0@phx.gbl>
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

On Tuesday 15 August 2006 6:57 am, zil iram wrote:
> Hi,
>        I would like to test the USB Device/Gadget Driver in Linux2.6.16 on 
> OMAP5912.
>        Does anyone have an application that demonstrates the usage of the 
> driver?
>        Any help is greatly appreciated. :)

Set up g_ether, "ifconfig usb0 oskname", "ping oskname" from another host.
Also see http://www.linux-usb.org/gadget ...

- Dave
