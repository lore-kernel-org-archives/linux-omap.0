From: Bharathraj Nagaraju <bharathraj.nagaraju-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
Subject: Reg: USB: ehci-omap: Suspend the controller during idle.
Date: Tue, 6 Aug 2013 18:25:32 +0530
Message-ID: <8D86EEFC18AF0D43A2B8E0ABFA8B88A17B16B9455E@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "keshava_mgowda-l0cyMroinI0@public.gmane.org" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, "khilman-l0cyMroinI0@public.gmane.org" <khilman-l0cyMroinI0@public.gmane.org>
Cc: "rogerq-l0cyMroinI0@public.gmane.org" <rogerq-l0cyMroinI0@public.gmane.org>, Bharathraj Nagaraju <bharathraj.nagaraju-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

  Dear All,

  We are working on omap4470 based device,kernel-3.0.31 is running on this.
  In our device modem is connected to OMAP4470 using USB EHCI.

  In our current kernel code, clocks are enabled when ports get connected
  and disabled during disconnect.Due to this current consumption is more in idle use case.

  I have tried to put the host in smart idle/standby mode,due to erratas around Host doesn't allow us
  use smart idle/standby capabilities.

  1) i571: USB host EHCI may stall when entering smart-standby mode
  2) i660: USBHOST Configured In Smart-Idle Can Lead To a Deadlock

  we are thinking to implement USB EHCI runtime suspend/resume feature.

  In kernel-3.0.31 architecture the usbcore driver is parent of ehci and ohci drivers.
  The ehci and ohci drivers call the pm_runtime_get_sync and pm_runtime_put_sync of parent device usbhs core.

  From the ehci-omap driver what i can see only partial implementation of runtime PM.
  what i mean is that runtime PM methods are used only during the normal suspend path
  and when nothing is connected to ports(modem disconnected in our case).

  I am thinking to change the ehci driver code, could claver enough to use runtime PM
  to disable the hardware when modem is connected and the system is in idle state.

  Kindly guide me how can i go about this.

  Let me know if you need further clarification from me on this.

  Thanks for spending your valuable time .......:)


  Cheers
  Bharath

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
