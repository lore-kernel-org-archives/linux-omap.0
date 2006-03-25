From: Madis Listak <madis.listak@mail.ee>
Subject: Re: Modify the usb power budget in OSK
Date: Sat, 25 Mar 2006 12:26:16 +0200
Message-ID: <44251AC8.4030002@mail.ee>
References: <441e6cd5.3aec302a.4058.ffff9d44@mx.gmail.com>
	<42911.212.62.63.56.1143206869.squirrel@webmail.verat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <42911.212.62.63.56.1143206869.squirrel@webmail.verat.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: chief@verat.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,
I still have "over budget" message annoying me,
but my cameras started to work then I compiled
all the modules into the kernel and stopped using
modprobe or insmod modules.
You can try the following:

Device Drivers --->
Multimedia deices --->
<*> Video for Linux				( CONFIG_VIDEO_DEV )

Device Drivers --->
USB support --->
<*> Support for Host-side USB			( CONFIG_USB )
<*>   OHCI HCD support				( CONFIG_USB_OHCI_HCD )

Device Drivers --->
USB support --->
USB Camera support-->
<*>   USB SN9C10x PC Camera Controler support 	( CONFIG_USB_SN9C102 )

Madis


Djordje Nijemcevic wrote:

>Hello,
>
>We have the same problem with our web camera... We're using an external
>power supply for USB.
>
>First, we modified the line in ohci-omap.c
>ohci_to_hcd(ohci)->power_budget = 250;
>to
>ohci_to_hcd(ohci)->power_budget = 500;
>
>After that modification, during the boot process, we still got the message
>"400mA over 100mA budget"
>By searching the files containing string "mA budget", we have found inside
>hub.c
>
>		/* 100mA per-port ceiling, or 8mA for OTG ports */
>		if (i != (udev->bus->otg_port - 1) || hdev->parent)
>			ceiling = 50;
>		else
>			ceiling = 4;
>
>In the rest of the source, the value 'ceiling' is considered as a half the
>maximum power that the USB port can give. After modifying the 'ceiling'
>value from 50 (which corresponds to 100mA) to 250 (corresponds to 500mA)
>we didn't have the boot message mentioned anymore, but the camera still
>doesn't work, nor its LED :( But, you might give a try with this.
>
>It looks strange to me that hub.c is even needed, as well as there is
>100mA limit inside of it. We still doubt that our camera doesn't work due
>to some power budget-related issue. Is something else to be modified?
>
>TIA
>Djordje Nijemcevic
>
>  
>
>>Hi all,
>>
>>I am trying to plug a D-Link DWL-G122 802.11g wlan usb stick on to OSK.
>>But
>>I always get the "over power budget" warning, should I modify the power
>>budget set in drivers/usb/host/ohci-omap.c?  Has anyone ever succeeded to
>>utilize a similar usb stick?
>>
>>And, I have tried to use a extra wire to get power supply from a PC usb
>>port, the errors were still.
>>
>>I am so eagerly looking forward to your help, thank you in advance.
>>
>>Best regards!
>>
>>
>>Li Weichen
>>
>>_______________________________________________
>>Linux-omap-open-source mailing list
>>Linux-omap-open-source@linux.omap.com
>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>>    
>>
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>  
>
