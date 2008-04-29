From: "Jonathan Herriott" <herriojr@gmail.com>
Subject: Re: Android on N810 File System Problem
Date: Tue, 29 Apr 2008 15:31:22 -0700
Message-ID: <6a56d69c0804291531i6ddc949au613892259a6496e0@mail.gmail.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com>
	 <48116F5C.9040009@googlemail.com>
	 <20080425183605.GA27479@kedavra.cpe.vivax.com.br>
	 <87fxt7my4o.fsf@nokia.com>
	 <20080427223248.GA5962@kedavra.cpe.vivax.com.br>
	 <20080428233827.GE8449@atomide.com>
	 <20080429124940.20cc88fd.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:11668 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbYD2Wb0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 18:31:26 -0400
Received: by el-out-1112.google.com with SMTP id n30so183403elf.21
        for <linux-omap@vger.kernel.org>; Tue, 29 Apr 2008 15:31:23 -0700 (PDT)
In-Reply-To: <20080429124940.20cc88fd.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Kalle Valo <kalle.valo@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, linux-omap@vger.kernel.org

I actually have another issue, but I don't know if it should still be
in this thread or not.  Anyways, start android, but it just stays on
the red oscillating eye forever.  When I start it the a.sh way, I get
the following output:

/start_android.sh
+ echo Starting Android...
Starting Android...
+ rm -f /media/mmc1/tmp/android-SurfaceFlingerSynchro
/media/mmc1/tmp/contacts_presence.db /media/mmc1/tmp/im_transient.db
/media/mmc1/tmp/messagebus.pid /media/mmc1/tmp/system_bus_socket
+ umount -l /proc
+ umount -l /sys
+ mount -t proc proc /media/mmc1/proc
+ mount -t sysfs sysfs /media/mmc1/sys
+ umask 000
+ chroot /media/mmc1 /a.sh
+ export PATH=/sbin:/system/sbin:/system/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11
+ export LD_LIBRARY_PATH=/system/lib
+ export ANDROID_ROOT=/system
+ export ANDROID_ASSETS=/system/app
+ export ANDROID_DATA=/data
+ export EXTERNAL_STORAGE=/sdcard
+ export DRM_CONTENT=/data/drm/content
+ /system/bin/app_process -Xzygote /system/bin --zygote
+ /system/bin/dbus-daemon --system
+ runtime
+ /system/bin/sh
\h:\w\$ ******** NO FRAMEBUFFER VSYNC WAIT IOCTL **************
 Prepping: /system/app/AlarmProvider.apk:/system/app/Browser.apk:/system/app/Calendar.apk:/system/app/Camera.apk:/system/app/Contacts.apk:/system/app/Development.apk:/system/app/GDataFeedsProvider.apk:/system/app/Gmail.apk:/system/app/GmailProvider.apk:/system/app/GoogleApps.apk:/system/app/GoogleAppsProvider.apk:/system/app/Home.apk:/system/app/ImProvider.apk:/system/app/Maps.apk:/system/app/MediaPickerActivity.apk:/system/app/MediaProvider.apk:/system/app/Phone.apk:/system/app/PimProvider.apk:/system/app/ApiDemos.apk:/system/app/SettingsProvider.apk:/system/app/Sms.apk:/system/app/SyncProvider.apk:/system/app/TelephonyProvider.apk:/system/app/XmppService.apk:/system/app/YouTube.apk
File not found: /system/app/AlarmProvider.apk
File not found: /system/app/Calendar.apk
File not found: /system/app/Camera.apk
File not found: /system/app/GDataFeedsProvider.apk
File not found: /system/app/Gmail.apk
File not found: /system/app/GmailProvider.apk
File not found: /system/app/MediaPickerActivity.apk
File not found: /system/app/PimProvider.apk
File not found: /system/app/ApiDemos.apk
File not found: /system/app/Sms.apk
File not found: /system/app/SyncProvider.apk
File not found: /system/app/YouTube.apk
 Prep complete
fatal error opening "/sys/android_power/last_user_activity"

Does anyone happen to have the patch for this?  Apparently the patch I
received from the N8XX site does not contain it.

On Tue, Apr 29, 2008 at 2:49 AM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> On Mon, 28 Apr 2008 16:38:28 -0700
>  "ext Tony Lindgren" <tony@atomide.com> wrote:
>
>  > I've merged Jarkko's asoc patch to linux-omap for testing. Have not
>  > gotten any sound out of it on my n810 though.. Maybe some alsamixer
>  > settings issue?
>  >
>  Have you set CONFIG_OMAP_MUX? Otherwise McBSP2 pins are muxed for EAC
>  block by the bootloader.
>
>
>  Jarkko
>
