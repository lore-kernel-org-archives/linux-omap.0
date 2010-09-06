From: venki kaps <venkiece2005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] USB: otg: twl4030: fix phy initialization(v1)
Date: Tue, 7 Sep 2010 03:10:30 +0900
Message-ID: <AANLkTinnHiCodvHrSxiMCAQXAETczRiZ+sDu2aQXSeG0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, venkiece2005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Dear USB experts,

  Is the same fix valid for omap3430 + 2.6.32 Kernel?

  I have been facing mp3 playback idle current consumption 20mA more
after booting without USB cable connected
  but If USB cable detach and attach happen, then able to hit proper
values otherwise irrespective of cold/warm reset
  the current values increases to 20mA.

  with cable,
      OTG_SYSCONFIG standby mode of operation - SMART idle
      HSOTGUSB_STANDBY - SMART standby

  without cable,
        OTG_SYSCONFIG standby mode of operation - SMART idle
        HSOTGUSB_STANDBY - Active

  Even i have applied  patch but still the same issue.

  If i use __twl4030_phy_power(twl, 0) at the end of USB LDO initialization,
  then able to hit proper values but USB ADC values are getting in correct
  with Travel adapter (Charger power supply) which means temperature
  shows 84 instead of 26~30 degrees.

  Queries,
  -----------
   - Is Errata 1.164 fix : OTG idle will work on 3430?
   - USBOTG_SUSPEND is enabled in Kernel 32, will it give any impact?
   - Is there anything missed from Power management idle path (or)
    USB OTG controller/Transreceiver driver part?

  Could you please provide the best approach to solve my issue?

  Best Regards,
  Venkappa
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
