From: "Wael Adel" <showairovic@gmail.com>
Subject: OMAP5912 OSK
Date: Tue, 13 Mar 2007 11:29:28 +0200
Message-ID: <bd205c5f0703130229o3e8f84f9m13b7d8e99ff7736@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

hi all,
i want to use the usb of the kit OMAP5912 ,
i want to make a usb gadget driver for it so:

i have downloaded linux kernel 2.6.19 on it successffuly,
and choose omap_udc.c to be a module,
and zero.c also to be a module,(note that it would test the omap_udc)
but unfortunalley,the vendor id and product id is for another chip which is
net2280.

if u dont understand anything from what i say,just check $( kernel source
code )/drivers/usb/gadget to see two files:
1. omap_udc.c         2.zero.c

and my problem is that i want to know the product id and the vendor id for
the usb port in the OMAP5912?
