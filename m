From: embedos <embedos@gmail.com>
Subject: Re: Can the driver of a wlan card for PC be used in embedded sytems?
Date: Fri, 9 Dec 2005 08:56:37 +0800
Message-ID: <7dc7802e0512081656r4077975dm@mail.gmail.com>
References: <7dc7802e0512080806n3fd10834s@mail.gmail.com>
	<439863e9.622d3de6.25c5.0c75@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <439863e9.622d3de6.25c5.0c75@mx.gmail.com>
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
To: Li Weichen <iaadoa@gmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

unfortunately, yes.
you will need usb 2.0 interface to access the full speed of the 80211g wlan
card.


2005/12/9, Li Weichen <iaadoa@gmail.com>:
>
>  Then do you connected it to the usb1.1 port of omap?  Will the interface
> speed limits the wifi performance?
>
>
>
> Thanks again.
>
>
>   ------------------------------
>
> *From:* embedos [mailto:embedos@gmail.com]
> *Sent:* Friday, December 09, 2005 12:07 AM
> *To:* Li Weichen
> *Cc:* Linux-omap-open-source@linux.omap.com
> *Subject:* Re: Can the driver of a wlan card for PC be used in embedded
> sytems?
>
>
>
> You are a lucky guy!
>
> I just did a similiar work today.
>
> you can buy this wlan card: asus w167g (usb)
>
> and get driver from here:
>
> http://rt2x00.serialmonkey.com/rt2570-cvs-daily.tar.gz (for 2.6 kernel)
>
>
>
> untar,
>
> edit Makefile and specify your kernel source directory,
>
> make arm
>
> insmod ra2570.ko
>
> then using iwconfig to config your wlan card
>
> done
>
>
>
>
>
>
> 2005/12/8, Li Weichen <iaadoa@gmail.com>:
>
> Hi all,
>
> Is there anybody can tell me that if I can use the wlan card driver for P=
C
> in the embedded system?  I guess that there is something related to the
> interface.  Then if I use usb will it work?  Or do I need to modify some
> settings in the source code?
>
> By the way can anybody give me some advice on card selection?  Anything
> related to vendors, chips, drivers, interfaces and so on would be helpful=
.
>
> Better 802.11g cards.
>
> Thank you all in advance and best regards!
>
> Li Weichen
> 2005-12-8
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>
