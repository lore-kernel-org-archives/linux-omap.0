From: "Kalle Vahlman" <kalle.vahlman@gmail.com>
Subject: Re: Nokia Internet Tablets
Date: Tue, 23 Dec 2008 13:14:41 +0200
Message-ID: <177e83dd0812230314s333aa653gb8f702fe800a7c53@mail.gmail.com>
References: <20081222103422.GL29448@guug.org> <20081222140137.GD12324@swansys>
	 <20081223093445.69d761e5.jarkko.nikula@nokia.com>
	 <9093790D-6A94-435F-9A7F-275BA33A9AB0@student.utwente.nl>
	 <20081223113431.fd2fed0c.jarkko.nikula@nokia.com>
	 <755A14F3-D549-46A2-A1C0-9F827F518543@student.utwente.nl>
Reply-To: zuh@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:59277 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbYLWLOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 06:14:44 -0500
Received: by ug-out-1314.google.com with SMTP id 39so774913ugf.37
        for <linux-omap@vger.kernel.org>; Tue, 23 Dec 2008 03:14:42 -0800 (PST)
In-Reply-To: <755A14F3-D549-46A2-A1C0-9F827F518543@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

2008/12/23 Koen Kooi <k.kooi@student.utwente.nl>:
>
> Op 23 dec 2008, om 10:34 heeft Jarkko Nikula het volgende geschreven:
>
>> On Tue, 23 Dec 2008 10:04:24 +0100
>> "ext Koen Kooi" <k.kooi@student.utwente.nl> wrote:
>>
>>> have you tried http://cgit.pingu.fi/xf86-video-omapfb/ yet? That
>>> should give you XV and it shouldn't need an xorg.conf.
>>>
>> Thanks for info! Do you know does it support standard xset commands,
>> i.e. setting the different blanking modes?
>
> It shares a lot of code with xf86-video-fbdev, but I don't know if the
> blanking code made it into the driver. Kalle, do you know if blanking works?

For the extent that omapfb offers it (well, at least the driver
present on the Nokia kernel for N8x0), yes.

The DPMS support is implemented in:
  http://cgit.pingu.fi/xf86-video-omapfb/tree/src/omapfb-driver.c#n728

and as the comments indicate, I only saw on/off settings in the omapfb
kernel driver. The xf86-video-fbdev tries to set the standby and
suspend modes and fails (you'll get some "ioctl failed" message about
it), but can't remember if it manages to blank it properly for off (I
suppose so).

To circumvent that, I opted for simply setting the VESA_POWERDOWN mode
for all of the standby, suspend and off modes. The plan is to adjust
the brightness for at least standby, maybe even for suspend, so you
can use DPMS to do the usual "dim quickly, turn off later" pattern.

-- 
Kalle Vahlman, zuh@iki.fi
Powered by http://movial.fi
Interesting stuff at http://sandbox.movial.com
See also http://syslog.movial.fi
