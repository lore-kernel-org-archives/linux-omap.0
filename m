From: "Li Weichen" <iaadoa@gmail.com>
Subject: RE: Can the driver of a wlan card for PC be used in embedded sytems?
Date: Fri, 9 Dec 2005 09:36:40 +0800
Message-ID: <4398dfb2.2bbf6778.705a.ffffbf0b@mx.gmail.com>
References: <7dc7802e0512081656r4077975dm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <7dc7802e0512081656r4077975dm@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'embedos' <embedos@gmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Then you implement the usb 2.0 interface with another chip?  What is your
choice?  The OMAP5912 only supports usb1.1 interface.

 

  _____  

From: embedos [mailto:embedos@gmail.com] 
Sent: Friday, December 09, 2005 8:57 AM
To: Li Weichen
Cc: Linux-omap-open-source@linux.omap.com
Subject: Re: Can the driver of a wlan card for PC be used in embedded
sytems?

 

unfortunately, yes.

you will need usb 2.0 interface to access the full speed of the 80211g wlan
card.

 

2005/12/9, Li Weichen <iaadoa@gmail.com>: 

Then do you connected it to the usb1.1 port of omap?  Will the interface
speed limits the wifi performance? 

 

Thanks again.

 

  _____  

From: embedos [mailto:embedos@gmail.com] 
Sent: Friday, December 09, 2005 12:07 AM 
To: Li Weichen
Cc: Linux-omap-open-source@linux.omap.com
Subject: Re: Can the driver of a wlan card for PC be used in embedded
sytems?

 

You are a lucky guy!

I just did a similiar work today.

you can buy this wlan card: asus w167g (usb)

and get driver from here:

http://rt2x00.serialmonkey.com/rt2570-cvs-daily.tar.gz (for 2.6 kernel)

 

untar,

edit Makefile and specify your kernel source directory,

make arm

insmod ra2570.ko

then using iwconfig to config your wlan card

done




 

2005/12/8, Li Weichen < <mailto:iaadoa@gmail.com>  iaadoa@gmail.com>: 

Hi all,

Is there anybody can tell me that if I can use the wlan card driver for PC
in the embedded system?  I guess that there is something related to the 
interface.  Then if I use usb will it work?  Or do I need to modify some
settings in the source code?

By the way can anybody give me some advice on card selection?  Anything
related to vendors, chips, drivers, interfaces and so on would be helpful. 
Better 802.11g cards.

Thank you all in advance and best regards!

Li Weichen
2005-12-8

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
<http://linux.omap.com/mailman/listinfo/linux-omap-open-source> 

 

 
